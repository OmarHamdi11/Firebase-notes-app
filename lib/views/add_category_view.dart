import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/helpers/custom_awsome_dialog_message.dart';
import 'package:firebase_project/widgets/confirm_auth_button.dart';
import 'package:firebase_project/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class AddCategoryView extends StatefulWidget {
  const AddCategoryView({super.key});

  @override
  State<AddCategoryView> createState() => _AddCategoryViewState();
}

class _AddCategoryViewState extends State<AddCategoryView> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? categoryName;

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  Future<void> addUser() {
    return categories
        .add({
          'name': categoryName,
          'id': FirebaseAuth.instance.currentUser!.uid
        })
        .then(
          (value) => customAwsomeDialogMessage(
            context: context,
            title: 'Success',
            desc: 'Category Added',
            type: DialogType.success,
            btnOkOnPress: () {},
          ).show(),
        )
        .catchError(
          (error) => customAwsomeDialogMessage(
            context: context,
            title: 'Error',
            desc: 'Failed to add category: $error',
            type: DialogType.error,
            btnOkOnPress: () {},
          ).show(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Category'),
      ),
      body: Form(
        key: formState,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomTextFormField(
                onChanged: (value) {
                  categoryName = value;
                },
                hintText: 'Category name',
                obsecure: false,
                fillColor: Colors.amberAccent,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: 60,
                width: 150,
                child: ConfirmAuthButton(
                  text: 'Add',
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      await addUser();
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          'HomeView', (route) => false);
                    }
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
