import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reclamationapp/Util/constant.dart';
import 'package:reclamationapp/models/reclamation.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

class ReclamationService {
  final String url = "$baseUrl/api/reclamation";

  //getAll Reclamation

  Future<List<Reclamation>> getAllReclamation(BuildContext buildContext) async {
    //var
    List<Reclamation> reclamations = [];

    //url

    //Headers
    var headers = {"Content-Type": "application/json"};

    //request
    await http.get(Uri.parse(url), headers: headers).then((response) {
      if (response.statusCode == 200) {
        List<dynamic> dynamics = json.decode(response.body)['reclamations'];
        for (var reclamation in dynamics) {
          reclamations.add(Reclamation.fromJson(reclamation));
        }
      } else {
        showDialog(
          context: buildContext,
          builder: (context) {
            return AlertDialog(
              title: const Text("Warning"),
              content: const Text("Something went wrong! Try again later."),
              actions: [
                TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text("OK"))
              ],
            );
          },
        );
      }
    });
    return reclamations;
  }

  //get Reclamations by email
  Future<List<Reclamation>> getReclamationByEmail(String email) async {
    final response =
        await http.get(Uri.parse('$url/reclamationByEmail/$email'));

    if (response.statusCode == 200) {
      final jsonBody = json.decode(response.body);
      final reclamationsJson = jsonBody['reclamations'] as List<dynamic>;
      final reclamations = reclamationsJson
          .map((json) => Reclamation.fromJson(json as Map<String, dynamic>))
          .toList();
      return reclamations;
    } else {
      if (response.statusCode == 408) {
        return [];
      }
      throw Exception('Failed to load reclamations');
    }
  }

//add new reclamattion
  Future<bool> addNewReclamation(
      Map<String, dynamic> body, XFile? image) async {
    try {
      Dio dio = Dio();
      dio.options.headers['Accept'] = 'application/json; charset=utf-8';
      dio.options.headers['Content-Type'] = 'multipart/form-data';
      FormData formData;
      if (image == null) {
        formData = FormData.fromMap({
          "sender": body['sender'],
          "object": body['object'],
          "message": body['message'],
        });
      } else {
        var fileTest = await MultipartFile.fromFile(image.path,
            filename: image.path.split('/').last);
        formData = FormData.fromMap({
          "sender": body['sender'],
          "object": body['object'],
          "message": body['message'],
          "image": fileTest
        });
      }
      Response response = await dio.post(
        "$url/create",
        data: formData,
      );

      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception('Failed to add reclamation.');
    }
  }

  Future<bool> archievedReclamation(String id) async {
    final response = await http.put(Uri.parse("$url/archieved/$id"));
    if (response.statusCode == 200) return true;
    return false;
  }

  Future<bool> sendReclamationAnswer(String id, String answer) async {
    final Map<String, String> body = {
      'answer': answer,
    };
    final response = await http.put(Uri.parse("$url/update/$id"), body: body);
    if (response.statusCode == 200) return true;
    return false;
  }
}
