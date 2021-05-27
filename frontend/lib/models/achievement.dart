class Achievement {
  final String institution, name, position, type, customizedType;
  int id;

  Achievement(this.institution, this.name, this.position, this.type, this.customizedType);

  Achievement.fromJson(Map<String, dynamic> json)
      : institution = json['institution'],
        name = json['name'],
        position = json['position'],
        type = json['type'],
        customizedType = json['customized_type'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'position': position,
        'name': name,
        'institution': institution,
        'type': type,
        'customized-type': customizedType
      };

      @override
  String toString() {
    return 'Achievement: {id: $id, name: $name, position: $position, institution: $institution, customizedType: $customizedType, type: $type}';
  }
}
