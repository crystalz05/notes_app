import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../models/note.dart';

void showDeleteSheet(BuildContext context, NoteModel note) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) {
      return TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: 1.0),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Transform.translate(
            offset: Offset(0, (1 - value) * 100),
            child: Opacity(
              opacity: value,
              child: Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                  borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                ),
                child: SafeArea(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // drag handle
                      Container(
                        margin: const EdgeInsets.only(top: 12),
                        width: 40,
                        height: 4,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        leading: const Icon(Icons.delete_outline, color: Colors.red),
                        title: Text(
                          'Delete "${note.title}"',
                          style: const TextStyle(color: Colors.red),
                        ),
                        onTap: () {
                          Navigator.pop(context); // close sheet first
                          context.read<NoteBloc>().add(DeleteNote(note));
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.close),
                        title: const Text('Cancel'),
                        onTap: () => Navigator.pop(context),
                      ),
                      const SizedBox(height: 8),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      );
    },
  );
}