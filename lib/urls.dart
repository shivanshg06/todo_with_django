import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;

class GetNotesClass {
  String baseUrl = 'http://10.0.2.2:8000/notes/';
  Future<List> getAllNotes() async {
    try {
      var response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        log('message');
        log(response.body);
        log('message');
        return jsonDecode(response.body);
      }
      return Future.error('Server Error');
    } catch (e) {
      log('$e');
      return Future.error(e);
    }
  }

  Future getNoteById(var id) async {
    try {
      var response = await http.get(Uri.parse('$baseUrl$id/'));
      if (response.statusCode == 200) {
        log('message');
        log(response.body);
        log('message');
        return jsonDecode(response.body);
      }
      return Future.error('Server Error');
    } catch (e) {
      log('$e');
      return Future.error(e);
    }
  }

  void deleteById(var id) {
    try {
      http.delete(Uri.parse('$baseUrl$id/delete/'));
    } catch (e) {
      log('$e');
    }
  }

  Future addNote(String note) async {
    try {
      await http.put(
        Uri.parse('${baseUrl}create/'),
        body: [
          {"data": note}
        ],
      );
    } catch (e) {
      log('$e');
      // return Future.error(e);
    }
  }
}
