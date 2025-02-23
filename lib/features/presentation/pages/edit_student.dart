import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_v2/features/data/datasource/datasource.dart';
import 'package:student_management_v2/features/data/model/model.dart';
import 'package:student_management_v2/features/presentation/widgets/custom_textfield.dart';
import 'package:student_management_v2/features/presentation/widgets/image_controller.dart';

class EditStudent extends StatelessWidget {
  const EditStudent({super.key});

  @override
  Widget build(BuildContext context) {
    final DatabaseController _dbController = Get.put(DatabaseController());
    final StudentModel student = Get.arguments;
    TextEditingController name_controller = TextEditingController();
    TextEditingController batch_controller = TextEditingController();
    TextEditingController age_controller = TextEditingController();
    TextEditingController dept_controller = TextEditingController();
    final ImageController imageController = Get.put(ImageController());
    GlobalKey<FormState> key_value = GlobalKey<FormState>();
    name_controller.text = student.name;
    batch_controller.text = student.batch;
    age_controller.text = student.age;
    dept_controller.text = student.dept;
    imageController.image.value = File(student.pic);
    return Scaffold(
      appBar: AppBar(title: Text(student.name)),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: key_value,
              child: Column(
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
                    text_controller: name_controller,
                    label: 'Name',
                  ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    text_controller: batch_controller,
                    label: 'Batch',
                  ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    text_controller: age_controller,
                    label: 'Age',
                  ),
                  SizedBox(height: 10),
                  CustomTextfield(
                    text_controller: dept_controller,
                    label: 'Deptartment',
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (name_controller.text.isEmpty ||
                              batch_controller.text.isEmpty ||
                              age_controller.text.isEmpty ||
                              dept_controller.text.isEmpty) {
                            Get.snackbar(
                              'Validation',
                              'Pleas fill all the field!',
                              shouldIconPulse: true,
                              snackPosition: SnackPosition.BOTTOM,
                              colorText: Colors.white,
                              backgroundColor: Colors.red,
                            );
                            key_value.currentState!.validate();
                          } else {
                            String picture =
                                imageController.image.value != null
                                    ? imageController.image.value!.path
                                    : '';
                            StudentModel updatedStudent = StudentModel(
                              id: student.id,
                              name: name_controller.text,
                              batch: batch_controller.text,
                              age: age_controller.text,
                              dept: dept_controller.text,
                              pic: picture,
                            );
                            _dbController.updateStudent(
                              student.id,
                              name_controller.text,
                              batch_controller.text,
                              age_controller.text,
                              dept_controller.text,
                              picture,
                            );
                            Get.back(result: updatedStudent);
                          }
                        },
                        child: Text('Sumbit'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
