// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owned_nfts_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OwnedNfTsResponse _$OwnedNfTsResponseFromJson(Map<String, dynamic> json) =>
    OwnedNfTsResponse(
      ownedNfts: (json['ownedNfts'] as List<dynamic>)
          .map((e) => OwnedNft.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: json['totalCount'] as int,
      blockHash: json['blockHash'] as String,
    );

Map<String, dynamic> _$OwnedNfTsResponseToJson(OwnedNfTsResponse instance) =>
    <String, dynamic>{
      'ownedNfts': instance.ownedNfts,
      'totalCount': instance.totalCount,
      'blockHash': instance.blockHash,
    };

OwnedNft _$OwnedNftFromJson(Map<String, dynamic> json) => OwnedNft(
      id: OwnedNftId.fromJson(json['id'] as Map<String, dynamic>),
      title: json['title'] as String,
      description: json['description'] as String,
      timeLastUpdated: DateTime.parse(json['timeLastUpdated'] as String),
    );

Map<String, dynamic> _$OwnedNftToJson(OwnedNft instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'timeLastUpdated': instance.timeLastUpdated.toIso8601String(),
    };

OwnedNftId _$OwnedNftIdFromJson(Map<String, dynamic> json) => OwnedNftId(
      tokenId: json['tokenId'] as String,
    );

Map<String, dynamic> _$OwnedNftIdToJson(OwnedNftId instance) =>
    <String, dynamic>{
      'tokenId': instance.tokenId,
    };
