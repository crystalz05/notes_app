import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_bloc.dart';
import 'package:tyro_notes_application/features/notes/bloc/note_event.dart';
import 'package:tyro_notes_application/features/notes/models/note.dart';

class NoteEditorScreen extends StatefulWidget {
  final NoteModel? note;
  const NoteEditorScreen({super.key, this.note});

  @override
  State<NoteEditorScreen> createState() => _NoteEditorScreenState();
}

class _NoteEditorScreenState extends State<NoteEditorScreen> {

  final List<int> availableColors = [
    0xFFF44336, // red
    0xFF2196F3, // blue
    0xFF4CAF50, // green
    0xFFFFEB3B, // yellow
    0xFFFF9800, // orange
    0xFF9C27B0, // purple
    0xFFE91E63, // pink
    0xFF009688, // teal
  ];

  late int selectedColor;

  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool _isEdited = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note?.title ?? '');
    _contentController = TextEditingController(text: widget.note?.content ?? '');

    selectedColor = widget.note?.color ?? availableColors[0];

    _titleController.addListener(() => setState(() => _isEdited = true));
    _contentController.addListener(() => setState(() => _isEdited = true));
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _saveNote() {
    final title = _titleController.text.trim();
    final content = _contentController.text.trim();

    if (title.isEmpty || content.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Title and content cannot be empty'),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    final now = DateTime.now();

    if (widget.note == null) {
      final newNote = NoteModel(
        title: title,
        content: content,
        color: selectedColor,
        createdAt: now,
        updatedAt: now,
      );
      context.read<NoteBloc>().add(AddNote(newNote));
    } else {
      final updatedNote = widget.note!.copyWith(
        title: title,
        content: content,
        color: selectedColor,
        updatedAt: now,
      );
      context.read<NoteBloc>().add(UpdateNote(updatedNote));
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // No Hero wrapper here — Hero lives only on the list card.
    // Wrapping a full Scaffold in Hero causes "descendant of another Hero" errors.
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.note == null ? 'New Note' : 'Edit Note'),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Padding(
            padding: EdgeInsets.only(left: 16),
            child: Icon(Icons.arrow_back_ios),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: _saveNote,
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).colorScheme.primary,
              foregroundColor: Theme.of(context).colorScheme.onPrimary,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: const Text('Save'),
          ),
          const SizedBox(width: 16),
        ],
      ),
      // Moving color picker to bottomNavigationBar so Flutter can correctly
      // position floating SnackBars above it.
      bottomNavigationBar: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        color: Theme.of(context).colorScheme.primary.withValues(alpha: 0.05),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(color: Color(selectedColor)),
            const Padding(
              padding: EdgeInsets.only(left: 16, top: 12),
              child: Text('Color', style: TextStyle(fontWeight: FontWeight.bold)),
            ),
            const Divider(),
            const SizedBox(height: 4),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: availableColors.map((color) {
                  final isSelected = selectedColor == color;
                  return Padding(
                    padding: const EdgeInsets.all(16),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedColor = color;
                        });
                      },
                      child: AnimatedScale(
                        scale: isSelected ? 1.15 : 1.0,
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOutBack,
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          curve: Curves.easeOut,
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color(color),
                            border: isSelected
                                ? Border.all(color: Colors.white, width: 3)
                                : null,
                            boxShadow: isSelected
                                ? [
                              BoxShadow(
                                color: Color(color).withValues(alpha: 0.5),
                                blurRadius: 8,
                                spreadRadius: 2,
                              ),
                            ]
                                : null,
                          ),
                          child: isSelected
                              ? const Icon(Icons.check, color: Colors.white, size: 20)
                              : null,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                  bottom: BorderSide(color: Colors.grey.withValues(alpha: 0.3)),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4),
                child: TextField(
                  style: const TextStyle(fontWeight: FontWeight.bold),
                  textCapitalization: TextCapitalization.sentences,
                  controller: _titleController,
                  decoration: const InputDecoration(
                    hintText: 'Note title',
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    filled: false,
                    contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                  autofocus: false,
                ),
              ),
            ),
            TextField(
              maxLines: null,
              minLines: 5,
              controller: _contentController,
              textCapitalization: TextCapitalization.sentences,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              decoration: const InputDecoration(
                hintText: 'Write your note...',
                filled: false,
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }
}