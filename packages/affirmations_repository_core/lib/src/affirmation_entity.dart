import 'package:equatable/equatable.dart';

final String tableAffirmations = 'affirmations';
final String columnId = '_id';
final String columnMessage = 'message';
final String columnRemindOn = 'remindOn';

class AffirmationEntity extends Equatable {
  String id;
  String message;
  String remindOn;

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

  @override
  List<Object> get props => [id, message, remindOn];

  @override
  String toString() {
    return 'AffirmationEntity{id: $id, message: $message, remindOn: $remindOn}';
  }
}
