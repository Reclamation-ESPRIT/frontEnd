import 'package:flutter/material.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/models/reclamation.dart';

class ReclamationCardMobile extends StatelessWidget {
  final Reclamation? reclamation;

  const ReclamationCardMobile({super.key, required this.reclamation});

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
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'object ${reclamation!.object}',
                            style: const TextStyle(
                              color: AppTheme.lightPrimaryText,
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // SizedBox(
                          //   width: constraints.maxWidth * 0.47,
                          // ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${reclamation!.message!.length > 20 ? '${reclamation!.message!.substring(0, 26)}...' : reclamation!.message}',
                        style: const TextStyle(
                          color: AppTheme.lightSecondaryText,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                  reclamation!.status!
                      ? const Icon(
                          Icons.done,
                          color: Colors.green,
                        )
                      : const Icon(
                          Icons.not_interested_sharp,
                          color: Colors.red,
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
