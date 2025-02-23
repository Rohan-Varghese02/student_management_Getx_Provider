import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:student_management_v2/features/data/datasource/datasource.dart';
import 'package:student_management_v2/features/data/model/model.dart';

class DetailedScreen extends StatelessWidget {
  const DetailedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    StudentModel student = Get.arguments as StudentModel;
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Info'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              final updatedStudent = await Get.toNamed(
                '/edit',
                arguments: student,
              );
              if (updatedStudent != null) {
                Get.find<DatabaseController>().getAllStudents();
                Get.find<DatabaseController>().update();
                Get.snackbar(
                  'Successful',
                  'Changes done were successfully stored refresh to view',
                  backgroundColor: Colors.green,
                  colorText: Colors.white,
                  snackPosition: SnackPosition.BOTTOM,
                );
                // ignore: use_build_context_synchronously
                Navigator.of(context).pop();
              }
            },
            icon: Icon(Icons.edit),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage:
                    student.pic.isNotEmpty
                        ? FileImage(File(student.pic))
                        : null,
                child: student.pic.isEmpty ? Icon(Icons.person) : null,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Name:  ${student.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text('Batch:  ${student.batch}', style: TextStyle(fontSize: 18)),
            Text('Age:  ${student.age}', style: TextStyle(fontSize: 18)),
            Text(
              'Department:  ${student.dept}',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
