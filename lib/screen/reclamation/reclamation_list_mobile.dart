import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamationapp/customWidgets/details_reclamation_alert.dart';
import 'package:reclamationapp/Services/reclamation.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/models/reclamation.dart';
import 'package:reclamationapp/models/user.dart';
import 'package:reclamationapp/providers/reclamation.dart';
import 'package:reclamationapp/screen/auth/login.dart';
import 'package:reclamationapp/screen/reclamation/reclamation_card.dart';

class ReclamationScreenMobile extends StatefulWidget {
  //Route
  static const String routeName = "/reclamationMobile";

  const ReclamationScreenMobile({super.key});

  @override
  State<ReclamationScreenMobile> createState() =>
      _ReclamationScreenMobileState();
}

class _ReclamationScreenMobileState extends State<ReclamationScreenMobile> {
  ReclamationService reclamationService = ReclamationService();
  @override
  Widget build(BuildContext context) {
    final senderEmail = ModalRoute.of(context)?.settings.arguments as User;
    //init reclamation
    Provider.of<ReclamationsProvider>(context, listen: false)
        .initReclamationStudent(senderEmail.email!);
    List<Reclamation> reclamation =
        Provider.of<ReclamationsProvider>(context).getReclamations();
    return Scaffold(
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return Container(
            padding: const EdgeInsets.all(10),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: constraints.maxHeight * 0.15,
                    color: AppTheme.lightBackground.withOpacity(0.1),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: constraints.maxWidth * 0.2,
                          child: Image.asset(
                            "assets/images/LogoEsprit.png",
                            fit: BoxFit.fill,
                          ),
                        ),
                        const Spacer(),
                        OutlinedButton(
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: const Text(
                              'logout',
                              style: TextStyle(color: AppTheme.lightPrimary),
                            )),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      OutlinedButton(
                          onPressed: () {
                            Provider.of<ReclamationsProvider>(context,
                                    listen: false)
                                .setReclamations([]);
                            Provider.of<ReclamationsProvider>(context,
                                    listen: false)
                                .initReclamationStudent(senderEmail.email!);
                          },
                          child: const Text("Refresh")),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ...reclamation
                          .map(
                            (reclamation) => GestureDetector(
                              onTap: () {
                                showDialog(
                                  context: context,
                                  barrierDismissible: true,
                                  builder: (context) {
                                    return DetailsReclamationAlert(
                                      reclamation: reclamation,
                                    );
                                  },
                                );
                              },
                              child: ReclamationCard(
                                emailSender: reclamation.sender,
                                objectReclamation: reclamation.object,
                              ),
                            ),
                          )
                          .toList(),
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
