
import 'package:equatable/equatable.dart';
import 'package:tyro_notes_application/features/notes/models/note.dart';

abstract class NoteEvent extends Equatable {
  const NoteEvent();

  @override
  List<Object?> get props => [];
}

class LoadNotes extends NoteEvent{}

class ClearSearch extends NoteEvent {}

class AddNote extends NoteEvent{
  final NoteModel note;
  const AddNote(this.note);

  @override
  List<Object?> get props => [note];
}

class UpdateNote extends NoteEvent{
  final NoteModel note;
  const UpdateNote(this.note);

  @override
  List<Object?> get props => [note];
}

class DeleteNote extends NoteEvent{
  final NoteModel note;
  const DeleteNote(this.note);

  @override
  List<Object?> get props => [note];
}

class SearchNotes extends NoteEvent{
  final String query;
  const SearchNotes(this.query);

  @override
  List<Object?> get props => [query];
}
