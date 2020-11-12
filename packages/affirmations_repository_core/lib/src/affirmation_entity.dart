import 'package:equatable/equatable.dart';

final String tableAffirmations = 'affirmations';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnMessage = 'message';
final String columnRemindOn = 'remindOn';

class AffirmationEntity extends Equatable {
  String id;
  String title;
  String message;
  String remindOn;

  AffirmationEntity({this.id, this.title, this.message, this.remindOn});

  AffirmationEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    message = map[columnMessage];
    remindOn = map[columnRemindOn];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnTitle: title,
      columnMessage: message,
      columnRemindOn: remindOn,
    };
    return map;
  }

  @override
  List<Object> get props => [id, title, message, remindOn];

  @override
  String toString() {
    return 'AffirmationEntity{id: $id, title: $title, message: $message, remindOn: $remindOn}';
  }
}
