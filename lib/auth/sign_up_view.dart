// ignore_for_file: use_build_context_synchronously

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/helpers/custom_awsome_dialog_message.dart';
import 'package:firebase_project/widgets/change_auth_button.dart';
import 'package:firebase_project/widgets/confirm_auth_button.dart';
import 'package:firebase_project/widgets/custom_back_arrow.dart';
import 'package:firebase_project/widgets/custom_text_field.dart';
import 'package:firebase_project/widgets/custon_logo_widget.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                // Background Image
                Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/images/signup.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                // Foreground Elements (like text fields, buttons, etc.)
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomBackArrow(),
                        const Spacer(),
                        const Text(
                          "Sign Up",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 32.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hintText: 'Username',
                          onChanged: (value) {
                            email = value;
                          },
                          obsecure: false,
                        ),
                        const SizedBox(height: 20),
                        CustomTextFormField(
                          hintText: 'Password',
                          onChanged: (value) {
                            password = value;
                          },
                          obsecure: true,
                        ),
                        const SizedBox(height: 5),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: isChecked,
                                    onChanged: (bool? value) {
                                      setState(() {
                                        isChecked = value!;
                                      });
                                    },
                                  ),
                                  const Text('Remember me'),
                                ],
                              ),
                            ),
                            ChangeAuthButton(
                              text: 'Login?',
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacementNamed('LoginView');
                              },
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CustomLogoWidget(
                              logoLink: 'assets/images/google.png',
                              onTap: () {},
                            ),
                            CustomLogoWidget(
                              logoLink: 'assets/images/facebook.png',
                              onTap: () {},
                            ),
                            CustomLogoWidget(
                              logoLink: 'assets/images/twitter.png',
                              onTap: () {},
                            ),
                          ],
                        ),
                        const SizedBox(height: 20),
                        ConfirmAuthButton(
                          text: 'Sign Up',
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                // ignore: unused_local_variable
                                final credential = await FirebaseAuth.instance
                                    .createUserWithEmailAndPassword(
                                  email: email!,
                                  password: password!,
                                );
                                FirebaseAuth.instance.currentUser!
                                    .sendEmailVerification();
                                Navigator.of(context)
                                    .pushReplacementNamed('LoginView');
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'weak-password') {
                                  customAwsomeDialogMessage(
                                    context: context,
                                    title: 'Error',
                                    desc: 'The password provided is too weak',
                                    type: DialogType.error,
                                  ).show();
                                } else if (e.code == 'email-already-in-use') {
                                  customAwsomeDialogMessage(
                                    context: context,
                                    title: 'Error',
                                    desc:
                                        'The account already exists for that email',
                                    type: DialogType.error,
                                  ).show();
                                }
                              } catch (e) {
                                customAwsomeDialogMessage(
                                  context: context,
                                  title: 'Error',
                                  desc: e.toString(),
                                  type: DialogType.error,
                                ).show();
                              }
                            }
                          },
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
