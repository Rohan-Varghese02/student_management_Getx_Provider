import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_management_v2/features/data/datasource/addStudent_Provider.dart';
import 'package:student_management_v2/features/data/datasource/datasource.dart';
import 'package:student_management_v2/features/data/model/model.dart';
import 'package:student_management_v2/features/presentation/widgets/custom_textfield.dart';
import 'package:student_management_v2/features/presentation/widgets/image_controller.dart';

class AddStudent extends StatelessWidget {
  AddStudent({super.key});
  final _key_safe = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Consumer<addStudentProvider>(
      builder: (
        BuildContext context,
        addStudentProvider student,
        Widget? child,
      ) {
        return
        Scaffold(
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
                        onTap: () => student.imageController.pickImage(),
                        child: Obx(
                          () => CircleAvatar(
                            radius: 70,
                            backgroundColor: Colors.grey,
                            backgroundImage:
                                student.imageController.image.value != null
                                    ? FileImage(student.imageController.image.value!)
                                    : null,
                            child:
                                student.imageController.image.value == null
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
                      text_controller: student.name_Controller,
                      label: 'Name',
                    ),
                    SizedBox(height: 10),
                    CustomTextfield(
                      text_controller: student.batch_Controller,
                      label: 'Batch',
                    ),
                    SizedBox(height: 10),
                    CustomTextfield(
                      text_controller: student.age_Controller,
                      label: 'Age',
                    ),
                    SizedBox(height: 10),
                    CustomTextfield(
                      text_controller: student.dept_Controller,
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
                            if (student.name_Controller.text.isEmpty ||
                                student.batch_Controller.text.isEmpty) {
                              _key_safe.currentState!.validate();
                              Get.snackbar(
                                'Validation',
                                'Fill all the Text field',
                                shouldIconPulse: true,
                                snackPosition: SnackPosition.BOTTOM,
                                colorText: Colors.white,
                                backgroundColor: Colors.red,
                              );
                            } else if (student.imageController.image.value == null) {
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
                              student.addStudentAddButtonclick();
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
      },
    );
  }

 
}
