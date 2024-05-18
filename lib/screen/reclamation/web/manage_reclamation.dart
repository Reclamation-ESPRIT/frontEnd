import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamationapp/providers/reclamation.dart';

class ManageReclamationScreen extends StatefulWidget {
  static const routeName = '/manageReclamation';

  const ManageReclamationScreen({super.key});

  @override
  State<ManageReclamationScreen> createState() =>
      _ManageReclamationScreenState();
}

class _ManageReclamationScreenState extends State<ManageReclamationScreen> {
  @override
  Widget build(BuildContext context) {
    //TODO Bug : when refresh data lost mmc
    final reclamation =
        //   ModalRoute.of(context)?.settings.arguments as Reclamation;
        Provider.of<ReclamationsProvider>(context).getCurrentReclamation();
    final responseController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Reclamation'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "object: ${reclamation.object}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text("object: ${reclamation.object}"),
            const SizedBox(height: 16.0),
            Text(
              'Message: ${reclamation.message}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            Text('date : : ${reclamation.createdAt}'),
            const SizedBox(height: 16.0),
            const Text(
              'Created At',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8.0),
            const Text('2024-05-08T02:44:06.103Z'),
            const SizedBox(height: 32.0),
            TextField(
              controller: responseController,
              decoration: const InputDecoration(
                labelText: 'Add a note',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                //TODO implement add reclamation 
              //  print('Note: ${responseController.text}');
              },
              child: const Text('Add Note'),
            ),
          ],
        ),
      ),
    );
  }
}
