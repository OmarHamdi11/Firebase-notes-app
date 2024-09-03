import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/helpers/custom_card_dialog.dart';
import 'package:firebase_project/views/add_category_view.dart';
import 'package:firebase_project/auth/intro_view.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  bool isLoading = true;
  List<QueryDocumentSnapshot> data = [];
  getData() async {
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    data.addAll(snapshot.docs);
    isLoading = false;
    setState(() {});
  }

  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.orange,
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const AddCategoryView();
              },
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () async {
              GoogleSignIn googleSignIn = GoogleSignIn();
              googleSignIn.disconnect();
              await FirebaseAuth.instance.signOut();
              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(
                builder: (constext) {
                  return const IntroView();
                },
              ), (route) => false);
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : GridView.builder(
              itemCount: data.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return InkWell(
                  onLongPress: () {
                    customCardDialog(
                            context: context,
                            title: 'Warning',
                            desc: 'Delete Category ?',
                            type: DialogType.warning,
                            btnOkOnPress: () async {
                              FirebaseFirestore.instance
                                  .collection('categories')
                                  .doc(data[index].id)
                                  .delete();
                              Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                  builder: (context) {
                                    return const HomeView();
                                  },
                                ),
                              );
                            },
                            btnCancelOnPress: () {})
                        .show();
                  },
                  child: Card(
                    child: Column(
                      children: [
                        Image.asset(
                          'assets/images/folder.png',
                          scale: .7,
                        ),
                        Text(
                          '${data[index]['name']}',
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
