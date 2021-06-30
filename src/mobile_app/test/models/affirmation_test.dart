import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/models/affirmation.dart';

void main() {
  Affirmation mockValidAffirmation = Affirmation(
    id: 'testId',
    title: 'testTitle',
    subtitle: 'testSubtitle',
    createdOn: DateTime.now(),
    totalReaffirmations: 12,
    likes: 8,
    active: true,
  );

  Map<String, dynamic> mockValidAffirmationJson = {
    Affirmation.fieldId: mockValidAffirmation.id,
    Affirmation.fieldSubtitle: mockValidAffirmation.subtitle,
    Affirmation.fieldTitle: mockValidAffirmation.title,
    Affirmation.fieldCreatedOn:
        mockValidAffirmation.createdOn.toIso8601String(),
    Affirmation.fieldLikes: mockValidAffirmation.likes,
    Affirmation.fieldTotalReaffirmations:
        mockValidAffirmation.totalReaffirmations,
    Affirmation.fieldActive: mockValidAffirmation.active,
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
          Affirmation.fromJson({Affirmation.fieldId: mockValidAffirmation.id}),
          equals(Affirmation.empty.copyWith(id: mockValidAffirmation.id)),
        );
        expect(
          Affirmation.fromJson(
              {Affirmation.fieldTitle: mockValidAffirmation.title}),
          equals(Affirmation.empty.copyWith(title: mockValidAffirmation.title)),
        );
        expect(
          Affirmation.fromJson(
              {Affirmation.fieldSubtitle: mockValidAffirmation.subtitle}),
          equals(Affirmation.empty
              .copyWith(subtitle: mockValidAffirmation.subtitle)),
        );
        expect(
          Affirmation.fromJson(
              {Affirmation.fieldLikes: mockValidAffirmation.likes}),
          equals(Affirmation.empty.copyWith(likes: mockValidAffirmation.likes)),
        );
        expect(
          Affirmation.fromJson({
            Affirmation.fieldTotalReaffirmations:
                mockValidAffirmation.totalReaffirmations
          }),
          equals(Affirmation.empty.copyWith(
              totalReaffirmations: mockValidAffirmation.totalReaffirmations)),
        );

        expect(
            Affirmation.fromJson(
                {Affirmation.fieldCreatedOn: mockValidAffirmation.createdOn}),
            equals(Affirmation.empty.copyWith(
              createdOn: mockValidAffirmation.createdOn,
            )));
      });
    });
  });
}
