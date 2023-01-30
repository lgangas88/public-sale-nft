import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:nft_public_sale/app_provider.dart';
import 'package:nft_public_sale/models/nft.dart';
import 'package:nft_public_sale/pages/home_page.dart';
import 'package:nft_public_sale/pages/my_nfts_page.dart';
import 'package:nft_public_sale/pages/nft_detail_page.dart';
import 'package:provider/provider.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => AppProvider(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
        ),
        routes: {
          HomePage.routeName: (_) => const HomePage(),
          NFTDetailPage.routeName: (context) {
            final nft = ModalRoute.of(context)!.settings.arguments! as NFT;
            return NFTDetailPage(nft: nft);
          },
          MyNFTsPage.routeName: (_) => const MyNFTsPage(),
        },
      ),
    );
  }
}
