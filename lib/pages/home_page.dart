import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:nft_public_sale/app_provider.dart';
import 'package:nft_public_sale/pages/my_nfts_page.dart';
import 'package:nft_public_sale/pages/nft_list_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  static String routeName = '/';
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<AppProvider>().init();
    context.read<AppProvider>().listenForTest().listen((event) {
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Evento de prueba!')));
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return Scaffold(
      appBar: _appBar(provider),
      body: PageView(
        children: [
          NFTList(
            nftList: provider.nftList,
            onRefresh: provider.getNFTList,
            showAsEnabled: false,
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {},
      //   child: const Icon(Icons.shuffle_rounded),
      // ),
    );
  }

  AppBar _appBar(AppProvider provider) {
    return AppBar(
      title: const Text(
        'NFT Public Sale',
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed:
              provider.session != null ? () {} : provider.loginWithMetamask,
          icon: provider.session != null
              ? _avatarAuthenticated(provider.session!.accounts.first)
              : const Image(
                  image: Svg('assets/images/metamask.svg'),
                ),
        ),
      ],
    );
  }

  PopupMenuButton<String> _avatarAuthenticated(String address) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        if (value == 'my-nfts') {
          Navigator.of(context).pushNamed(MyNFTsPage.routeName);
        } else if (value == 'approve-token') {}
      },
      itemBuilder: (context) => [
        // const PopupMenuItem(
        //   value: 'approve-token',
        //   child: Text('Aprobar MPRTKN'),
        // ),
        const PopupMenuItem(
          value: 'my-nfts',
          child: Text('Mis NFTs'),
        ),
      ],
      offset: const Offset(0, 52),
      child: Builder(builder: (context) {
        return CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          foregroundImage: Svg(
            'https://api.dicebear.com/5.x/pixel-art/svg?seed=$address',
            source: SvgSource.network,
          ),
          radius: 24,
        );
      }),
    );
  }
}
