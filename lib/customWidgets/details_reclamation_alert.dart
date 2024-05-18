import 'package:flutter/material.dart';
import 'package:reclamationapp/models/reclamation.dart';

class DetailsReclamationAlert extends StatelessWidget {
  final Reclamation reclamation;

  const DetailsReclamationAlert({Key? key, required this.reclamation})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Reclamation Details'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Object: \n${reclamation.object}'),
          Text('Message: \n${reclamation.message}'),
          Text(
              'Status: \n${!reclamation.status! ? " in progress " : " traited "}'),
          Text(
              'sended in : ${reclamation.createdAt!.substring(8, 10)}-${reclamation.createdAt!.substring(5, 7)}-${reclamation.createdAt!.substring(0, 4)}'),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Close'),
        ),
      ],
    );
  }
}
