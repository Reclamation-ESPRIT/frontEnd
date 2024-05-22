class Reclamation {
  String? id;
  String? object;
  String? message;
  String? attachFiles;
  String? sender;
  bool? status;
  bool? archived;
  String? createdAt;
  String? updatedAt;
  String? answer;

  Reclamation({
    this.id,
    this.object,
    this.message,
    this.attachFiles,
    this.sender,
    this.status,
    this.archived,
    this.answer,
    this.createdAt,
    this.updatedAt,
  });

  // Encode the object to JSON
  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "object": object,
      "message": message,
      //  "attachFiles": attachFiles,
      "sender": sender,
      "archived": archived,
      "status": status,
      "answer": answer,
    };
  }

  // Decode JSON to object
  static Reclamation fromJson(Map<String, dynamic> json) {
    return Reclamation(
      id: json['_id'],
      object: json['object'],
      message: json['message'],
      sender: json['sender'],
      status: json['status'],
      attachFiles: json['attachFiles'],
      archived: json['archived'],
      answer: json['answer'],
      updatedAt: json['updatedAt'],
      createdAt: json['createdAt'],
    );
  }

  @override
  String toString() {
    return 'Reclamation{id: $id, object: $object, message: $message, sender: $sender, status: $status,  answer: $answer, archived: $archived , attachFiles : $attachFiles createdAt: $createdAt, updatedAt: $updatedAt}';
  }
}
