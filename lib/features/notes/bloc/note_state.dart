import 'package:equatable/equatable.dart';
import 'package:tyro_notes_application/features/notes/models/note.dart';

abstract class NoteState extends Equatable {
  const NoteState();

  @override
  List<Object?> get props => [];
}

class NoteInitial extends NoteState {}

class NoteLoading extends NoteState {}

class NoteLoaded extends NoteState {
    final List<NoteModel> notes;
    final bool isSearching;
    const NoteLoaded(this.notes, {this.isSearching = false});

    @override
    List<Object?> get props => [notes, isSearching];
}

class NoteError extends NoteState {
    final String message;
    const NoteError(this.message);

    @override
    List<Object?> get props => [message];
}