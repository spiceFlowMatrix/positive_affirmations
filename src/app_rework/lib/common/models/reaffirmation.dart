import 'package:equatable/equatable.dart';
import 'package:positive_affirmations/common/models/models.dart';

enum ReaffirmationValue { empty, braveOn, loveIt, goodWork }
enum ReaffirmationStamp { empty, takeOff, medal, thumbsUp }
enum ReaffirmationFont { none, birthstone, gemunuLibre, montserrat }

class Reaffirmation extends Equatable {
  const Reaffirmation({
    required this.id,
    required this.uiId,
    DateTime? createdOn,
    required this.value,
    required this.font,
    required this.stamp,
  }) : _createdOn = createdOn;

  final int id;
  final String uiId;
  final ReaffirmationFont font;
  final ReaffirmationStamp stamp;
  final ReaffirmationValue value;
  final AppUser createdBy;
  final DateTime? _createdOn;
  final Affirmation forAffirmation;
  final List<Letter> inLetters;

  DateTime get createdOn => _createdOn ?? DateTime(0);

  Reaffirmation copyWith({
    String? id,
    String? affirmationId,
    DateTime? createdOn,
    ReaffirmationValue? value,
    ReaffirmationFont? font,
    ReaffirmationStamp? stamp,
  }) {
    return Reaffirmation(
      id: id ?? this.id,
      affirmationId: affirmationId ?? this.affirmationId,
      createdOn: createdOn ?? this.createdOn,
      value: value ?? this.value,
      font: font ?? this.font,
      stamp: stamp ?? this.stamp,
    );
  }

  static final empty = Reaffirmation(
    id: '-',
    affirmationId: '-',
    createdOn: DateTime(0),
    value: ReaffirmationValue.empty,
    font: ReaffirmationFont.none,
    stamp: ReaffirmationStamp.empty,
  );
}
