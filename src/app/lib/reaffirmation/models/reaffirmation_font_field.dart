import 'package:formz/formz.dart';
import 'package:repository/repository.dart';

enum ReaffirmationFontFieldValidationError { empty, invalid }

class ReaffirmationFontField extends FormzInput<ReaffirmationFont,
    ReaffirmationFontFieldValidationError> {
  const ReaffirmationFontField.pure() : super.pure(ReaffirmationFont.none);

  const ReaffirmationFontField.dirty(
      [ReaffirmationFont value = ReaffirmationFont.none])
      : super.dirty(value);

  @override
  ReaffirmationFontFieldValidationError? validator(ReaffirmationFont value) {
    // if (value == ReaffirmationFont.none)
    //   return ReaffirmationFontFieldValidationError.empty;
  }
}
