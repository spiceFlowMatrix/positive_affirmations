import 'package:flutter_test/flutter_test.dart';
import 'package:repository/repository.dart';

void main() {
  Reaffirmation mockValidReaffirmation = Reaffirmation(
    id: 1,
    affirmationId: 1,
    createdOn: DateTime.now(),
    value: ReaffirmationValue.goodWork,
    graphic: ReaffirmationGraphic.medal,
  );

  Map<String, dynamic> mockValidReaffirmationsJson = {
    Reaffirmation.fieldId: mockValidReaffirmation.id,
    Reaffirmation.fieldAffirmationId: mockValidReaffirmation.affirmationId,
    Reaffirmation.fieldCreatedOn:
        mockValidReaffirmation.createdOn.toIso8601String(),
    Reaffirmation.fieldValue:
        ReaffirmationValue.values[mockValidReaffirmation.value.index].index,
    Reaffirmation.fieldGraphic:
        ReaffirmationGraphic.values[mockValidReaffirmation.graphic.index].index
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
          Reaffirmation.fromJson({
            Reaffirmation.fieldGraphic: mockValidReaffirmation.graphic.index
          }),
          Reaffirmation.empty.copyWith(graphic: mockValidReaffirmation.graphic),
        );
      });
    });
  });
}
