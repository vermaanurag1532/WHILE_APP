import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:while_app/resources/colors.dart';
import 'package:while_app/resources/components/header_widget.dart';
import 'package:while_app/resources/components/round_button.dart';
import 'package:while_app/resources/components/text_container_widget.dart';
import 'package:while_app/utils/utils.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 32),
          child: Column(
            children: [
              const HeaderWidget(title: "Forgot Password"),
              const SizedBox(
                height: 20,
              ),
              const Text(
                  "Don't worry! Just fill in your email and While App will send you a link to rest your password"),
              const SizedBox(
                height: 20,
              ),
              TextContainerWidget(
                controller: _emailController,
                prefixIcon: Icons.email,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(
                height: 20,
              ),
              RoundButton(
                loading: false,
                title: "Send Password Reset Email",
                onPress: resetPassword,
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text(
                    "Remember the account information?",
                  ),
                  InkWell(
                    child: const Text(
                      "Login",
                      style: TextStyle(color: AppColors.theme1Color),
                    ),
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                  )
                ],
              ),
            ],
          )),
    ));
  }

  Future resetPassword() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailController.text.trim());
      // ignore: use_build_context_synchronously
      Utils.snackBar('Password reset email sent', context);
    } on FirebaseAuthException catch (e) {
      // print(e);
      Utils.flushBarErrorMessage(e.message!, context);
    }
    // ignore: use_build_context_synchronously
    Navigator.of(context).pop();
  }
}
