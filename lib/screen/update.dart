// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';

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
            var _myNote = snapshot.data;
            log('$_myNote');
            return Column(
              children: [
                Text(
                  _myNote['body'],
                ),
              ],
            );
          }
          log('snapshot has no data');
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(onPressed: _delete),
    );
  }

  void _delete() {
    notesService.deleteById(widget.id);
    log('Note deleted');
    
  }
}
