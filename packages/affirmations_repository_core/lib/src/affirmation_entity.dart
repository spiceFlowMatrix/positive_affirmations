import 'package:equatable/equatable.dart';

final String tableAffirmations = 'affirmations';
final String columnId = '_id';
final String columnTitle = 'title';
final String columnMessage = 'message';

class AffirmationEntity extends Equatable {
  String id;
  String title;
  String message;

  AffirmationEntity({this.id, this.title, this.message});

  AffirmationEntity.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    title = map[columnTitle];
    message = map[columnMessage];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnId: id,
      columnTitle: title,
      columnMessage: message,
    };
    return map;
  }

  @override
  List<Object> get props => [id, title, message];

  @override
  String toString() {
    return 'AffirmationEntity{id: $id, title: $title, message: $message}';
  }
}
