// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String? ?? '',
      author: json['author'] as String? ?? '',
      cover: json['cover'] as String? ?? '',
      created_at: json['created_at'] as String? ?? '',
      description: json['description'] as String? ?? '',
      price: (json['price'] as num?)?.toDouble() ?? 0.0,
      sales: (json['sales'] as num?)?.toInt() ?? 0,
      slug: json['slug'] as String? ?? '',
      likesAggregate: json['likesAggregate'] == null
          ? null
          : LikesAggregate.fromJson(
              json['likesAggregate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'author': instance.author,
      'cover': instance.cover,
      'created_at': instance.created_at,
      'description': instance.description,
      'price': instance.price,
      'sales': instance.sales,
      'slug': instance.slug,
      'likesAggregate': instance.likesAggregate,
    };

LikesAggregate _$LikesAggregateFromJson(Map<String, dynamic> json) =>
    LikesAggregate(
      aggregate: json['aggregate'] == null
          ? null
          : Aggregate.fromJson(json['aggregate'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$LikesAggregateToJson(LikesAggregate instance) =>
    <String, dynamic>{
      'aggregate': instance.aggregate,
    };

Aggregate _$AggregateFromJson(Map<String, dynamic> json) => Aggregate(
      count: (json['count'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$AggregateToJson(Aggregate instance) => <String, dynamic>{
      'count': instance.count,
    };
