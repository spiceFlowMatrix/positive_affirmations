import 'package:flutter_test/flutter_test.dart';
import 'package:repository/repository.dart';

void main() {
  Affirmation mockValidAffirmation = Affirmation(
    id: '0',
    title: 'testTitle',
    subtitle: 'testSubtitle',
    createdById: PositiveAffirmationsRepositoryConsts.seedUser.id,
    createdOn: DateTime.now(),
    totalReaffirmations: 12,
    likeCount: 8,
    active: true,
  );

  Map<String, dynamic> mockValidAffirmationJson = {
    Affirmation.fieldId: mockValidAffirmation.id,
    Affirmation.fieldSubtitle: mockValidAffirmation.subtitle,
    Affirmation.fieldTitle: mockValidAffirmation.title,
    Affirmation.fieldCreatedById: mockValidAffirmation.createdById,
    Affirmation.fieldCreatedOn:
        mockValidAffirmation.createdOn.toIso8601String(),
    Affirmation.fieldLikeCount: mockValidAffirmation.likeCount,
    Affirmation.fieldTotalReaffirmations:
        mockValidAffirmation.totalReaffirmations,
    Affirmation.fieldActive: mockValidAffirmation.active,
    Affirmation.fieldLiked: mockValidAffirmation.liked,
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
              {Affirmation.fieldLikeCount: mockValidAffirmation.likeCount}),
          equals(Affirmation.empty.copyWith(likeCount: mockValidAffirmation.likeCount)),
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
              {Affirmation.fieldCreatedById: mockValidAffirmation.createdById}),
          equals(Affirmation.empty
              .copyWith(createdById: mockValidAffirmation.createdById)),
        );

        expect(
            Affirmation.fromJson(
                {Affirmation.fieldCreatedOn: mockValidAffirmation.createdOn}),
            equals(Affirmation.empty.copyWith(
              createdOn: mockValidAffirmation.createdOn,
            )));

        expect(
          Affirmation.fromJson(
              {Affirmation.fieldLiked: mockValidAffirmation.liked}),
          equals(Affirmation.empty.copyWith(liked: mockValidAffirmation.liked)),
        );
      });
    });
  });
}
