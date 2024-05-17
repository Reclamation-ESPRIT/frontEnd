import 'package:flutter/material.dart';

class CustomAlert extends StatelessWidget {
  const CustomAlert({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Reclamation Details'),
    );
  }
}
