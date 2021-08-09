class Survey {
  String link, name;
  int id;

  Survey(this.link, this.name);

  Survey.fromJson(Map<String, dynamic> json)
      : link = json['link'],
        name = json['name'],
        id = json['id'];

  Map<String, dynamic> toJson() => {
        'link': link,
        'name': name,
      };
}
