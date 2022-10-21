// ignore_for_file: prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:alert_dialog/alert_dialog.dart';
import '../urls.dart';
import 'update.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GetNotesClass notesService = GetNotesClass();
  TextEditingController noteConroller = TextEditingController();
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CRUD practice'),
      ),
      body: FutureBuilder(
        future: notesService.getAllNotes(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List notes = snapshot.data!;
            for (var element in notes) {
              log('${element["body"]}\n');
            }
            log('working');
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(
                      snapshot.data![index]['body'],
                      style: TextStyle(
                          // fontSize: 30.0,
                          ),
                    ),
                    subtitle: Text(
                      snapshot.data![index]['updated'],
                    ),
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: ((context) => UpdateNotes(
                              id: snapshot.data![index]['id'],
                            )),
                      ),
                    ),
                  ),
                );
              },
            );
          }
          log('snapshot has no data');
          return Center(child: CircularProgressIndicator());
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addNote,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  void _addNote() {
    showDialog(
      context: context,
      builder: (context) => addNoteDialog(),
    );
  }

  addNoteDialog() {
    return AlertDialog(
      title: Text('Add New Note:'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          textfield1(noteConroller),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              buttons(
                'Add',
                () {
                  try {
                    notesService.addNote(noteConroller.text);
                  } catch (e) {
                    log('$e');
                  }
                },
                1,
              ),
              buttons(
                'Cancel',
                () {
                  Navigator.pop(context);
                  log('popped');
                },
                0,
              ),
            ],
          ),
        ],
      ),
    );
  }

  buttons(String title, Function func, int good) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => func(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: 10,
          ),
          height: 20,
          child: Text(title),
        ),
      ),
    );
  }

  textfield1(TextEditingController myController) {
    return TextField(
      controller: myController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        hintText: 'Add your note here',
      ),
    );
  }
}
