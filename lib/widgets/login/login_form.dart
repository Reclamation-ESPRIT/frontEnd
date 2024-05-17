import 'package:flutter/material.dart';
import 'package:reclamationapp/Services/auth.dart';

class LoginForm extends StatefulWidget {
  final BoxConstraints constraints;
  const LoginForm({super.key, required this.constraints});

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final pwdController = TextEditingController();
  final adminService = UserServices();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          emailField(emailController, context, widget.constraints),
          SizedBox(height: widget.constraints.maxHeight * 0.02),
          passwordField(pwdController, context, widget.constraints),
          SizedBox(height: widget.constraints.maxHeight * 0.02),
          signInButton(() {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              adminService.loginAdmin(
                  context, emailController.text, pwdController.text);
            }
          }, context, widget.constraints),
        ],
      ),
    );
  }
}

// email_field.dart
Widget emailField(TextEditingController controller, BuildContext context,
    BoxConstraints constraints) {
  return SizedBox(
    width: constraints.maxWidth * 0.8,
    child: TextFormField(
      controller: controller,
      decoration: const InputDecoration(
        labelText: 'email.exemple@esprit.tn',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty || !value.contains('@esprit.tn')) {
          return 'Please enter a valid email address';
        }
        return null;
      },
    ),
  );
}

// password_field.dart
Widget passwordField(TextEditingController controller, BuildContext context,
    BoxConstraints constraints) {
  return SizedBox(
    width: constraints.maxWidth * 0.8,
    child: TextFormField(
      controller: controller,
      obscureText: true,
      decoration: const InputDecoration(
        labelText: 'Password',
        border: OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a password';
        }
        return null;
      },
    ),
  );
}

// sign_in_button.dart
Widget signInButton(
    VoidCallback onPressed, BuildContext context, BoxConstraints constraints) {
  return ElevatedButton(
    onPressed: onPressed,
    child: const Text('Sign In'),
  );
}
