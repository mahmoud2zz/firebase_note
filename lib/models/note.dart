class Note {
  late String title;
  late String info;
  late String id;

  Note();

  Note.fromMap(Map<String, dynamic> map) {
    title = map['title'];
    info = map['info'];
    id = map['id'];
  }

  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = <String, dynamic>{};
    map['title'] = title;
    map['info'] = info;
    map['id'] = id;

    return map;
  }
}
