// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nft_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NFTMetadata _$NFTMetadataFromJson(Map<String, dynamic> json) => NFTMetadata(
      name: json['name'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      attributes: (json['attributes'] as List<dynamic>)
          .map((e) => NFTMetadataAttribute.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$NFTMetadataToJson(NFTMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'attributes': instance.attributes,
    };

NFTMetadataAttribute _$NFTMetadataAttributeFromJson(
        Map<String, dynamic> json) =>
    NFTMetadataAttribute(
      traitType: json['trait_type'] as String,
      value: json['value'] as String,
    );

Map<String, dynamic> _$NFTMetadataAttributeToJson(
        NFTMetadataAttribute instance) =>
    <String, dynamic>{
      'trait_type': instance.traitType,
      'value': instance.value,
    };
