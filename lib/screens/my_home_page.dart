import 'package:anecnote/components/drawer.dart';
import 'package:anecnote/components/note_tiles.dart';
import 'package:anecnote/models/note_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/note.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Since fetching notes is asynchronous, we need to wait until the widget is fully initialized
    WidgetsBinding.instance?.addPostFrameCallback((_) {
      readNotes();
    });
  }

  void createNote() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              await context.read<NoteDatabase>().addNote(textController.text);
              Navigator.pop(context);
              textController.clear();
              readNotes(); // Refresh notes after adding a new one
            },
            child: const Text('Create'),
          ),
        ],
      ),
    );
  }

  Future<void> readNotes() async {
    await context.read<NoteDatabase>().fetchNotes();
  }

  void updateNote(Note note) {
    textController.text = note.text;
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Update"),
        content: TextField(
          controller: textController,
        ),
        actions: [
          MaterialButton(
            onPressed: () async {
              await context
                  .read<NoteDatabase>()
                  .updateNote(note.id, textController.text);
              Navigator.pop(context);
              textController.clear();
              readNotes(); // Refresh notes after updating
            },
            child: const Text('Update'),
          ),
        ],
      ),
    );
  }

  void deleteNote(int id) async {
    await context.read<NoteDatabase>().deleteNote(id);
    readNotes(); // Refresh notes after deletion
  }

  @override
  Widget build(BuildContext context) {
    final noteDatabase = context.watch<NoteDatabase>();
    final currentNotes = noteDatabase.currentNotes;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: createNote,
        child: Icon(Icons.add, color: Theme.of(context).colorScheme.inversePrimary,),
      ),
      drawer: const MyDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Text("NOTES", style: GoogleFonts.dmSans(fontSize:45,
            color: Theme.of(context).colorScheme.inversePrimary
            ),
            ),

          ),
          Expanded(
            child: ListView.builder(
              itemCount: currentNotes.length,
              itemBuilder: (context, index) {
                final note = currentNotes[index];
            
                return NoteTiles(text: note.text, onEditPressed:()=> updateNote(note), onDeletePressed: ()=> deleteNote(note.id), );
              },
            ),
          ),
        ],
      ),
    );
  }
}
