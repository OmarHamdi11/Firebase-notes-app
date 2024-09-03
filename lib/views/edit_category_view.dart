import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_project/helpers/custom_awsome_dialog_message.dart';
import 'package:firebase_project/widgets/confirm_auth_button.dart';
import 'package:firebase_project/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class EditCategoryView extends StatefulWidget {
  const EditCategoryView(
      {super.key, required this.docId, required this.oldName});
  final String docId;
  final String oldName;

  @override
  State<EditCategoryView> createState() => _EditCategoryViewState();
}

class _EditCategoryViewState extends State<EditCategoryView> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  String? categoryName;

  CollectionReference categories =
      FirebaseFirestore.instance.collection('categories');

  editCategory(String data) async {
    await categories
        .doc(widget.docId)
        .set({
          'name': data,
        }, SetOptions(merge: true))
        .then(
          (value) => customAwsomeDialogMessage(
            context: context,
            title: 'Success',
            desc: 'Category Edited successfully',
            type: DialogType.success,
            btnOkOnPress: () {},
          ).show(),
        )
        .catchError(
          (error) => customAwsomeDialogMessage(
            context: context,
            title: 'Error',
            desc: 'Failed to Edit category: $error',
            type: DialogType.error,
            btnOkOnPress: () {},
          ).show(),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Category'),
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
                hintText: widget.oldName,
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
                  text: 'Save',
                  onPressed: () async {
                    if (formState.currentState!.validate()) {
                      await editCategory(categoryName!);
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
