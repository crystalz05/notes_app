import 'dart:async';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../util/type_converter.dart';
import '../../features/notes/models/note.dart';
import '../../features/notes/database/note_dao.dart';

part 'app_database.g.dart';

@TypeConverters([DateTimeConverter])
@Database(version: 1, entities: [NoteModel])
abstract class AppDatabase extends FloorDatabase {
  NoteDao get noteDao;
}