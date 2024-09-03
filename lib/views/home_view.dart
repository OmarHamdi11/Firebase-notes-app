import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/helpers/custom_card_dialog.dart';
import 'package:firebase_project/views/edit_category_view.dart';
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
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('categories')
        .where('id', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get();

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
          Navigator.of(context).pushNamed('AddCategoryView');
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
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('IntroView', (route) => false);
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
                      desc: 'Make a choice',
                      type: DialogType.warning,
                      btnOkText: 'Update',
                      btnOkOnPress: () async {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) {
                              return EditCategoryView(
                                docId: data[index].id,
                                oldName: data[index]['name'],
                              );
                            },
                          ),
                        );
                      },
                      btnCancelText: 'Delete',
                      btnCancelOnPress: () async {
                        FirebaseFirestore.instance
                            .collection('categories')
                            .doc(data[index].id)
                            .delete();
                        Navigator.of(context).pushNamedAndRemoveUntil(
                            'HomeView', (route) => false);
                      },
                    ).show();
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
