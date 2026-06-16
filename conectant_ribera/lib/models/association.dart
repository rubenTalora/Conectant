class Association {
  final String id;
  final String name;
  final String type;
  final String description;
  final String contact;
  final String website;

  Association({
    required this.id,
    required this.name,
    required this.type,
    this.description = '',
    this.contact = '',
    this.website = '',
  });

  factory Association.fromMap(Map<String, dynamic> map) {
    return Association(
      id: map['id'].toString(),
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ??
          'Organización vinculada a centros especializados.',
      contact: map['contact'] ?? '',
      website: map['website'] ?? '',
    );
  }
}
