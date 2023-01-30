import 'package:alchemy_web3/alchemy_web3.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AlchemyService {
  final alchemy = Alchemy();

  AlchemyService() {
    alchemy.init(
      httpRpcUrl: dotenv.env['POLYGON_HTTPS_URL']!,
      wsRpcUrl: dotenv.env['POLYGON_WS_URL']!,
    );
  }

  Future<List<EnhancedNFT>> getNFTsByOwner(String address) async {
    final response = await alchemy.enhanced.nft.getNFTs(owner: address);
    return response.isRight ? response.right.ownedNfts : [];
  }
}
