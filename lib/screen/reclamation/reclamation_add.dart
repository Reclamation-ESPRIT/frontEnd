import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reclamationapp/Services/reclamation.dart';
import 'package:reclamationapp/Util/theme.dart';
import 'package:reclamationapp/models/reclamation.dart';
import 'package:reclamationapp/models/user.dart';
import 'package:reclamationapp/screen/reclamation/reclamation_list_mobile.dart';

class AddReclamationScreen extends StatefulWidget {
  static const routeName = '/addReclamation';

  //final String studentEmail;

  const AddReclamationScreen({Key? key}) : super(key: key);

  @override
  AddReclamationScreenState createState() => AddReclamationScreenState();
}

class AddReclamationScreenState extends State<AddReclamationScreen> {
  final formKey = GlobalKey<FormState>();

  final TextEditingController objecttController = TextEditingController();
  final TextEditingController msgController = TextEditingController();

  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on PlatformException catch (e) {
      throw Exception('Failed to pick image $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final connectedUser = ModalRoute.of(context)?.settings.arguments as User;
    return LayoutBuilder(builder: (context, BoxConstraints constraints) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Add Reclamation'),
          actions: [
            IconButton(
              icon: const Icon(Icons.list),
              onPressed: () {
                Navigator.pushNamed(context, ReclamationScreenMobile.routeName,
                    arguments: connectedUser);
              },
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: constraints.maxWidth * 0.09,
                    backgroundImage:
                        NetworkImage(connectedUser.profilePicture!),
                  ),
                  SizedBox(
                    width: constraints.maxWidth * 0.05,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome back :',
                        style: TextStyle(
                            color: AppTheme.lightSecondaryText,
                            fontWeight: FontWeight.bold,
                            fontSize: 30),
                      ),
                      Text(
                        '${connectedUser.fullName}',
                        style: const TextStyle(
                            color: AppTheme.lightSecondaryText,
                            fontWeight: FontWeight.w900),
                      ),
                    ],
                  ),
                ],
              ),
              Form(
                key: formKey,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      SizedBox(
                        width: constraints.maxWidth * 0.9,
                        child: TextFormField(
                          controller: objecttController,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            hintText: 'Subject',
                            hintStyle: TextStyle(
                              color: Colors.grey,
                              fontSize: 16,
                            ),
                            prefixIcon: Icon(
                              Icons.subject,
                              color: Colors.grey,
                            ),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter an object';
                            }
                            return null;
                          },
                        ),
                      ),
                      Divider(
                        height: constraints.maxHeight * 0.02,
                        color: AppTheme.lightBackground,
                      ),
                      SizedBox(
                        width: constraints.maxWidth * 0.9,
                        child: TextFormField(
                          controller: msgController,
                          maxLines: 5,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 15),
                            hintText: 'your reclamation text',
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
                            if (value == null || value.isEmpty) {
                              return 'Please enter a message';
                            }
                            return null;
                          },
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      image != null
                          ? Center(
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      TextButton(
                                        child: Image.asset(
                                          "assets/icons/gallery.png",
                                          width: constraints.maxWidth * 0.1,
                                        ),
                                        onPressed: () => pickImage(),
                                      ),
                                      Image.file(
                                        image!,
                                        width: constraints.maxWidth * 0.4,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: constraints.maxHeight * 0.02,
                                  ),
                                  addReclamationBtn(
                                      formKey,
                                      connectedUser,
                                      objecttController,
                                      msgController,
                                      image,
                                      constraints),
                                ],
                              ),
                            )
                          : Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextButton(
                                    child: Image.asset(
                                      "assets/icons/gallery.png",
                                      width: constraints.maxWidth * 0.1,
                                    ),
                                    onPressed: () => pickImage(),
                                  ),
                                  const Divider(),
                                  addReclamationBtn(
                                      formKey,
                                      connectedUser,
                                      objecttController,
                                      msgController,
                                      image,
                                      constraints),
                                ],
                              ),
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

Widget addReclamationBtn(formKey, connectedUser, objecttController,
    msgController, image, BoxConstraints constraints) {
  return ElevatedButton(
    onPressed: () {
      if (formKey.currentState?.validate() == true) {
        formKey.currentState?.save();

        final ReclamationService rs = ReclamationService();
        rs.addNewReclamation(
          Reclamation(
            sender: connectedUser.email,
            object: objecttController.text,
            message: msgController.text,
            attachFiles: image,
          ),
        );
      }
    },
    child: SizedBox(
      width: constraints.maxWidth * 0.4,
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.arrow_outward_rounded),
          Text('Add Reclamation'),
          Spacer(),
        ],
      ),
    ),
  );
}
