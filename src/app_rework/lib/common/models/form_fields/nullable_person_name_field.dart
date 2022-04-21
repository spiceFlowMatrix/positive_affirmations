import 'package:formz/formz.dart';

enum NullablePersonNameFieldValidationError { invalid }

class NullablePersonNameField
    extends FormzInput<String?, NullablePersonNameFieldValidationError> {
  const NullablePersonNameField.pure() : super.pure(null);

  const NullablePersonNameField.dirty([String? value]) : super.dirty(value);

  // Used following regex tool to find the regex that worked:
  // https://regex101.com/
  // The resulting regex was adapted from:
  // https://stackoverflow.com/questions/8359566/regex-to-match-symbols
  // Solution for escaping quotes in dart regex objects found here:
  // https://stackoverflow.com/questions/67685251/escape-quote-in-dart-regex
  static final _invalidRegexFormat =
      RegExp(r'''(?:[-!$@%^&*()_+|~=`{}\[\]:"';<>?,.\/])|(\d)''');

  @override
  NullablePersonNameFieldValidationError? validator(String? value) {
    if (value != null && _invalidRegexFormat.hasMatch(value)) {
      return NullablePersonNameFieldValidationError.invalid;
    }
    return null;
  }
}
