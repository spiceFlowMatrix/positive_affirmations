void main() {}
// import 'package:flutter_test/flutter_test.dart';
// import 'package:mobile_app/consts.dart';
// import 'package:mobile_app/models/affirmation.dart';
// import 'package:mobile_app/positive_affirmations_keys.dart';
//
// import '../fixtures/affirmation_detail_screen_fixture.dart';
//
// void main() {
//   final Affirmation mockAffirmation =
//       PositiveAffirmationsConsts.seedAffirmations[1];
//
//   group('[AffirmationDetailScreen]', () {
//     testWidgets('all relevant widgets exist', (tester) async {
//       await tester.pumpWidget(
//           AffirmationDetailScreenFixture(affirmation: mockAffirmation));
//
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsAppbarTitle),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsAppbarEditButton(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsBackButton(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsLikeButton(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsLikes(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsReaffirmationsCount(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsReaffirmButton(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsSubtitle(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//       expect(
//         find.byKey(PositiveAffirmationsKeys.affirmationDetailsTitle(
//             '${mockAffirmation.id}')),
//         findsOneWidget,
//       );
//     });
//   });
// }
