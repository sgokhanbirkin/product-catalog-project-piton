// product.g.dart
part of 'product.dart';

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 0;

  @override
  Product read(BinaryReader reader) {
    return Product(
      id: reader.readInt(),
      name: reader.readString(),
      author: reader.readString(),
      cover: reader.readString(),
      created_at: reader.readString(),
      description: reader.readString(),
      price: reader.readDouble(),
      sales: reader.readInt(),
      slug: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.name ?? '')
      ..writeString(obj.author ?? '')
      ..writeString(obj.cover ?? '')
      ..writeString(obj.created_at ?? '')
      ..writeString(obj.description ?? '')
      ..writeDouble(obj.price ?? 0)
      ..writeInt(obj.sales ?? 0)
      ..writeString(obj.slug ?? '');
  }
}

class LikesAggregateAdapter extends TypeAdapter<LikesAggregate> {
  @override
  final int typeId = 1;

  @override
  LikesAggregate read(BinaryReader reader) {
    return LikesAggregate(
      aggregate: reader.read() as Aggregate, // Adjusting for Aggregate field
    );
  }

  @override
  void write(BinaryWriter writer, LikesAggregate obj) {
    writer.write(obj.aggregate);
  }
}

class AggregateAdapter extends TypeAdapter<Aggregate> {
  @override
  final int typeId = 2;

  @override
  Aggregate read(BinaryReader reader) {
    return Aggregate(
      count: reader.readInt(),
    );
  }

  @override
  void write(BinaryWriter writer, Aggregate obj) {
    writer.writeInt(obj.count ?? 0);
  }
}
