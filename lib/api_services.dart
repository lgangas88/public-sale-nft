import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:nft_public_sale/models/get_ipfs_resource_response.dart';
import 'package:nft_public_sale/models/get_resource_from_pinata_response.dart';
import 'package:nft_public_sale/models/nft_metadata.dart';

class ApiServices {
  //https://dweb.link/api/v0/ls?arg=QmVZkuCVeMStEYnYj1vFYDEdggwoQ2evHFn7wmj97RMUmf
  Future<GetIPFSResource> getIPFSResource(String cid) async {
    final url = Uri.parse('https://dweb.link/api/v0/ls?arg=$cid');
    final response = await http.get(url);
    return GetIPFSResource.fromJson(jsonDecode(response.body));
  }

  Future<GetResourcesFromPinata> getResourcesFromPinata() async {
    final url = Uri.parse('https://api.pinata.cloud/data/pinList');
    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer ${dotenv.env['PINATA_API_KEY']}'},
    );
    return GetResourcesFromPinata.fromJson(jsonDecode(response.body));
  }

  Future<NFTMetadata> getNFTMetadata(String cid) async {
    final url = Uri.parse('https://ipfs.io/ipfs/$cid');
    final response = await http.get(url, headers: {'Content-Type': 'application/json'});
    return NFTMetadata.fromJson(jsonDecode(response.body));
  }
}
