import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_v2/features/data/datasource/datasource.dart';
import 'package:student_management_v2/features/data/model/model.dart';
import 'package:student_management_v2/features/presentation/widgets/custom_textfield.dart';
import 'package:student_management_v2/features/presentation/widgets/image_controller.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final name_Controller = TextEditingController();
  final batch_Controller = TextEditingController();
  final dept_Controller = TextEditingController();
  final age_Controller = TextEditingController();
  final ImageController imageController = Get.put(ImageController());
  final _key_safe = GlobalKey<FormState>();

  final DatabaseController _dbController = Get.put(
    DatabaseController(),
  ); // Get the controller instance

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Student')),
      body: Form(
        key: _key_safe,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: GestureDetector(
                    onTap: () => imageController.pickImage(),
                    child: Obx(
                      () => CircleAvatar(
                        radius: 70,
                        backgroundColor: Colors.grey,
                        backgroundImage:
                            imageController.image.value != null
                                ? FileImage(imageController.image.value!)
                                : null,
                        child:
                            imageController.image.value == null
                                ? Icon(
                                  Icons.person,
                                  size: 60,
                                  color: Colors.white,
                                )
                                : null,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  text_controller: name_Controller,
                  label: 'Name',
                ),
                SizedBox(height: 10),
                CustomTextfield(
                  text_controller: batch_Controller,
                  label: 'Batch',
                ),
                SizedBox(height: 10),
                CustomTextfield(text_controller: age_Controller, label: 'Age'),
                SizedBox(height: 10),
                CustomTextfield(
                  text_controller: dept_Controller,
                  label: 'Department',
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red,
                      ),
                      onPressed: () {},
                      child: Text(
                        'Cancel',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                      ),
                      onPressed: () {
                        if (name_Controller.text.isEmpty ||
                            batch_Controller.text.isEmpty) {
                          _key_safe.currentState!.validate();
                          Get.snackbar(
                            'Validation',
                            'Fill all the Text field',
                            shouldIconPulse: true,
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                          );
                        } else if (imageController.image.value == null) {
                          Get.snackbar(
                            'Error',
                            'Add Your Image',
                            shouldIconPulse: true,
                            snackPosition: SnackPosition.BOTTOM,
                            colorText: Colors.white,
                            backgroundColor: Colors.red,
                          );
                          return;
                        } else {
                          Get.back();
                          addStudentAddButtonclick();
                        }
                      },
                      child: Text(
                        'Sumbit',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> addStudentAddButtonclick() async {
    final _name = name_Controller.text.trim();
    final _batch = batch_Controller.text.trim();
    final _age = age_Controller.text.trim();
    final _dept = dept_Controller.text.trim();
    String picture =
        imageController.image.value != null
            ? imageController.image.value!.path
            : '';

    final _student = StudentModel(
      id: 0,
      name: _name,
      batch: _batch,
      pic: picture,
      dept: _dept,
      age: _age,
    );
    await _dbController.addStudent(_student);
  }
}
