class Centro {
  final String id;
  final String name;
  final String address;
  final double lat;
  final double lng;
  final String associationId;
  final String description;

  Centro({
    required this.id,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
    required this.associationId,
    required this.description,
  });

  factory Centro.fromMap(Map<String, dynamic> map) {
    return Centro(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      address: map['address'] ?? '',
      lat: (map['lat'] as num?)?.toDouble() ?? 0,
      lng: (map['lng'] as num?)?.toDouble() ?? 0,
      associationId:
          (map['association_id'] ?? map['associationId'] ?? '').toString(),
      description: map['description'] ?? '',
    );
  }
}
