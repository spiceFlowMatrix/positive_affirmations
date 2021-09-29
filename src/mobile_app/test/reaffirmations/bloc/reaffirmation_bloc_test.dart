import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_app/reaffirmation/bloc/reaffirmation_bloc.dart';
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
          ReaffirmationState(value: ReaffirmationValue.goodWork),
          ReaffirmationState(value: ReaffirmationValue.empty),
          ReaffirmationState(value: ReaffirmationValue.braveOn)
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
        expect: () =>
        <ReaffirmationState>[
          ReaffirmationState(graphic: ReaffirmationGraphic.medal),
          ReaffirmationState(graphic: ReaffirmationGraphic.empty),
          ReaffirmationState(graphic: ReaffirmationGraphic.takeOff)
        ],
      );
    });
  });
}
