import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

enum ReaffirmationStampFieldValidationError { empty, invalid }

class ReaffirmationStampField extends FormzInput<ReaffirmationStamp,
    ReaffirmationStampFieldValidationError> {
  const ReaffirmationStampField.pure() : super.pure(ReaffirmationStamp.empty);

  const ReaffirmationStampField.dirty(
      [ReaffirmationStamp value = ReaffirmationStamp.empty])
      : super.dirty(value);

  @override
  ReaffirmationStampFieldValidationError? validator(ReaffirmationStamp value) {
    if (value == ReaffirmationStamp.empty)
      return ReaffirmationStampFieldValidationError.empty;
  }
}
