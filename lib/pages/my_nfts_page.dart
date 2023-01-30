import 'package:flutter/material.dart';
import 'package:nft_public_sale/app_provider.dart';
import 'package:nft_public_sale/pages/nft_list_page.dart';
import 'package:provider/provider.dart';

class MyNFTsPage extends StatefulWidget {
  static String routeName = '/my-nfts-page';
  const MyNFTsPage({super.key});

  @override
  State<MyNFTsPage> createState() => _MyNFTsPageState();
}

class _MyNFTsPageState extends State<MyNFTsPage> {
  @override
  void initState() {
    super.initState();
    context.read<AppProvider>().getMyNFTs();
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<AppProvider>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mis NFTs'),
      ),
      body: NFTList(
        nftList: provider.myNFTList,
        onRefresh: provider.getMyNFTs,
      ),
    );
  }
}
