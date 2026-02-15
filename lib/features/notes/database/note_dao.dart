
import 'package:floor/floor.dart';

import '../models/note.dart';

@dao
abstract class NoteDao {

  @Query('SELECT * FROM Note ORDER BY updatedAt DESC')
  Future<List<NoteModel>> getAllNotes();

  @Query('SELECT * FROM Note WHERE id = :id')
  Future<NoteModel?> getNoteById(int id);

  @insert
  Future<void> insertNote(NoteModel note);

  @update
  Future<void> updateNote(NoteModel note);

  @delete
  Future<void> deleteNote(NoteModel note);

  @Query('SELECT * FROM Note WHERE title LIKE :query OR content LIKE :query ORDER BY updatedAt DESC')
  Future<List<NoteModel>> searchNotes(String query);
}