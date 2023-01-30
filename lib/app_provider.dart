import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:nft_public_sale/alchemy_service.dart';
import 'package:nft_public_sale/api_services.dart';
import 'package:nft_public_sale/models/get_resource_from_pinata_response.dart';
import 'package:nft_public_sale/models/nft.dart';
import 'package:nft_public_sale/models/nft_metadata.dart';
import 'package:nft_public_sale/public_sale_contract_service.dart';
import 'package:nft_public_sale/utils.dart';
import 'package:nft_public_sale/wallet_connect_ethereum_credentials.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:walletconnect_dart/walletconnect_dart.dart';
import 'package:web3dart/web3dart.dart';

class AppProvider extends ChangeNotifier {
  late WalletConnect connector;
  late Web3Client client;
  final PublicSaleContractService contract = PublicSaleContractService();
  final ApiServices services = ApiServices();
  final AlchemyService alchemyService = AlchemyService();

  String? _uri;
  SessionStatus? session;

  List<NFT>? nftList;
  List<NFT>? myNFTList;

  GetResourcesFromPinata? responsePinata;

  void init() {
    initWalletConnect();
    getNFTList();
  }

  Future getNFTList() async {
    try {
      responsePinata = await services.getResourcesFromPinata();
      final getRow = responsePinata!.rows
          .firstWhere((e) => e.metadata.name == 'images_30');
      final responseResource =
          await services.getIPFSResource(getRow.ipfsPinHash);

      final getEnableNFtsResponse = await client.call(
        contract: contract.contract,
        function: contract.getEnableNFtsFunction,
        params: [],
      );

      final enabledList = (getEnableNFtsResponse[0] as List).sublist(
        0,
        getEnableNFtsResponse[1]?.toInt(),
      );

      nftList = responseResource.objects.first.links.map((e) {
        final id = e.name.split('.')[0];
        final nft = NFT(
          hash: getRow.ipfsPinHash,
          id: int.parse(id),
        );
        nft.setEnabled(enabledList.contains(BigInt.from(nft.id!)));
        return nft;
      }).toList();
    } catch (e) {
      print(e);
    } finally {
      notifyListeners();
    }
  }

  Future getMyNFTs() async {
    try {
      final response =
          await alchemyService.getNFTsByOwner(session!.accounts.first);
      myNFTList = response.map((e) {
        final rawSplitted = e.media.first.raw.split('/');
        final hash = rawSplitted[rawSplitted.length - 2];
        final id = rawSplitted[rawSplitted.length - 1].split('.')[0];
        return NFT(
          hash: hash,
          id: int.parse(id),
        )..setEnabled(false);
      }).toList();
    } catch (e) {
      print('Error $e');
    } finally {
      notifyListeners();
    }
  }

  void initWalletConnect() {
    connector = WalletConnect(
      bridge: 'https://bridge.walletconnect.org',
      clientMeta: const PeerMeta(
        name: 'NFT Public Sale',
        description: 'An app for buying NFTs',
        url: 'https://walletconnect.org',
      ),
    );
    client = Web3Client(getChainUrl(5), Client());
  }

  void loginWithMetamask() async {
    SessionStatus session = await connector.connect(onDisplayUri: (uri) async {
      _uri = uri;
      await launchUrlString(uri, mode: LaunchMode.externalApplication);
    });
    this.session = session;
    notifyListeners();
  }

  Future<String?> buyNft(int nftId) async {
    try {
      if (session == null) return null;

      final nonce = await client.getTransactionCount(
          EthereumAddress.fromHex(session!.accounts.first));

      final transaction = await contract.getPurchaseNFTByIdTransaction(
          nftId, session!.accounts.first,
          nonce: nonce);

      EthereumWalletConnectProvider provider =
          EthereumWalletConnectProvider(connector);
      launchUrlString(_uri!, mode: LaunchMode.externalApplication);
      final cred = WalletConnectEthereumCredentials(provider: provider);
      final op = await client.sendTransaction(
        cred,
        transaction,
      );
      return op;
    } catch (e) {
      print('Error $e');
      return null;
    } finally {
      notifyListeners();
    }
  }

  Future<NFTMetadata> getNFTMetadata(int nftId) async {
    final getRow =
        responsePinata!.rows.firstWhere((e) => e.metadata.name == 'metada_30');
    final responseResource = await services.getIPFSResource(getRow.ipfsPinHash);
    final cid = responseResource.objects.first.links
        .firstWhere((e) => e.name.contains(nftId.toString()))
        .hash;

    final metadataResponse = await services.getNFTMetadata(cid);
    return metadataResponse;
  }

  Stream listenForPurchase() {
    return client
        .events(FilterOptions.events(
            contract: contract.contract, event: contract.deliverNFTEvent))
        .take(1);
  }

  Stream listenForTest() {
    return client
        .events(FilterOptions.events(
            contract: contract.contract, event: contract.testNFTEvent))
        .take(1);
  }
}
