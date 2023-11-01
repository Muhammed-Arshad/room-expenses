import 'package:flutter/material.dart';
import 'package:roomexps/screens/notes_screen/custom_container.dart';

class NotesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notes'),
      ),
      body: Center(
        child: Column(
          children: [
            CustomContainerNotes(
              date: 'June 20, 2023',
              body: "Lorem Ipsum is simply dummy text of the printing and typesetting ce tntially unchanged. It was popularisesheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              headerColor: Colors.purple,
              bodyColor: Colors.deepPurple,
            ),
            CustomContainerNotes(
              date: 'June 21, 2023',
              body: "Lorem Ipsum is simply dummy text of the printing and typesetting industryriesentially unc60s with  containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.",
              headerColor: Colors.teal,
              bodyColor: Colors.tealAccent,
            ),
          ],
        ),
      ),
    );
  }
}