import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'category.g.dart';
part 'category_adapter.dart';

@HiveType(typeId: 3)
@JsonSerializable()
class Category {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String created_at;

  Category({
    required this.id,
    required this.name,
    required this.created_at,
  });

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);

  static List<Category> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Category.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}
