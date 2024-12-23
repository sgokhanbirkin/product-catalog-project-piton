// category.g.dart
part of 'category.dart';

class CategoryAdapter extends TypeAdapter<Category> {
  @override
  final int typeId = 3;

  @override
  Category read(BinaryReader reader) {
    return Category(
      id: reader.readInt(),
      name: reader.readString(),
      created_at: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Category obj) {
    writer
      ..writeInt(obj.id)
      ..writeString(obj.name)
      ..writeString(obj.created_at);
  }
}
