import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';
part 'product_adapter.dart';

@HiveType(typeId: 0)
@JsonSerializable()
class Product {
  @HiveField(0)
  final int id;

  @HiveField(1)
  final String? name;

  @HiveField(2)
  final String? author;

  @HiveField(3)
  final String? cover;

  @HiveField(4)
  final String? created_at;

  @HiveField(5)
  final String? description;

  @HiveField(6)
  final double? price;

  @HiveField(7)
  final int? sales;

  @HiveField(8)
  final String? slug;

  @HiveField(9)
  final LikesAggregate? likesAggregate;

  Product({
    required this.id,
    this.name = '',
    this.author = '',
    this.cover = '',
    this.created_at = '',
    this.description = '',
    this.price = 0.0,
    this.sales = 0,
    this.slug = '',
    this.likesAggregate = null,
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  static List<Product> fromJsonList(List<dynamic> jsonList) {
    return jsonList
        .map((json) => Product.fromJson(json as Map<String, dynamic>))
        .toList();
  }
}

@HiveType(typeId: 1)
@JsonSerializable()
class LikesAggregate {
  @HiveField(0)
  final Aggregate? aggregate;

  LikesAggregate({this.aggregate = null});

  factory LikesAggregate.fromJson(Map<String, dynamic> json) =>
      _$LikesAggregateFromJson(json);

  Map<String, dynamic> toJson() => _$LikesAggregateToJson(this);
}

@HiveType(typeId: 2)
@JsonSerializable()
class Aggregate {
  @HiveField(0)
  final int? count;

  Aggregate({this.count = 0});

  factory Aggregate.fromJson(Map<String, dynamic> json) =>
      _$AggregateFromJson(json);

  Map<String, dynamic> toJson() => _$AggregateToJson(this);
}
