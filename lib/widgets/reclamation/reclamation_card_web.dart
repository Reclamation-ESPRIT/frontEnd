import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamationapp/Services/reclamation.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/models/reclamation.dart';
import 'package:reclamationapp/providers/reclamation.dart';
import 'package:reclamationapp/screen/reclamation/web/manage_reclamation.dart';

class ReclamationListdWeb extends StatefulWidget {
  final List<Reclamation>? reclamations;

  const ReclamationListdWeb({super.key, required this.reclamations});

  @override
  State<ReclamationListdWeb> createState() => _ReclamationListdWebState();
}

class _ReclamationListdWebState extends State<ReclamationListdWeb> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        return Padding(
            padding: const EdgeInsets.all(5),
            child: Container(
              width: constraints.maxWidth * 0.9,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppTheme.lightBackground),
              child: SizedBox(
                child: DataTable(
                  columns: const <DataColumn>[
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Sender',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Subject',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Expanded(
                        child: Text(
                          'Status',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    DataColumn(
                      label: Center(
                        child: Text(
                          'Action',
                          style: TextStyle(
                              fontStyle: FontStyle.italic,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                  ],
                  rows: widget.reclamations!.map((reclamation) {
                    return DataRow(
                      cells: <DataCell>[
                        DataCell(Text(reclamation.sender!)),
                        DataCell(Text(reclamation.object!.length > 20
                            ? '${reclamation.object!.substring(0, 20)}...'
                            : reclamation.object!)),
                        DataCell(reclamation.status!
                            ? Icon(
                                Icons.download_done_rounded,
                                color: Colors.green.shade400,
                              )
                            : Icon(
                                Icons.block_flipped,
                                color: Colors.red.shade400,
                              )),
                        DataCell(Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                Provider.of<ReclamationsProvider>(context,
                                        listen: false)
                                    .setCurrentReclamation(reclamation);
                                Navigator.pushNamed(
                                  context,
                                  ManageReclamationScreen.routeName,
                                );
                              },
                              icon: Icon(
                                Icons.edit_document,
                                color: Colors.green.shade200,
                              ),
                            ),
                            IconButton(
                              onPressed: () async {
                                ReclamationService reclamationService =
                                    ReclamationService();
                                if (await reclamationService
                                    .archievedReclamation(reclamation.id!)) {
                                  Provider.of<ReclamationsProvider>(context,
                                          listen: false)
                                      .deleteReclamation(reclamation);
                                }
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Colors.red.shade200,
                              ),
                            ),
                          ],
                        )),
                      ],
                    );
                  }).toList(),
                ),
              ),
            ));
      },
    );
  }
}
