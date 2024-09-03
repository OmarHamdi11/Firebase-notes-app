// ignore_for_file: use_build_context_synchronously
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/helpers/custom_awsome_dialog_message.dart';
import 'package:firebase_project/helpers/show_snak_bar_message.dart';
import 'package:firebase_project/widgets/change_auth_button.dart';
import 'package:firebase_project/widgets/confirm_auth_button.dart';
import 'package:firebase_project/widgets/custom_back_arrow.dart';
import 'package:firebase_project/widgets/custom_text_field.dart';
import 'package:firebase_project/widgets/custon_logo_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool isLoading = false;
  String? email;
  String? password;
  GlobalKey<FormState> formKey = GlobalKey();
  bool isChecked = false;

  Future signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser == null) {
      return;
    }

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    await FirebaseAuth.instance.signInWithCredential(credential);
    Navigator.of(context).pushReplacementNamed('HomeView');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
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
                            image: AssetImage("assets/images/login.jpg"),
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
                                "Login",
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    child: Row(
                                      children: [
                                        const SizedBox(
                                          width: 13,
                                        ),
                                        GestureDetector(
                                          onTap: () async {
                                            if (email == null) {
                                              customAwsomeDialogMessage(
                                                      context: context,
                                                      title: 'Error',
                                                      desc: 'email is required',
                                                      type: DialogType.error,
                                                      btnOkOnPress: () {})
                                                  .show();
                                              return;
                                            }
                                            try {
                                              await FirebaseAuth.instance
                                                  .sendPasswordResetEmail(
                                                      email: email!);
                                              customAwsomeDialogMessage(
                                                      context: context,
                                                      title: 'info',
                                                      desc: 'Check your email',
                                                      type: DialogType.info,
                                                      btnOkOnPress: () {})
                                                  .show();
                                            } catch (e) {
                                              customAwsomeDialogMessage(
                                                context: context,
                                                title: 'Error',
                                                desc: 'Email not found',
                                                type: DialogType.error,
                                                btnOkOnPress: () {},
                                              ).show();
                                            }
                                          },
                                          child: const Text(
                                            'Forget Password?',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  ChangeAuthButton(
                                    text: 'Sign Up?',
                                    onTap: () {
                                      Navigator.of(context)
                                          .pushReplacementNamed('SignUpView');
                                    },
                                  )
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  CustomLogoWidget(
                                    logoLink: 'assets/images/google.png',
                                    onTap: () {
                                      signInWithGoogle();
                                    },
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
                                text: 'Login',
                                onPressed: () async {
                                  if (formKey.currentState!.validate()) {
                                    try {
                                      isLoading = true;
                                      setState(() {});
                                      // ignore: unused_local_variable
                                      final credential = await FirebaseAuth
                                          .instance
                                          .signInWithEmailAndPassword(
                                        email: email!,
                                        password: password!,
                                      );
                                      isLoading = false;
                                      setState(() {});
                                      if (credential.user!.emailVerified) {
                                        Navigator.of(context)
                                            .pushNamedAndRemoveUntil(
                                                'HomeView', (route) => false);
                                      } else {
                                        customAwsomeDialogMessage(
                                                context: context,
                                                title: 'Info',
                                                desc:
                                                    'Account isn\'t Verified, Check verification message',
                                                type: DialogType.info,
                                                btnOkOnPress: () {})
                                            .show();
                                      }
                                    } on FirebaseAuthException catch (e) {
                                      isLoading = false;
                                      setState(() {});
                                      if (e.code == 'user-not-found') {
                                        customAwsomeDialogMessage(
                                                context: context,
                                                title: 'Error',
                                                desc:
                                                    'No user found for that email',
                                                type: DialogType.error,
                                                btnOkOnPress: () {})
                                            .show();
                                      } else if (e.code == 'wrong-password') {
                                        customAwsomeDialogMessage(
                                                context: context,
                                                title: 'Error',
                                                desc:
                                                    'Wrong password provided for that user',
                                                type: DialogType.error,
                                                btnOkOnPress: () {})
                                            .show();
                                      } else {
                                        customAwsomeDialogMessage(
                                                context: context,
                                                title: 'Error',
                                                desc: e.toString(),
                                                type: DialogType.error,
                                                btnOkOnPress: () {})
                                            .show();
                                        showSnakBarMessage(
                                            context, e.toString());
                                      }
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
