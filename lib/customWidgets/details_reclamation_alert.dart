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
          Text('Sender: \n${reclamation.sender}'),
          Text('Status: \n${reclamation.status}'),
          Text(
              'Created \nAt: ${reclamation.createdAt}/${reclamation.createdAt}/${reclamation.createdAt}'),
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
