import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/note.dart';

class NotesState {
  final List<Note> notes;
  final bool isLoading;
  final String? errorMessage;

  NotesState({
    this.notes = const [],
    this.isLoading = false,
    this.errorMessage,
  });

  NotesState copyWith({
    List<Note>? notes,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NotesState(
      notes: notes ?? this.notes,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }

  List<Note> get pinnedNotes => notes.where((n) => n.isPinned).toList();
  List<Note> get unpinnedNotes => notes.where((n) => !n.isPinned).toList();
}

class NotesNotifier extends StateNotifier<NotesState> {
  NotesNotifier() : super(NotesState()) {
    loadNotes();
  }

  Future<void> loadNotes() async {
    state = state.copyWith(isLoading: true);

    try {
      await Future.delayed(const Duration(milliseconds: 500));

      // Sample notes - in production, load from local database
      final sampleNotes = [
        Note(
          id: 1,
          title: 'NOTE',
          content: 'Asante kwa kuinstall app. Hapa utapa breaking news, ujumbe mbali mbali wa kazi, vichekesho na mengineyo. Copy link hii kushare.',
          createdAt: DateTime.now().subtract(const Duration(days: 1)),
          isPinned: true,
        ),
        Note(
          id: 2,
          title: 'Shopping List',
          content: '- Milk\n- Bread\n- Eggs\n- Fruits',
          createdAt: DateTime.now().subtract(const Duration(hours: 5)),
        ),
        Note(
          id: 3,
          title: 'Meeting Notes',
          content: 'Discuss project timeline and deliverables with the team.',
          createdAt: DateTime.now().subtract(const Duration(hours: 12)),
        ),
      ];

      state = state.copyWith(
        notes: sampleNotes,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  Future<void> addNote(String title, String content) async {
    final newNote = Note(
      id: DateTime.now().millisecondsSinceEpoch,
      title: title.isEmpty ? 'Untitled' : title,
      content: content,
      createdAt: DateTime.now(),
    );

    state = state.copyWith(
      notes: [newNote, ...state.notes],
    );

    // TODO: Save to local database
  }

  Future<void> updateNote(int id, String title, String content) async {
    final notes = state.notes.map((note) {
      if (note.id == id) {
        return note.copyWith(
          title: title.isEmpty ? 'Untitled' : title,
          content: content,
          updatedAt: DateTime.now(),
        );
      }
      return note;
    }).toList();

    state = state.copyWith(notes: notes);

    // TODO: Update in local database
  }

  Future<void> deleteNote(int id) async {
    final notes = state.notes.where((note) => note.id != id).toList();
    state = state.copyWith(notes: notes);

    // TODO: Delete from local database
  }

  Future<void> togglePin(int id) async {
    final notes = state.notes.map((note) {
      if (note.id == id) {
        return note.copyWith(isPinned: !note.isPinned);
      }
      return note;
    }).toList();

    state = state.copyWith(notes: notes);
  }
}

final notesProvider = StateNotifierProvider<NotesNotifier, NotesState>((ref) {
  return NotesNotifier();
});
