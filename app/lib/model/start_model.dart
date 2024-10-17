import 'package:equatable/equatable.dart';

class StartModel extends Equatable {
  final List<String> title;
  final List<String> content;
  final List<String> imageAsset;

  const StartModel(
      {required this.title, required this.content, required this.imageAsset});
  @override
  List<Object?> get props => [title, content, imageAsset];
}
