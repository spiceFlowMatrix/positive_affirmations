import 'package:equatable/equatable.dart';

enum ReaffirmationValue { empty, braveOn, loveIt, goodWork }
enum ReaffirmationGraphic { empty, takeOff, medal, thumbsUp }

class Reaffirmation extends Equatable {
  Reaffirmation({
    required this.id,
    required this.value,
    required this.graphic,
  });

  final int id;
  final ReaffirmationValue value;
  final ReaffirmationGraphic graphic;
  static const String fieldId = 'id';
  static const String fieldValue = 'value';
  static const String fieldGraphic = 'graphic';

  static final empty = Reaffirmation(
    id: 0,
    value: ReaffirmationValue.empty,
    graphic: ReaffirmationGraphic.empty,
  );

  Map<String, dynamic> get fieldValues => {
        fieldId: this.id,
        fieldValue: this.value.index,
        fieldGraphic: this.graphic.index,
      };

  static Reaffirmation fromJson(Map<String, dynamic> json) {
    return Reaffirmation(
      id: json[Reaffirmation.fieldId] ?? empty.id,
      value: json[Reaffirmation.fieldValue]
          ? ReaffirmationValue.values[json[Reaffirmation.fieldValue]]
          : empty.value,
      graphic: json[Reaffirmation.fieldGraphic]
          ? ReaffirmationGraphic.values[json[Reaffirmation.fieldGraphic]]
          : empty.graphic,
    );
  }

  @override
  List<Object> get props => [id, value, graphic];
}
