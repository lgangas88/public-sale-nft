import 'package:json_annotation/json_annotation.dart';

part 'nft_metadata.g.dart';

@JsonSerializable()
class NFTMetadata {
  NFTMetadata({
    required this.name,
    required this.description,
    required this.image,
    required this.attributes,
  });

  String name;
  String description;
  String image;
  List<NFTMetadataAttribute> attributes;

  factory NFTMetadata.fromJson(Map<String, dynamic> json) {
    return _$NFTMetadataFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NFTMetadataToJson(this);
}

@JsonSerializable()
class NFTMetadataAttribute {
  NFTMetadataAttribute({
    required this.traitType,
    required this.value,
  });

  @JsonKey(name: 'trait_type')
  String traitType;
  String value;

  factory NFTMetadataAttribute.fromJson(Map<String, dynamic> json) {
    return _$NFTMetadataAttributeFromJson(json);
  }

  Map<String, dynamic> toJson() => _$NFTMetadataAttributeToJson(this);
}
