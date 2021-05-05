class Achievement {
  String institution, name, position, type;

  Achievement(this.institution, this.name, this.position, this.type);

  Achievement.fromJson(Map<String, dynamic> json)
      : institution = json['institution'],
        name = json['name'],
        position = json['position'],
        type = json['institution'];

  Map<String, dynamic> toJson() => {
        'position': position,
        'name': name,
        'institution': institution,
        'type': type,
      };
}