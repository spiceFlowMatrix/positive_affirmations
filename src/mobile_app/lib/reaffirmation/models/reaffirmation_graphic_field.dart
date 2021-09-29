import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

enum ReaffirmationGraphicFieldValidationError { empty, invalid }

class ReaffirmationGraphicField extends FormzInput<ReaffirmationGraphic,
    ReaffirmationGraphicFieldValidationError> {
  const ReaffirmationGraphicField.pure()
      : super.pure(ReaffirmationGraphic.empty);

  const ReaffirmationGraphicField.dirty(
      [ReaffirmationGraphic value = ReaffirmationGraphic.empty])
      : super.dirty(value);

  @override
  ReaffirmationGraphicFieldValidationError? validator(
      ReaffirmationGraphic value) {
    if (value == ReaffirmationGraphic.empty)
      return ReaffirmationGraphicFieldValidationError.empty;
  }
}
