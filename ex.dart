import 'dart:io';

class Note {
  late String title;
  late String content;

  Note({
    required this.title,
    required this.content,
  });
}

class NoteApp {
  late List<Note> notes;

  NoteApp() {
    notes = [];
  }

  /// Displays the menu options for the note-taking app.
  void displayMenu() {
    print('\nNote Taking App Menu:');
    print('1. Create a note');
    print('2. Edit a note');
    print('3. Delete a note');
    print('4. Search for a note');
    print('5. Display all notes');
    print('6. Exit');
  }

  /// Creates a new note based on user input.
  void createNote() {
    try {
      print('Enter note title:');
      var title = stdin.readLineSync()!;
      print('Enter note content (type "@" on a new line when done):');
      var content = _readMultilineInput();
      var note = Note(
        title: title,
        content: content,
      );
      notes.add(note);
      print('Note created successfully!');
    } catch (e) {
      print('Error creating note: $e');
    }
  }

  /// Edits an existing note based on user input.
  void editNote() {
    try {
      print('Enter the title of the note to edit:');
      var title = stdin.readLineSync()!;
      var noteIndex = notes.indexWhere((note) => note.title == title);
      if (noteIndex != -1) {
        print('Original content:');
        print(notes[noteIndex].content);
        print('Enter new content (type "@" on a new line when done):');
        var newContent = _readMultilineInput();
        notes[noteIndex].content = newContent;
        print('Note edited successfully!');
      } else {
        print('Note with title "$title" not found.');
      }
    } catch (e) {
      print('Error editing note: $e');
    }
  }

  /// Deletes an existing note based on user input.
  void deleteNote() {
    try {
      print('Enter the title of the note to delete:');
      var title = stdin.readLineSync()!;
      var noteIndex = notes.indexWhere((note) => note.title == title);
      if (noteIndex != -1) {
        notes.removeAt(noteIndex);
        print('Note deleted successfully!');
      } else {
        print('Note with title "$title" not found.');
      }
    } catch (e) {
      print('Error deleting note: $e');
    }
  }

  /// Searches for notes containing a specific term in their title or content.
  void searchNote() {
    try {
      print('Enter search term (title or content):');
      var term = stdin.readLineSync()!;
      var matchingNotes = notes.where((note) =>
          note.title.contains(term) || note.content.contains(term)).toList();
      if (matchingNotes.isNotEmpty) {
        print('Search results:');
        matchingNotes.forEach((note) {
          print('Title: ${note.title}');
          print('Content: ${note.content}\n');
        });
      } else {
        print('No notes found matching the search term.');
      }
    } catch (e) {
      print('Error searching for note: $e');
    }
  }

  /// Displays all existing notes.
  void displayNotes() {
    if (notes.isNotEmpty) {
      print('All Notes:');
      notes.forEach((note) {
        print('Title: ${note.title}');
        print('Content: ${note.content}\n');
        print('###################');
      });
    } else {
      print('No notes available.');
    }
  }

  /// Reads multiline input until the user types "@" on a new line.
  String _readMultilineInput() {
    var inputLines = <String>[];
    while (true) {
      var line = stdin.readLineSync()!;
      if (line.trim() == '@') {
        break;
      }
      inputLines.add(line);
    }
    return inputLines.join('\n');
  }

  /// Runs the note-taking app.
  void run() {
    try {
      var choice;
      do {
        displayMenu();
        choice = stdin.readLineSync();
        switch (choice) {
          case '1':
            createNote();
            break;
          case '2':
            editNote();
            break;
          case '3':
            deleteNote();
            break;
          case '4':
            searchNote();
            break;
          case '5':
            displayNotes();
            break;
          case '6':
            print('Exiting...');
            break;
          default:
            print('Invalid choice. Please try again.');
        }
      } while (choice != '6');
    } catch (e) {
      print('An unexpected error occurred: $e');
    }
  }
}

void main() {
  var noteApp = NoteApp();
  noteApp.run();
}
