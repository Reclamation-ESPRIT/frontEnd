import 'package:flutter/material.dart';
import 'package:reclamationapp/Util/theme.dart';

class ReclamationCard extends StatelessWidget {
  final String? emailSender;
  final String? objectReclamation;

  const ReclamationCard(
      {super.key, required this.emailSender, required this.objectReclamation});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
          padding: const EdgeInsets.all(5),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.7),
                  blurRadius: 7,
                  offset: const Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'from : $emailSender',
                        style: const TextStyle(
                          color: AppTheme.lightPrimaryText,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'object $objectReclamation',
                        style: const TextStyle(
                          color: AppTheme.lightSecondaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
