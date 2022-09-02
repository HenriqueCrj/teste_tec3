import 'package:equatable/equatable.dart';

// Representa informação que vem da api de Star Wars
class SWInfo extends Equatable {
  final String title;
  // As informações podem ter como categoria: "film" ou "person"
  final String category;

  const SWInfo(this.title, this.category);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      title: title,
      category: category,
    };
    return map;
  }

  SWInfo.fromMap(Map<String, Object?> map)
      : title = map["title"] as String,
        category = map["category"] as String;

  @override
  List<Object?> get props => [title, category];
}
