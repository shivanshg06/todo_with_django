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
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          buttons(
            'add',
            () {},
            1,
          ),
          buttons(
            'cancel',
            () {},
            0,
          ),
        ],
      ),
    );
  }

  buttons(String title, Function func, int good) {
    return GestureDetector(
      onTap: func(),
      child: Container(
        decoration: BoxDecoration(
          color: good == 1 ? Colors.blue : Colors.red,
          borderRadius: BorderRadius.all(
            Radius.circular(15),
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 20,
        child: Text(title),
      ),
    );
  }
}
