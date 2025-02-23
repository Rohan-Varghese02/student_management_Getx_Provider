import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';
import 'package:student_management_v2/features/data/datasource/datasource.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});
  final DatabaseController dbController = Get.find<DatabaseController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Student List')),
      body: SafeArea(
        child: Obx(
          () =>
              dbController.studentList.isEmpty
                  ? Center(child: Text('No students added yet.'))
                  : ListView.builder(
                    itemCount: dbController.studentList.length,
                    itemBuilder: (context, index) {
                      final student = dbController.studentList[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage:
                              student.pic.isNotEmpty
                                  ? FileImage(File(student.pic))
                                  : null,
                          child:
                              student.pic.isEmpty ? Icon(Icons.person) : null,
                        ),
                        title: Text(student.name),
                        subtitle: Text(
                          'Batch: ${student.batch}\nDepartment: ${student.dept}',
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            Get.defaultDialog(
                              title: 'Delete',
                              middleText:
                                  'Do you want to delete ${student.name}',
                              textCancel: 'Cancel',
                              textConfirm: 'Delete',
                              cancelTextColor: Colors.black,
                              onCancel: () => Get.back(),
                              onConfirm: () {
                                dbController.deleteStudent(student.id);
                                Get.back();
                              },
                            );
                          },
                        ),
                        onTap: () {
                          Get.toNamed('/detailed', arguments: student);
                        },
                      );
                    },
                  ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('/add_student');
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
