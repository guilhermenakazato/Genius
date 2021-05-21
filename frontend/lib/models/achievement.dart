class Achievement {
  String institution, name, position, type, customizedType;

  Achievement(this.institution, this.name, this.position, this.type);

  Achievement.fromJson(Map<String, dynamic> json)
      : institution = json['institution'],
        name = json['name'],
        position = json['position'],
        type = json['institution'],
        customizedType = json['customized-type'];

  Map<String, dynamic> toJson() => {
        'position': position,
        'name': name,
        'institution': institution,
        'type': type,
        'customized-type': customizedType
      };
}