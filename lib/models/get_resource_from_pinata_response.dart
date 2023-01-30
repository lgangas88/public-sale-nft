import 'package:json_annotation/json_annotation.dart';

part 'get_resource_from_pinata_response.g.dart';

@JsonSerializable()
class GetResourcesFromPinata {
  GetResourcesFromPinata({
    required this.count,
    required this.rows,
  });

  int count;
  List<GetResourcesFromPinataRow> rows;

  factory GetResourcesFromPinata.fromJson(Map<String, dynamic> json) => _$GetResourcesFromPinataFromJson(json);

  Map<String, dynamic> toJson() => _$GetResourcesFromPinataToJson(this);
}

@JsonSerializable()
class GetResourcesFromPinataRow {
  GetResourcesFromPinataRow({
    required this.id,
    required this.ipfsPinHash,
    required this.size,
    required this.userId,
    required this.datePinned,
    this.dateUnpinned,
    required this.metadata,
    required this.regions,
  });

  String id;
  @JsonKey(name: 'ipfs_pin_hash')
  String ipfsPinHash;
  int size;
  @JsonKey(name: 'user_id')
  String userId;
  @JsonKey(name: 'date_pinned')
  DateTime datePinned;
  @JsonKey(name: 'date_unpinned')
  dynamic dateUnpinned;
  GetResourcesFromPinataMetadata metadata;
  List<GetResourcesFromPinataRegion> regions;

  factory GetResourcesFromPinataRow.fromJson(Map<String, dynamic> json) => _$GetResourcesFromPinataRowFromJson(json);

  Map<String, dynamic> toJson() => _$GetResourcesFromPinataRowToJson(this);
}

@JsonSerializable()
class GetResourcesFromPinataMetadata {
  GetResourcesFromPinataMetadata({
    required this.name,
    this.keyvalues,
  });

  String name;
  dynamic keyvalues;

  factory GetResourcesFromPinataMetadata.fromJson(Map<String, dynamic> json) => _$GetResourcesFromPinataMetadataFromJson(json);

  Map<String, dynamic> toJson() => _$GetResourcesFromPinataMetadataToJson(this);
}

@JsonSerializable()
class GetResourcesFromPinataRegion {
  GetResourcesFromPinataRegion({
    required this.regionId,
    required this.currentReplicationCount,
    required this.desiredReplicationCount,
  });

  String regionId;
  int currentReplicationCount;
  int desiredReplicationCount;

  factory GetResourcesFromPinataRegion.fromJson(Map<String, dynamic> json) => _$GetResourcesFromPinataRegionFromJson(json);

  Map<String, dynamic> toJson() => _$GetResourcesFromPinataRegionToJson(this);
}
