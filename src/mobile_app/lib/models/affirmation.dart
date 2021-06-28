import 'package:equatable/equatable.dart';

class Affirmation extends Equatable {
  const Affirmation({
    this.id = '',
    this.title = '',
    this.subtitle = '',
    this.likes = 0,
    this.totalReaffirmations = 0,
  });

  final String id;
  final String title;
  final String subtitle;
  final int likes;
  final int totalReaffirmations;

  @override
  List<Object> get props => [id, title, subtitle, likes, totalReaffirmations];
}
