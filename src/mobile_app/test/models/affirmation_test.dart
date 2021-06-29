import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/affirmation.dart';

void main() {
  const Affirmation mockValidAffirmation = Affirmation(
    id: 'testId',
    title: 'testTitle',
    subtitle: 'testSubtitle',
    totalReaffirmations: 12,
    likes: 8,
  );

  Map<String, dynamic> mockValidAffirmationJson = {
    Affirmation.fieldId: mockValidAffirmation.id,
    Affirmation.fieldSubtitle: mockValidAffirmation.subtitle,
    Affirmation.fieldTitle: mockValidAffirmation.title,
    Affirmation.fieldLikes: mockValidAffirmation.likes,
    Affirmation.fieldTotalReaffirmations:
        mockValidAffirmation.totalReaffirmations,
  };
  Map<String, dynamic> mockIncompleteAffirmationJson = {
    Affirmation.fieldId: mockValidAffirmation.id,
    Affirmation.fieldSubtitle: mockValidAffirmation.subtitle,
    Affirmation.fieldTitle: mockValidAffirmation.title,
  };

  group('[AffirmationModel]', () {
    group('json_converters', () {
      test('fieldValues create valid json object', () {
        expect(
          mockValidAffirmation.fieldValues,
          equals(mockValidAffirmationJson),
        );
      });

      test('valid fromJson creates a valid Affirmation object', () {
        expect(
          Affirmation.fromJson(mockValidAffirmationJson),
          equals(mockValidAffirmation),
        );
      });

      test('missing fields in a json object are handled', () {
        expect(
          Affirmation.fromJson(mockIncompleteAffirmationJson),
          equals(
              mockValidAffirmation.copyWith(likes: 0, totalReaffirmations: 0)),
        );
      });
    });
  });
}
