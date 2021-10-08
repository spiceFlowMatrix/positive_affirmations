import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

enum ReaffirmationValueFieldValidationError { empty, invalid }

class ReaffirmationValueField extends FormzInput<ReaffirmationValue,
    ReaffirmationValueFieldValidationError> {
  const ReaffirmationValueField.pure() : super.pure(ReaffirmationValue.empty);

  const ReaffirmationValueField.dirty(
      [ReaffirmationValue value = ReaffirmationValue.empty])
      : super.dirty(value);

  @override
  ReaffirmationValueFieldValidationError? validator(ReaffirmationValue value) {
    if (value == ReaffirmationValue.empty)
      return ReaffirmationValueFieldValidationError.empty;
  }
}
