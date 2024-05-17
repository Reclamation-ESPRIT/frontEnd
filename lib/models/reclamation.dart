import 'dart:io';

class Reclamation {
  String? object;
  String? message;
  File? attachFiles;
  String? sender;
  bool? status;
  String? createdAt;
  String? updatedAt;


  Reclamation({
    this.object,
    this.message,
    this.attachFiles,
    this.sender,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  // Encode the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "object": object,
      "message": message,
      "attachFiles": attachFiles,
      "sender": sender,
      // "status": false,
    };
  }

  // Decode JSON to object
  static Reclamation fromJson(Map<String, dynamic> json) {
    return Reclamation(
      object: json['object'],
      message: json['message'],
      sender: json['sender'],
      status: json['status'],
      attachFiles: json['attachFiles'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  @override
  String toString() {
    return 'Reclamation{object: $object, message: $message, sender: $sender, status: $status, attachFiles : $attachFiles createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
