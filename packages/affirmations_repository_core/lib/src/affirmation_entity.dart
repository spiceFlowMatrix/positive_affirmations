class AffirmationEntity {
  String id;
  String message;
  DateTime remindOn;

  AffirmationEntity({this.id, this.message, this.remindOn});

  AffirmationEntity.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    message = map['message'];
    remindOn = map['remindOn'];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      id: id,
      message: message,
      remindOn: remindOn,
    };
    return map;
  }
}
