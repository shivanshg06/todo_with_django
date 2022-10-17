// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:todo_with_django/screen/update.dart';
import 'package:todo_with_django/urls.dart';

import 'note.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  GetNotesClass notesService = GetNotesClass();

  void _addNote() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
                      style: TextStyle(
                          // fontSize: 20.0,
                          ),
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
}
