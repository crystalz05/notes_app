import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyro_notes_application/cubit/sort_cubit.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_event.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_state.dart';
import 'package:tyro_notes_application/features/notes/database/note_dao.dart';
import 'package:tyro_notes_application/features/notes/models/note.dart';

class NoteBloc extends Bloc<NoteEvent, NoteState> {
  final NoteDao noteDao;
  final SortCubit sortCubit;

  late final StreamSubscription _sortSubscription;

  String? _activeQuery;

  NoteBloc({
    required this.noteDao,
    required this.sortCubit,
  }): super(NoteInitial()){
    on<LoadNotes>(_loadNotes);
    on<AddNote>(_addNote);
    on<UpdateNote>(_updateNote);
    on<DeleteNote>(_deleteNote);
    on<SearchNotes>(_searchNotes);
    on<ClearSearch>(_clearSearch);

    _sortSubscription = sortCubit.stream.listen((_) {
      if (_activeQuery != null) {
        add(SearchNotes(_activeQuery!)); // re-search with new sort
      } else {
        add(LoadNotes());               // normal reload with new sort
      }
    });
  }


  Future<void> _loadNotes(LoadNotes event, Emitter<NoteState> emit) async{
    emit(NoteLoading());
    try{

      List<NoteModel> notes;

      switch (sortCubit.state) {
        case SortOption.newestFirst:
          notes = await noteDao.getNotesNewestFirst();
          break;
        case SortOption.oldestFirst:
          notes = await noteDao.getNotesOldestFirst();
          break;
        case SortOption.titleAZ:
          notes = await noteDao.getNotesTitleAZ();
          break;
        case SortOption.titleZA:
          notes = await noteDao.getNotesTitleZA();
          break;
      }
      emit(NoteLoaded(notes));
    }catch(e){
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _addNote(AddNote event, Emitter<NoteState> emit) async {
    try {
      await noteDao.insertNote(event.note);
      add(LoadNotes());
    }catch(e){
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _updateNote(UpdateNote event, Emitter<NoteState> emit) async {
    try{
      await noteDao.updateNote(event.note);
      add(LoadNotes());
    }catch(e){
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _deleteNote(DeleteNote event, Emitter<NoteState> emit) async {
    try{
      await noteDao.deleteNote(event.note);
      add(LoadNotes());
    }catch(e){
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _searchNotes(SearchNotes event, Emitter<NoteState> emit) async {
    _activeQuery = event.query; // remember we're in search mode
    try {
      final notes = await noteDao.searchNotes(event.query, sortCubit.state);
      emit(NoteLoaded(notes, isSearching: true));
    } catch (e) {
      emit(NoteError(e.toString()));
    }
  }

  Future<void> _clearSearch(ClearSearch event, Emitter<NoteState> emit) async {
    _activeQuery = null; // back to browse mode
    add(LoadNotes());
  }

  @override
  Future<void> close() {
    _sortSubscription.cancel();
    return super.close();
  }
}