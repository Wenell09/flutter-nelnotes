import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_nelnotes/data/base_url/base_url.dart';
import 'package:flutter_nelnotes/data/models/note_model.dart';
import 'package:http/http.dart' as http;

class NoteRepository {
  Future<List<NoteModel>> fetchNote(String userId) async {
    try {
      final response = await http.get(Uri.parse("$baseUrl/note/$userId"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        return result.map((json) => NoteModel.fromJson(json)).toList();
      } else {
        throw Exception("gagal get note");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }

  Future<List<NoteModel>> fetchDetailNote(String userId, String noteId) async {
    try {
      final response =
          await http.get(Uri.parse("$baseUrl/note/$userId/$noteId"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        return result.map((json) => NoteModel.fromJson(json)).toList();
      } else {
        throw Exception("Gagal get detail note");
      }
    } catch (e) {
      throw Exception("Error:$e");
    }
  }

  Future<void> addNote(String userId, String title, String deskripsi) async {
    try {
      Map<String, dynamic> data = {
        "user_id": userId,
        "title": title,
        "deskripsi": deskripsi,
      };
      final response = await http.post(
        Uri.parse("$baseUrl/addNote"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint("result :${response.body}");
      } else {
        debugPrint("Gagal buat note");
      }
    } catch (e) {
      debugPrint("Error:$e");
    }
  }

  Future<void> editNote(
    String userId,
    String noteId,
    String title,
    String deskripsi,
  ) async {
    try {
      Map<String, dynamic> data = {
        "title": title,
        "deskripsi": deskripsi,
      };

      final response = await http.patch(
        Uri.parse("$baseUrl/editNote/$userId/$noteId"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(data),
      );
      if (response.statusCode == 200) {
        debugPrint("result :${response.body}");
      } else {
        debugPrint("gagal hapus note");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
  }

  Future<void> deleteNote(String userId, String noteId) async {
    try {
      String isNotId = "";
      if (noteId.isNotEmpty) {
        isNotId = noteId;
      }
      final response =
          await http.delete(Uri.parse("$baseUrl/deleteNote/$userId/$isNotId"));
      if (response.statusCode == 200) {
        debugPrint("result :${response.body}");
      } else {
        debugPrint("gagal hapus note");
      }
    } catch (e) {
      debugPrint("error:$e");
    }
  }

  Future<List<NoteModel>> searchNote(String userId, title) async {
    try {
      final response = await http
          .get(Uri.parse("$baseUrl/searchNote?user_id=$userId&title=$title"));
      if (response.statusCode == 200) {
        final List result = jsonDecode(response.body)["data"];
        return result.map((json) => NoteModel.fromJson(json)).toList();
      } else {
        throw Exception("Gagal search note");
      }
    } catch (e) {
      throw Exception("error:$e");
    }
  }
}
