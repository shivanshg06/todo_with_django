// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_with_django/screen/home.dart';

import '../urls.dart';

class UpdateNotes extends StatefulWidget {
  const UpdateNotes({super.key, required this.id});
  final int id;
  @override
  State<UpdateNotes> createState() => _UpdateNotesState();
}

class _UpdateNotesState extends State<UpdateNotes> {
  GetNotesClass notesService = GetNotesClass();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('note'),
      ),
      body: FutureBuilder(
        future: notesService.getNoteById(widget.id),
        builder: (context, snapshot) {
          log('$snapshot ++++');
          if (snapshot.hasData) {
            var myNote = snapshot.data;
            log('$myNote');
            return Column(
              children: [
                Text(
                  myNote['body'],
                ),
              ],
            );
          }
          log('snapshot has no data');
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _delete,
        child: const Icon(Icons.delete),
      ),
    );
  }

  void _delete() {
    notesService.deleteById(widget.id);
    log('${widget.id} Note deleted');
    Navigator.popUntil(context, (route) => route.isFirst);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: ((context) => MyHomePage()),
      ),
    );
  }
}
