import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:tyro_notes_application/cubit/sort_cubit.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_bloc.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_event.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_state.dart';
import 'package:tyro_notes_application/features/notes/screens/note_editor_screen.dart';
import 'package:tyro_notes_application/features/notes/screens/setting_screen.dart';
import 'package:tyro_notes_application/features/notes/widgets/delete_dialog.dart';
import '../models/note.dart';

class NotesListScreen extends StatelessWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes', style: TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const SettingsScreen())),
              icon: Icon(Icons.settings))
        ],
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _navigateToEditor(context, null),
        icon: const Icon(Icons.edit_outlined),
        label: const Text(
          'New Note',
          style: TextStyle(fontWeight: FontWeight.w600, letterSpacing: 0.5),
        ),
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),

        child: RefreshIndicator(
          onRefresh: () async {
            context.read<NoteBloc>().add(LoadNotes());
            await context.read<NoteBloc>().stream.firstWhere((state) => state is NoteLoaded);
          },
          child: Column(
              children: [
                TextField(
                  onChanged: (value) {
                    if (value.isEmpty) {
                      context.read<NoteBloc>().add(ClearSearch()); // ← was LoadNotes()
                    } else {
                      context.read<NoteBloc>().add(SearchNotes(value));
                    }
                  },
                  decoration: InputDecoration(
                      hintText: 'Enter search term',
                      filled: true,
                      fillColor: Colors.grey.withValues(alpha: 0.05),
                      suffixIcon: Icon(Icons.search, color: Colors.grey,),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2))),

                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          borderSide: BorderSide(color: Colors.grey.withValues(alpha: 0.2)))
                  ),
                  autofocus: false,
                ),
                SizedBox(height: 10,),

                BlocBuilder<SortCubit, SortOption>(
                    builder: (context, sortOption){
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            _buildSortButton(
                              context,
                              "Newest",
                              SortOption.newestFirst,
                              sortOption,
                              Icons.arrow_downward,
                            ),
                            SizedBox(width: 10),
                            _buildSortButton(
                              context,
                              "Oldest",
                              SortOption.oldestFirst,
                              sortOption,
                              Icons.arrow_upward,
                            ),
                            SizedBox(width: 10),
                            _buildSortButton(
                              context,
                              "A-Z",
                              SortOption.titleAZ,
                              sortOption,
                            ),
                            SizedBox(width: 10),
                            _buildSortButton(
                              context,
                              "Z-A",
                              SortOption.titleZA,
                              sortOption,
                            ),
                          ],
                        ),
                      );
                    }
                ),
                SizedBox(height: 10,),
                Divider(thickness: 1,),
                SizedBox(height: 10,),
                Expanded(
                    child: BlocBuilder<NoteBloc, NoteState>(
                        builder: (context, state){
                          if(state is NoteLoading){
                            return const Center(child: CircularProgressIndicator());
                          }
                          if(state is NoteError){
                            return Center(child: Text('Error: ${state.message}'));
                          }
                          if(state is NoteLoaded){
                            if(state.notes.isEmpty){
                              return Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      state.isSearching ? Icons.search_off : Icons.note_add_outlined,
                                      size: 80,
                                      color: Colors.grey[400],
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      state.isSearching ? 'No results found' : 'No notes yet!',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.grey[600],
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      state.isSearching ? 'Try a different search term' :'Tap + to create your first note',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.grey[500],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }
                            return ListView.separated(
                                itemCount: state.notes.length,
                                separatorBuilder: (context, index) => SizedBox(height: 10),
                                itemBuilder: (context, index){
                                  final note = state.notes[index];
                                  return _buildNoteCard(context, note);
                                }
                            );
                          }
                          return const SizedBox();
                        }
                    )
                )
              ]
          ),
        )
      ),
    );
  }

  Widget _buildNoteCard(BuildContext context, NoteModel note) {
    return Container(
      decoration: BoxDecoration(
          color: Color(note.color).withValues(alpha: 0.7),
          borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: ListTile(
        minVerticalPadding: 12,
        title: Text(
          note.title,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 12),
            Text(
              note.content,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Text(
              DateFormat('MMM dd, yyyy').format(note.updatedAt),
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
        onTap: () => _navigateToEditor(context, note),
        onLongPress: () => showDeleteSheet(context, note),
      ),
    );
  }

  void _navigateToEditor(BuildContext context, NoteModel? note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note),
      ),
    );
  }

  Widget _buildSortButton(
      BuildContext context,
      String label,
      SortOption sortOption,
      SortOption currentSortOption,
      [IconData? icon]
      ) {
    final isSelected = currentSortOption == sortOption;

    return GestureDetector(
      onTap: () {
        context.read<SortCubit>().setSortOption(sortOption);
      },
      child: Container(
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surfaceVariant,
          borderRadius: BorderRadius.all(Radius.circular(50)),
          border: isSelected
              ? Border.all(
            color: Theme.of(context).colorScheme.primary,
            width: 2,
          )
              : null,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  size: 16,
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                SizedBox(width: 6),
              ],
              Text(
                label,
                style: TextStyle(
                  color: isSelected
                      ? Theme.of(context).colorScheme.onPrimary
                      : Theme.of(context).colorScheme.onSurfaceVariant,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}