// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      author: json['author'] as String,
      cover: json['cover'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      description: json['description'] as String,
      price: (json['price'] as num).toDouble(),
      sales: (json['sales'] as num).toInt(),
      slug: json['slug'] as String,
      likesAggregate: LikesAggregate.fromJson(
          json['likesAggregate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'cover': instance.cover,
      'createdAt': instance.createdAt.toIso8601String(),
      'description': instance.description,
      'price': instance.price,
      'sales': instance.sales,
      'slug': instance.slug,
      'likesAggregate': instance.likesAggregate,
    };

LikesAggregate _$LikesAggregateFromJson(Map<String, dynamic> json) =>
    LikesAggregate(
      aggregate: Aggregate.fromJson(json['aggregate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LikesAggregateToJson(LikesAggregate instance) =>
    <String, dynamic>{
      'aggregate': instance.aggregate,
    };

Aggregate _$AggregateFromJson(Map<String, dynamic> json) => Aggregate(
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$AggregateToJson(Aggregate instance) => <String, dynamic>{
      'count': instance.count,
    };
