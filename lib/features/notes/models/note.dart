
import 'package:floor/floor.dart';
import 'package:tyro_notes_application/core/util/type_converter.dart';

@Entity(tableName: 'Note')
class NoteModel {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final String title;
  final String content;

  @TypeConverters([DateTimeConverter])
  final DateTime createdAt;

  @TypeConverters([DateTimeConverter])
  final DateTime updatedAt;
  final String color;

  NoteModel({
    this.id,
    required this.title,
    required this.content,
    required this.createdAt,
    required this.updatedAt,
    required this.color,
  });

  NoteModel copyWith({
    int? id,
    String? title,
    String? content,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? color,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      color: color ?? this.color,
    );
  }
}