import 'package:firebase_project/widgets/custom_auth_choose_button.dart';
import 'package:flutter/material.dart';

class IntroView extends StatelessWidget {
  const IntroView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/intro2.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .33,
                ),
                const Text(
                  'Make Free Notes',
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
                const Text(
                  'Add , update , Delete',
                  style: TextStyle(fontSize: 20),
                ),
                const Text(
                  'Feel free in your Application',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * .33,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomAuthChooseButton(
                      choose: true,
                      text: 'Login',
                      onTap: () {
                        Navigator.of(context).pushNamed('LoginView');
                      },
                    ),
                    CustomAuthChooseButton(
                      choose: false,
                      text: 'Sign up',
                      onTap: () {
                        Navigator.of(context).pushNamed('SignUpView');
                      },
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
