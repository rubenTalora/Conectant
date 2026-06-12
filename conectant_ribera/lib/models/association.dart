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
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      type: map['type'] ?? '',
      description: map['description'] ??
          'Organización vinculada a centros especializados.',
      contact: map['contact'] ??
          'info@${map['name']?.toLowerCase().replaceAll(' ', '') ?? ''}.org',
      website: map['website'] ??
          'www.${map['name']?.toLowerCase().replaceAll(' ', '') ?? ''}.org',
    );
  }
}
