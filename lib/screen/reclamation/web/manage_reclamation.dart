import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reclamationapp/Services/reclamation.dart';
import 'package:reclamationapp/Util/constant.dart';
import 'package:reclamationapp/customWidgets/search_bar.dart';
import 'package:reclamationapp/providers/reclamation.dart';
import 'package:reclamationapp/screen/reclamation/web/reclamation_list.dart';
import 'package:reclamationapp/widgets/reclamation/reclamation_card_mobile.dart';

class ManageReclamationScreen extends StatefulWidget {
  static const routeName = '/manageReclamation';

  const ManageReclamationScreen({Key? key}) : super(key: key);

  @override
  State<ManageReclamationScreen> createState() =>
      _ManageReclamationScreenState();
}

class _ManageReclamationScreenState extends State<ManageReclamationScreen> {
  ReclamationService reclamationService = ReclamationService();

  final TextEditingController responseController = TextEditingController();
  final TextEditingController searchController = TextEditingController();
  late Future<void> reclamations;
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    reclamations = Provider.of<ReclamationsProvider>(context, listen: false)
        .initReclamation(context);
  }

  @override
  Widget build(BuildContext context) {
    final reclamationProvider = Provider.of<ReclamationsProvider>(context);
    final reclamation = reclamationProvider.getCurrentReclamation();

    return Scaffold(
      body: FutureBuilder<void>(
        future: reclamations,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator.adaptive());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            final reclamationsList = reclamationProvider.getReclamations();
            return Column(
              children: [
                // Search Bar
                Row(
                  children: [
                    Expanded(
                      child: CustomSearchBar(
                        controller: searchController,
                        onChanged: (search) {
                          reclamationProvider.searchReclamation(search);
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.list),
                      onPressed: () => Navigator.pushNamed(
                        context,
                        ReclamationScreen.routeName,
                      ),
                    ),
                  ],
                ),

                Expanded(
                  child: Row(
                    children: [
                      // Left Sidebar
                      Expanded(
                        flex: 2,
                        child: Container(
                          color: Colors.grey[200],
                          child: Column(
                            children: [
                              // Reclamation List
                              Expanded(
                                child: reclamationsList.isEmpty
                                    ? const Center(
                                        child: Text('No Reclamations Found'),
                                      )
                                    : ListView(
                                        children: [
                                          // Filter and map Reclamations with status == false
                                          ...reclamationsList
                                              .where((reclamation) =>
                                                  !reclamation.status!)
                                              .map((reclamation) {
                                            return GestureDetector(
                                              onTap: () {
                                                print(reclamation);
                                                reclamationProvider
                                                    .setCurrentReclamation(
                                                        reclamation);
                                              },
                                              child: ReclamationCardMobile(
                                                reclamation: reclamation,
                                              ),
                                            );
                                          }).toList(),
                                          // Filter and map Reclamations with status == true
                                          ...reclamationsList
                                              .where((reclamation) =>
                                                  reclamation.status!)
                                              .map((reclamation) {
                                            return GestureDetector(
                                              onTap: () {
                                                reclamationProvider
                                                    .setCurrentReclamation(
                                                        reclamation);
                                              },
                                              child: ReclamationCardMobile(
                                                reclamation: reclamation,
                                              ),
                                            );
                                          }).toList(),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      // Right Interface
                      Expanded(
                        flex: 5,
                        child: reclamation.id != null
                            ? Column(
                                children: [
                                  // Top Section
                                  Container(
                                    padding: const EdgeInsets.all(16.0),
                                    color: Colors.white,
                                    child: Row(
                                      children: [
                                        Text(
                                          "Subject : ${reclamation.object}",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20),
                                        ),
                                        const Spacer(),
                                        SizedBox(
                                          width: 100,
                                          child: Image.asset(
                                              'assets/images/reclamationLogo.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // Chat Messages
                                  Expanded(
                                    child: ListView(
                                      padding: const EdgeInsets.all(16.0),
                                      children: [
                                        _buildReceivedMessage(
                                          reclamation.sender!,
                                          reclamation.message!,
                                          "${reclamation.createdAt!.substring(8, 10)}-${reclamation.createdAt!.substring(5, 7)}-${reclamation.createdAt!.substring(0, 4)}",
                                          reclamation.attachFiles,
                                        ),
                                        reclamation.answer == null
                                            ? const SizedBox()
                                            : _buildReceivedMessage(
                                                "Admin",
                                                reclamation.answer!,
                                                "${reclamation.createdAt!.substring(8, 10)}-${reclamation.createdAt!.substring(5, 7)}-${reclamation.createdAt!.substring(0, 4)}",
                                                null),
                                      ],
                                    ),
                                  ),

                                  // Message Input
                                  reclamation.answer != null
                                      ? const SizedBox()
                                      : Container(
                                          padding: const EdgeInsets.all(8.0),
                                          color: Colors.white,
                                          child: Row(
                                            children: [
                                              Form(
                                                key: formKey,
                                                child: Expanded(
                                                  child: TextFormField(
                                                    controller:
                                                        responseController,
                                                    maxLines: 5,
                                                    decoration:
                                                        const InputDecoration(
                                                      border:
                                                          OutlineInputBorder(),
                                                      contentPadding:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 20,
                                                              vertical: 15),
                                                      hintText:
                                                          'your answer text',
                                                      hintStyle: TextStyle(
                                                        color: Colors.grey,
                                                        fontSize: 16,
                                                      ),
                                                      prefixIcon: Icon(
                                                        Icons.mail,
                                                        color: Colors.grey,
                                                      ),
                                                    ),
                                                    validator: (value) {
                                                      if (value == null ||
                                                          value.isEmpty) {
                                                        return 'Please enter a message';
                                                      }
                                                      return null;
                                                    },
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(width: 8.0),
                                              IconButton(
                                                icon: const Icon(
                                                    Icons.send_sharp,
                                                    color: Colors.red),
                                                onPressed: () async {
                                                  if (formKey.currentState
                                                          ?.validate() ==
                                                      true) {
                                                    final reclamationSended =
                                                        await reclamationService
                                                            .sendReclamationAnswer(
                                                                reclamation.id!,
                                                                responseController
                                                                    .text);
                                                    if (reclamationSended) {
                                                      reclamation.answer =
                                                          responseController
                                                              .text;
                                                      reclamation.status = true;
                                                      if (!mounted) return;
                                                      Provider.of<ReclamationsProvider>(
                                                              context,
                                                              listen: false)
                                                          .setCurrentReclamation(
                                                              reclamation);
                                                    }
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                        ),
                                ],
                              )
                            : const Center(
                                child: Text(
                                  'Select a Reclamation to view details',
                                  style: TextStyle(fontSize: 18.0),
                                ),
                              ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildReceivedMessage(
      String sender, String message, String time, String? imageURL) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment:
          sender == "Admin" ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        const CircleAvatar(
          backgroundImage: AssetImage("assets/icons/design.png"),
        ),
        const SizedBox(width: 8.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(sender, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 5.0),
            Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.0),
              ),
              child: Text(message),
            ),
            const SizedBox(height: 5.0),
            Text(time, style: TextStyle(color: Colors.grey[600])),
            imageURL != null
                ? Image.network(
                    imageURL,
                    width: width() * 0.2,
                    height: height() * 0.4,
                  )
                : const SizedBox(height: 5.0),
          ],
        ),
      ],
    );
  }
}
