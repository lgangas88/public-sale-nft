import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:nft_public_sale/app_provider.dart';
import 'package:nft_public_sale/models/nft.dart';
import 'package:nft_public_sale/models/nft_metadata.dart';
import 'package:nft_public_sale/pages/home_page.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:web3dart/web3dart.dart';

class NFTDetailPage extends StatefulWidget {
  static String routeName = '/detail-page';
  const NFTDetailPage({
    super.key,
    required this.nft,
  });

  final NFT nft;

  @override
  State<NFTDetailPage> createState() => _NFTDetailPageState();
}

class _NFTDetailPageState extends State<NFTDetailPage> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void showSaleModal() {
    showDialog(
      context: context,
      useRootNavigator: false,
      barrierDismissible: false,
      builder: (_) {
        return Dialog(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SpinKitCubeGrid(
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(height: 16),
                const Text('Comprando NFT'),
              ],
            ),
          ),
        );
      },
    );
  }

  void onBuyNFT() async {
    final provider = context.read<AppProvider>();
    if (provider.session == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Inicie sesión con Metamask.'),
        ),
      );
      return;
    }
    showSaleModal();

    final hash = await provider.buyNft(widget.nft.id!);

    if (hash == null || !hash.contains('0x')) {
      if (mounted) Navigator.pop(context);
      return;
    }

    StreamSubscription? subscription;
    subscription = Stream<Future<TransactionReceipt?>>.periodic(
      const Duration(seconds: 4),
      (_) async {
        return await provider.client.getTransactionReceipt(hash);
      },
    ).listen((event) {
      event.then(
        (value) {
          if (value != null) {
            if (value.status!) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'La transacción se realizó con éxito. Pronto tendrás tu NFT.'),
                ),
              );
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                    'La transacción no se realizó con éxito. Revise en Etherscan.',
                  ),
                ),
              );
            }
            Navigator.of(context)
                .popUntil(ModalRoute.withName(HomePage.routeName));
            subscription?.cancel();
          }
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Stack(
        children: [
          Positioned.fill(
            child: Hero(
              tag: 'nft-${widget.nft.id}',
              child: Image.network(
                widget.nft.url,
                fit: BoxFit.fitHeight,
              ),
            ),
          ),
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Spacer(flex: 3),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: FutureBuilder(
                        future: context
                            .read<AppProvider>()
                            .getNFTMetadata(widget.nft.id!),
                        builder: (_, snapshot) {
                          if (!snapshot.hasData) {
                            return const _DetailLoader();
                          }

                          return _NFTDetail(nftMetadata: snapshot.data!);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: widget.nft.enabled
          ? FloatingActionButton(
              onPressed: onBuyNFT,
              child: const Icon(Icons.sell),
            )
          : null,
    );
  }
}

class _DetailLoader extends StatelessWidget {
  const _DetailLoader({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey.shade500,
      highlightColor: Colors.grey.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 120,
            color: Colors.black,
          ),
          const SizedBox(height: 12),
          Container(
            height: 20,
            width: double.infinity,
            color: Colors.black,
          ),
          const SizedBox(height: 24),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              Chip(
                label: Text('    '),
              ),
              Chip(
                label: Text('    '),
              ),
              Chip(
                label: Text('    '),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _NFTDetail extends StatelessWidget {
  const _NFTDetail({
    Key? key,
    required this.nftMetadata,
  }) : super(key: key);

  final NFTMetadata nftMetadata;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          nftMetadata.name,
          style: Theme.of(context).textTheme.headline4!.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 12),
        Text(
          nftMetadata.description,
          style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (var attr in nftMetadata.attributes)
              Chip(
                label: Text(attr.value),
              ),
          ],
        ),
      ],
    );
  }
}
