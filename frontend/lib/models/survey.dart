class Survey {
  String link, name;

  Survey(this.link, this.name);

  Survey.fromJson(Map<String, dynamic> json)
      : link = json['link'],
        name = json['name'];

  Map<String, dynamic> toJson() => {
        'link': link,
        'name': name,
      };
}
