import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/note_bloc.dart';
import '../bloc/note_event.dart';
import '../models/note.dart';

void showDeleteSheet(BuildContext context, NoteModel note) {
  showModalBottomSheet(
    context: context,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
    ),
    builder: (_) {
      return SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // drag handle
            Container(
              margin: EdgeInsets.only(top: 12),
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 12),
            ListTile(
              leading: Icon(Icons.delete_outline, color: Colors.red),
              title: Text(
                'Delete "${note.title}"',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                Navigator.pop(context); // close sheet first
                context.read<NoteBloc>().add(DeleteNote(note));
              },
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Cancel'),
              onTap: () => Navigator.pop(context),
            ),
            SizedBox(height: 8),
          ],
        ),
      );
    },
  );
}