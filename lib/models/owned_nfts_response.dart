import 'package:json_annotation/json_annotation.dart';

part 'owned_nfts_response.g.dart';

@JsonSerializable()
class OwnedNfTsResponse {
  OwnedNfTsResponse({
    required this.ownedNfts,
    required this.totalCount,
    required this.blockHash,
  });

  List<OwnedNft> ownedNfts;
  int totalCount;
  String blockHash;

  factory OwnedNfTsResponse.fromJson(Map<String, dynamic> json) =>
      _$OwnedNfTsResponseFromJson(json);
}

@JsonSerializable()
class OwnedNft {
  OwnedNft({
    required this.id,
    required this.title,
    required this.description,
    required this.timeLastUpdated,
  });

  OwnedNftId id;
  String title;
  String description;
  DateTime timeLastUpdated;

  factory OwnedNft.fromJson(Map<String, dynamic> json) =>
      _$OwnedNftFromJson(json);
}

@JsonSerializable()
class OwnedNftId {
  OwnedNftId({
    required this.tokenId,
  });

  String tokenId;

  factory OwnedNftId.fromJson(Map<String, dynamic> json) =>
      _$OwnedNftIdFromJson(json);
}
