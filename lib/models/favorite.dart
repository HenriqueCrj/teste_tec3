import 'package:equatable/equatable.dart';

class Favorite extends Equatable {
  final String title;
  final String category;

  const Favorite(this.title, this.category);

  Map<String, Object?> toMap() {
    var map = <String, Object?>{
      title: title,
      category: category,
    };
    return map;
  }

  Favorite.fromMap(Map<String, Object?> map)
      : title = map["title"] as String,
        category = map["category"] as String;

  @override
  List<Object?> get props => [title, category];
}
