import 'package:equatable/equatable.dart';

class LocalFile extends Equatable {
  final String id;
  final String bucketFileId;
  final String path;

  const LocalFile({
    required this.id,
    required this.bucketFileId,
    required this.path,
  });

  @override
  List<Object> get props => [id, bucketFileId, path];
}
