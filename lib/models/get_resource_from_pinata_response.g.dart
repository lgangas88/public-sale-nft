// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_resource_from_pinata_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetResourcesFromPinata _$GetResourcesFromPinataFromJson(
        Map<String, dynamic> json) =>
    GetResourcesFromPinata(
      count: json['count'] as int,
      rows: (json['rows'] as List<dynamic>)
          .map((e) =>
              GetResourcesFromPinataRow.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetResourcesFromPinataToJson(
        GetResourcesFromPinata instance) =>
    <String, dynamic>{
      'count': instance.count,
      'rows': instance.rows,
    };

GetResourcesFromPinataRow _$GetResourcesFromPinataRowFromJson(
        Map<String, dynamic> json) =>
    GetResourcesFromPinataRow(
      id: json['id'] as String,
      ipfsPinHash: json['ipfs_pin_hash'] as String,
      size: json['size'] as int,
      userId: json['user_id'] as String,
      datePinned: DateTime.parse(json['date_pinned'] as String),
      dateUnpinned: json['date_unpinned'],
      metadata: GetResourcesFromPinataMetadata.fromJson(
          json['metadata'] as Map<String, dynamic>),
      regions: (json['regions'] as List<dynamic>)
          .map((e) =>
              GetResourcesFromPinataRegion.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetResourcesFromPinataRowToJson(
        GetResourcesFromPinataRow instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ipfs_pin_hash': instance.ipfsPinHash,
      'size': instance.size,
      'user_id': instance.userId,
      'date_pinned': instance.datePinned.toIso8601String(),
      'date_unpinned': instance.dateUnpinned,
      'metadata': instance.metadata,
      'regions': instance.regions,
    };

GetResourcesFromPinataMetadata _$GetResourcesFromPinataMetadataFromJson(
        Map<String, dynamic> json) =>
    GetResourcesFromPinataMetadata(
      name: json['name'] as String,
      keyvalues: json['keyvalues'],
    );

Map<String, dynamic> _$GetResourcesFromPinataMetadataToJson(
        GetResourcesFromPinataMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'keyvalues': instance.keyvalues,
    };

GetResourcesFromPinataRegion _$GetResourcesFromPinataRegionFromJson(
        Map<String, dynamic> json) =>
    GetResourcesFromPinataRegion(
      regionId: json['regionId'] as String,
      currentReplicationCount: json['currentReplicationCount'] as int,
      desiredReplicationCount: json['desiredReplicationCount'] as int,
    );

Map<String, dynamic> _$GetResourcesFromPinataRegionToJson(
        GetResourcesFromPinataRegion instance) =>
    <String, dynamic>{
      'regionId': instance.regionId,
      'currentReplicationCount': instance.currentReplicationCount,
      'desiredReplicationCount': instance.desiredReplicationCount,
    };
