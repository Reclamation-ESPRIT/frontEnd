import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:reclamationapp/Util/constant.dart';
import 'package:reclamationapp/models/reclamation.dart';

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
        //TODO improve this func with provider
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
  Future<void> addNewReclamation(Reclamation reclamation) async {
    try {
      var request = http.MultipartRequest('POST', Uri.parse('$url/create'));

      // Add the text fields to the request
      request.fields.addAll(reclamation
          .toJson()
          .map((key, value) => MapEntry(key, value.toString())));

      // Add the file to the request
      if (reclamation.attachFiles != null) {
        request.files.add(await http.MultipartFile.fromPath(
            'file', reclamation.attachFiles!.path));
      }

      // Send the request
      var response = await request.send();

      // Check the response status
      if (response.statusCode == 201) {
        print('Reclamation created successfully');
      } else {
        print('Failed to create reclamation: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error creating reclamation: $error');
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
