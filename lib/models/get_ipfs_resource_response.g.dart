// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_ipfs_resource_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetIPFSResource _$GetIPFSResourceFromJson(Map<String, dynamic> json) =>
    GetIPFSResource(
      objects: (json['Objects'] as List<dynamic>)
          .map((e) => GetIPFSResourceObject.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetIPFSResourceToJson(GetIPFSResource instance) =>
    <String, dynamic>{
      'Objects': instance.objects,
    };

GetIPFSResourceObject _$GetIPFSResourceObjectFromJson(
        Map<String, dynamic> json) =>
    GetIPFSResourceObject(
      hash: json['Hash'] as String,
      links: (json['Links'] as List<dynamic>)
          .map((e) => GetIPFSResourceLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetIPFSResourceObjectToJson(
        GetIPFSResourceObject instance) =>
    <String, dynamic>{
      'Hash': instance.hash,
      'Links': instance.links,
    };

GetIPFSResourceLink _$GetIPFSResourceLinkFromJson(Map<String, dynamic> json) =>
    GetIPFSResourceLink(
      name: json['Name'] as String,
      hash: json['Hash'] as String,
      size: json['Size'] as int,
      type: json['Type'] as int,
      target: json['Target'] as String,
    );

Map<String, dynamic> _$GetIPFSResourceLinkToJson(
        GetIPFSResourceLink instance) =>
    <String, dynamic>{
      'Name': instance.name,
      'Hash': instance.hash,
      'Size': instance.size,
      'Type': instance.type,
      'Target': instance.target,
    };
