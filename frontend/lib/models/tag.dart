class Tag {
  String name;
  int id;

  Tag.fromJson(Map<String, dynamic> json) : id = json['id'], name = json['name'];

  @override
  String toString() {
    return 'Tag: {id: $id, name: $name}';
  }
}
