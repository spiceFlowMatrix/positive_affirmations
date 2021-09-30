import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:formz/formz.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_graphic_field.dart';
import 'package:mobile_app/reaffirmation/models/reaffirmation_value_field.dart';
import 'package:repository/repository.dart';

void main() {
  late ReaffirmationBloc reaffirmationBloc;

  setUp(() {
    reaffirmationBloc = ReaffirmationBloc();
  });

  group('[ReaffirmationBloc]', () {
    group('[ValueSelected]', () {
      blocTest<ReaffirmationBloc, ReaffirmationState>(
        'emits updated value when new value submitted',
        build: () => reaffirmationBloc,
        act: (bloc) {
          bloc
            ..add(new ValueSelected(value: ReaffirmationValue.goodWork))
            ..add(new ValueSelected(value: ReaffirmationValue.goodWork))
            ..add(new ValueSelected(value: ReaffirmationValue.braveOn));
        },
        expect: () => <ReaffirmationState>[
          ReaffirmationState(
            value: ReaffirmationValueField.dirty(ReaffirmationValue.goodWork),
            submissionStatus: FormzStatus.invalid,
          ),
          ReaffirmationState(
            value: ReaffirmationValueField.dirty(ReaffirmationValue.empty),
            submissionStatus: FormzStatus.invalid,
          ),
          ReaffirmationState(
            value: ReaffirmationValueField.dirty(ReaffirmationValue.braveOn),
            submissionStatus: FormzStatus.invalid,
          )
        ],
      );
    });
    group('[GraphicSelected]', () {
      blocTest<ReaffirmationBloc, ReaffirmationState>(
        'emits updated graphic when new graphic submitted',
        build: () => reaffirmationBloc,
        act: (bloc) {
          bloc
            ..add(new GraphicSelected(graphic: ReaffirmationGraphic.medal))
            ..add(new GraphicSelected(graphic: ReaffirmationGraphic.medal))
            ..add(new GraphicSelected(graphic: ReaffirmationGraphic.takeOff));
        },
        expect: () => <ReaffirmationState>[
          ReaffirmationState(
            graphic:
                ReaffirmationGraphicField.dirty(ReaffirmationGraphic.medal),
            submissionStatus: FormzStatus.invalid,
          ),
          ReaffirmationState(
            graphic:
                ReaffirmationGraphicField.dirty(ReaffirmationGraphic.empty),
            submissionStatus: FormzStatus.invalid,
          ),
          ReaffirmationState(
            graphic:
                ReaffirmationGraphicField.dirty(ReaffirmationGraphic.takeOff),
            submissionStatus: FormzStatus.invalid,
          )
        ],
      );
    });
    group('[Validation]', () {
      blocTest<ReaffirmationBloc, ReaffirmationState>(
        'submission status is invalid if only value is selected',
        build: () => reaffirmationBloc,
        act: (bloc) {
          bloc..add(new ValueSelected(value: ReaffirmationValue.goodWork));
        },
        expect: () => <ReaffirmationState>[
          ReaffirmationState(
            value: ReaffirmationValueField.dirty(ReaffirmationValue.goodWork),
            submissionStatus: FormzStatus.invalid,
          )
        ],
      );
      blocTest<ReaffirmationBloc, ReaffirmationState>(
        'submission status is invalid if only graphic is selected',
        build: () => reaffirmationBloc,
        act: (bloc) {
          bloc..add(new GraphicSelected(graphic: ReaffirmationGraphic.medal));
        },
        expect: () => <ReaffirmationState>[
          ReaffirmationState(
            graphic:
                ReaffirmationGraphicField.dirty(ReaffirmationGraphic.medal),
            submissionStatus: FormzStatus.invalid,
          )
        ],
      );
      blocTest<ReaffirmationBloc, ReaffirmationState>(
        'submission status is valid if graphic and value are selected',
        build: () => reaffirmationBloc,
        act: (bloc) {
          bloc
            ..add(new GraphicSelected(graphic: ReaffirmationGraphic.medal))
            ..add(new ValueSelected(value: ReaffirmationValue.goodWork));
        },
        expect: () => <ReaffirmationState>[
          ReaffirmationState(
            graphic:
                ReaffirmationGraphicField.dirty(ReaffirmationGraphic.medal),
            submissionStatus: FormzStatus.invalid,
          ),
          ReaffirmationState(
            graphic:
                ReaffirmationGraphicField.dirty(ReaffirmationGraphic.medal),
            value: ReaffirmationValueField.dirty(ReaffirmationValue.goodWork),
            submissionStatus: FormzStatus.valid,
          )
        ],
      );
    });
  });
}
