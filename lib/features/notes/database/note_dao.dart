
import 'package:floor/floor.dart';

import '../../../cubit/sort_cubit.dart';
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
  Future<List<NoteModel>> searchNewestFirst(String query);

  @Query('SELECT * FROM Note WHERE title LIKE :query OR content LIKE :query ORDER BY updatedAt ASC')
  Future<List<NoteModel>> searchOldestFirst(String query);

  @Query('SELECT * FROM Note WHERE title LIKE :query OR content LIKE :query ORDER BY title ASC')
  Future<List<NoteModel>> searchTitleAZ(String query);

  @Query('SELECT * FROM Note WHERE title LIKE :query OR content LIKE :query ORDER BY title DESC')
  Future<List<NoteModel>> searchTitleZA(String query);

  Future<List<NoteModel>> searchNotes(String query, SortOption sort) {
    final q = '%$query%'; // wrap with wildcards here, once, cleanly
    switch (sort) {
      case SortOption.newestFirst: return searchNewestFirst(q);
      case SortOption.oldestFirst: return searchOldestFirst(q);
      case SortOption.titleAZ:     return searchTitleAZ(q);
      case SortOption.titleZA:     return searchTitleZA(q);
    }
  }

  @Query('SELECT * FROM Note ORDER BY updatedAt DESC')
  Future<List<NoteModel>> getNotesNewestFirst();

  @Query('SELECT * FROM Note ORDER BY updatedAt ASC')
  Future<List<NoteModel>> getNotesOldestFirst();

  @Query('SELECT * FROM Note ORDER BY title ASC')
  Future<List<NoteModel>> getNotesTitleAZ();

  @Query('SELECT * FROM Note ORDER BY title DESC')
  Future<List<NoteModel>> getNotesTitleZA();
}