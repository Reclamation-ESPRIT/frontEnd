import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamationapp/Services/reclamation.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/models/reclamation.dart';
import 'package:reclamationapp/providers/reclamation.dart';
import 'package:reclamationapp/screen/auth/login.dart';
import 'package:reclamationapp/widgets/reclamation/reclamation_card_web.dart';

class ReclamationScreen extends StatefulWidget {
  //Route
  static const String routeName = "/reclamation";

  const ReclamationScreen({super.key});

  @override
  State<ReclamationScreen> createState() => _ReclamationScreenState();
}

class _ReclamationScreenState extends State<ReclamationScreen> {
  ReclamationService reclamationService = ReclamationService();
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final reclamationProvider = Provider.of<ReclamationsProvider>(context);

    //init reclamation
    reclamationProvider.initReclamation(context);
    List<Reclamation> reclamations =
        Provider.of<ReclamationsProvider>(context).getReclamations();
    return Scaffold(
      backgroundColor: AppTheme.lightBackground,
      body: LayoutBuilder(
        builder: (context, BoxConstraints constraints) {
          return Container(
            // decoration: const BoxDecoration(color: AppTheme.lightBackground),
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
                        FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pushReplacementNamed(
                                  context, LoginScreen.routeName);
                            },
                            child: const Text(
                              '🏠 logout',
                              style: TextStyle(
                                color: AppTheme.lightPrimary,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            )),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          FilledButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                            ),
                            onPressed: () {
                              Provider.of<ReclamationsProvider>(context,
                                      listen: false)
                                  .setReclamations([]);
                              Provider.of<ReclamationsProvider>(context,
                                      listen: false)
                                  .initReclamation(context);
                            },
                            child: const Text(
                              "⟲ Refresh",
                              style: TextStyle(
                                color: AppTheme.lightSecondaryText,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ReclamationListdWeb(
                        reclamations: reclamations,
                      ),
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
