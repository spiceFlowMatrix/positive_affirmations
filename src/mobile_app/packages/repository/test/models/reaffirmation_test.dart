import 'package:flutter_test/flutter_test.dart';
import 'package:repository/repository.dart';

void main() {
  final createdOn = DateTime.now();
  createdOn.add(Duration(days: 5));
  Reaffirmation mockValidReaffirmation = Reaffirmation(
    id: 1,
    affirmationId: 1,
    createdOn: createdOn,
    value: ReaffirmationValue.goodWork,
    font: ReaffirmationFont.roboto,
    stamp: ReaffirmationStamp.medal,
  );

  Map<String, dynamic> mockValidReaffirmationsJson = {
    Reaffirmation.fieldId: mockValidReaffirmation.id,
    Reaffirmation.fieldAffirmationId: mockValidReaffirmation.affirmationId,
    Reaffirmation.fieldCreatedOn:
        mockValidReaffirmation.createdOn.toIso8601String(),
    Reaffirmation.fieldValue: mockValidReaffirmation.value.index,
    Reaffirmation.fieldFont: mockValidReaffirmation.font.index,
    Reaffirmation.fieldStamp: mockValidReaffirmation.stamp.index
  };

  group('[ReaffirmationModel]', () {
    group('[json_converters]', () {
      test('fieldValues create valid json object', () {
        expect(
          mockValidReaffirmation.fieldValues,
          equals(mockValidReaffirmationsJson),
        );
      });

      test('valid json creates a valid Reaffirmation object', () {
        expect(
          Reaffirmation.fromJson(mockValidReaffirmationsJson),
          equals(mockValidReaffirmation),
        );
      });

      test('missing fields in a json object are handled', () {
        expect(
          Reaffirmation.fromJson(
              {Reaffirmation.fieldId: mockValidReaffirmation.id}),
          Reaffirmation.empty.copyWith(id: mockValidReaffirmation.id),
        );

        expect(
          Reaffirmation.fromJson({
            Reaffirmation.fieldAffirmationId:
            mockValidReaffirmation.affirmationId
          }),
          Reaffirmation.empty
              .copyWith(affirmationId: mockValidReaffirmation.affirmationId),
        );

        expect(
          Reaffirmation.fromJson(
              {Reaffirmation.fieldCreatedOn: mockValidReaffirmation.createdOn}),
          Reaffirmation.empty
              .copyWith(createdOn: mockValidReaffirmation.createdOn),
        );

        expect(
          Reaffirmation.fromJson(
              {Reaffirmation.fieldValue: mockValidReaffirmation.value.index}),
          Reaffirmation.empty.copyWith(value: mockValidReaffirmation.value),
        );

        expect(
          Reaffirmation.fromJson(
              {Reaffirmation.fieldFont: mockValidReaffirmation.font.index}),
          Reaffirmation.empty.copyWith(font: mockValidReaffirmation.font),
        );

        expect(
          Reaffirmation.fromJson(
              {Reaffirmation.fieldStamp: mockValidReaffirmation.stamp.index}),
          Reaffirmation.empty.copyWith(stamp: mockValidReaffirmation.stamp),
        );
      });
    });

    group('[copyWith]', () {
      test('returns same object if no params passed', () {
        expect(
          Reaffirmation.empty.copyWith(),
          equals(Reaffirmation.empty),
        );
      });
      test('returns object with updated id if id is passed', () {
        expect(
          Reaffirmation.empty.copyWith(id: mockValidReaffirmation.id),
          equals(Reaffirmation(
            id: mockValidReaffirmation.id,
            affirmationId: Reaffirmation.empty.affirmationId,
            value: Reaffirmation.empty.value,
            createdOn: Reaffirmation.empty.createdOn,
            font: Reaffirmation.empty.font,
            stamp: Reaffirmation.empty.stamp,
          )),
        );
      });
      test(
          'returns object with updated affirmationId if affirmationId is passed',
          () {
        expect(
          Reaffirmation.empty
              .copyWith(affirmationId: mockValidReaffirmation.affirmationId),
          equals(Reaffirmation(
            id: Reaffirmation.empty.id,
            affirmationId: mockValidReaffirmation.affirmationId,
            value: Reaffirmation.empty.value,
            createdOn: Reaffirmation.empty.createdOn,
            font: Reaffirmation.empty.font,
            stamp: Reaffirmation.empty.stamp,
          )),
        );
      });
      test('returns object with updated value if value is passed', () {
        expect(
          Reaffirmation.empty.copyWith(value: mockValidReaffirmation.value),
          equals(Reaffirmation(
            id: Reaffirmation.empty.id,
            affirmationId: Reaffirmation.empty.affirmationId,
            value: mockValidReaffirmation.value,
            createdOn: Reaffirmation.empty.createdOn,
            font: Reaffirmation.empty.font,
            stamp: Reaffirmation.empty.stamp,
          )),
        );
      });
      test('returns object with updated createdOn if createdOn is passed', () {
        expect(
          Reaffirmation.empty
              .copyWith(createdOn: mockValidReaffirmation.createdOn),
          equals(Reaffirmation(
            id: Reaffirmation.empty.id,
            affirmationId: Reaffirmation.empty.affirmationId,
            value: Reaffirmation.empty.value,
            createdOn: mockValidReaffirmation.createdOn,
            font: Reaffirmation.empty.font,
            stamp: Reaffirmation.empty.stamp,
          )),
        );
      });
      test('returns object with updated font if font is passed', () {
        expect(
          Reaffirmation.empty.copyWith(font: mockValidReaffirmation.font),
          equals(Reaffirmation(
            id: Reaffirmation.empty.id,
            affirmationId: Reaffirmation.empty.affirmationId,
            value: Reaffirmation.empty.value,
            createdOn: Reaffirmation.empty.createdOn,
            font: mockValidReaffirmation.font,
            stamp: Reaffirmation.empty.stamp,
          )),
        );
      });
      test('returns object with updated stamp if stamp is passed', () {
        expect(
          Reaffirmation.empty.copyWith(stamp: mockValidReaffirmation.stamp),
          equals(Reaffirmation(
            id: Reaffirmation.empty.id,
            affirmationId: Reaffirmation.empty.affirmationId,
            value: Reaffirmation.empty.value,
            createdOn: Reaffirmation.empty.createdOn,
            font: Reaffirmation.empty.font,
            stamp: mockValidReaffirmation.stamp,
          )),
        );
      });
    });
  });
}
