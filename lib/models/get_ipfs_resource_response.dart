import 'package:json_annotation/json_annotation.dart';

part 'get_ipfs_resource_response.g.dart';

@JsonSerializable()
class GetIPFSResource {
  GetIPFSResource({
    required this.objects,
  });
  @JsonKey(name: 'Objects')
  List<GetIPFSResourceObject> objects;

  factory GetIPFSResource.fromJson(Map<String, dynamic> json) =>
      _$GetIPFSResourceFromJson(json);

  Map<String, dynamic> toJson() => _$GetIPFSResourceToJson(this);
}

@JsonSerializable()
class GetIPFSResourceObject {
  GetIPFSResourceObject({
    required this.hash,
    required this.links,
  });

  @JsonKey(name: 'Hash')
  String hash;
  @JsonKey(name: 'Links')
  List<GetIPFSResourceLink> links;

  factory GetIPFSResourceObject.fromJson(Map<String, dynamic> json) =>
      _$GetIPFSResourceObjectFromJson(json);

  Map<String, dynamic> toJson() => _$GetIPFSResourceObjectToJson(this);
}

@JsonSerializable()
class GetIPFSResourceLink {
  GetIPFSResourceLink({
    required this.name,
    required this.hash,
    required this.size,
    required this.type,
    required this.target,
  });
  @JsonKey(name: 'Name')
  String name;
  @JsonKey(name: 'Hash')
  String hash;
  @JsonKey(name: 'Size')
  int size;
  @JsonKey(name: 'Type')
  int type;
  @JsonKey(name: 'Target')
  String target;

  factory GetIPFSResourceLink.fromJson(Map<String, dynamic> json) =>
      _$GetIPFSResourceLinkFromJson(json);

  Map<String, dynamic> toJson() => _$GetIPFSResourceLinkToJson(this);
}
