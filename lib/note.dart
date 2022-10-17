// ignore_for_file: public_member_api_docs, sort_constructors_first

class Note {
  int? id;
  String? note;
  DateTime? created;
  DateTime? updated;
  Note(
      {required this.created,
      required this.id,
      required this.note,
      required this.updated});
  Note.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    note = map['body'];
    created = map['created'];
    updated = map['updated'];
  }
  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "body": note,
      "created": created,
      "updated": updated,
    };
  }
}
