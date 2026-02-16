import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:share_plus/share_plus.dart';
import '../../data/models/note.dart';
import 'notepad_provider.dart';
import 'note_editor_screen.dart';

class NotesListScreen extends ConsumerWidget {
  const NotesListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notesState = ref.watch(notesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('UJUMBE'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () => _shareApp(context),
          ),
        ],
      ),
      body: notesState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : notesState.notes.isEmpty
              ? _buildEmptyState(context)
              : _buildNotesList(context, ref, notesState),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _openNoteEditor(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.note_outlined, size: 64, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No notes yet',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 8),
          const Text('Tap + to create a new note'),
        ],
      ),
    );
  }

  Widget _buildNotesList(BuildContext context, WidgetRef ref, NotesState state) {
    final pinnedNotes = state.pinnedNotes;
    final unpinnedNotes = state.unpinnedNotes;

    return ListView(
      padding: const EdgeInsets.all(8),
      children: [
        if (pinnedNotes.isNotEmpty) ...[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Text(
              'Pinned',
              style: TextStyle(
                color: Colors.grey[600],
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          ...pinnedNotes.map((note) => _NoteCard(
                note: note,
                onTap: () => _openNoteEditor(context, note: note),
                onLongPress: () => _showNoteOptions(context, ref, note),
              )),
          const SizedBox(height: 16),
        ],
        if (unpinnedNotes.isNotEmpty) ...[
          if (pinnedNotes.isNotEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                'Others',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ...unpinnedNotes.map((note) => _NoteCard(
                note: note,
                onTap: () => _openNoteEditor(context, note: note),
                onLongPress: () => _showNoteOptions(context, ref, note),
              )),
        ],
      ],
    );
  }

  void _openNoteEditor(BuildContext context, {Note? note}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NoteEditorScreen(note: note),
      ),
    );
  }

  void _showNoteOptions(BuildContext context, WidgetRef ref, Note note) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Icon(note.isPinned ? Icons.push_pin : Icons.push_pin_outlined),
            title: Text(note.isPinned ? 'Unpin' : 'Pin'),
            onTap: () {
              ref.read(notesProvider.notifier).togglePin(note.id);
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.copy),
            title: const Text('Copy to clipboard'),
            onTap: () {
              Clipboard.setData(ClipboardData(text: note.content));
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Copied to clipboard')),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: const Text('Share'),
            onTap: () {
              Navigator.pop(context);
              Share.share('${note.title}\n\n${note.content}');
            },
          ),
          ListTile(
            leading: const Icon(Icons.delete_outline, color: Colors.red),
            title: const Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () {
              Navigator.pop(context);
              _confirmDelete(context, ref, note);
            },
          ),
        ],
      ),
    );
  }

  void _confirmDelete(BuildContext context, WidgetRef ref, Note note) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Note'),
        content: const Text('Are you sure you want to delete this note?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              ref.read(notesProvider.notifier).deleteNote(note.id);
              Navigator.pop(context);
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _shareApp(BuildContext context) {
    Share.share(
      'Check out Habari Sasa App: https://play.google.com/store/apps/details?id=felijose.com.bloggerframework',
      subject: 'Habari Sasa App',
    );
  }
}

class _NoteCard extends StatelessWidget {
  final Note note;
  final VoidCallback onTap;
  final VoidCallback onLongPress;

  const _NoteCard({
    required this.note,
    required this.onTap,
    required this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
      child: InkWell(
        onTap: onTap,
        onLongPress: onLongPress,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      note.title.toUpperCase(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  if (note.isPinned)
                    Icon(Icons.push_pin, size: 16, color: Colors.grey[600]),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                note.content,
                style: TextStyle(
                  color: Colors.grey[700],
                  height: 1.4,
                ),
                maxLines: 4,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    timeago.format(note.updatedAt ?? note.createdAt),
                    style: TextStyle(
                      color: Colors.grey[500],
                      fontSize: 12,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.share, size: 18, color: Colors.grey[500]),
                    onPressed: () {
                      Share.share('${note.title}\n\n${note.content}');
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
