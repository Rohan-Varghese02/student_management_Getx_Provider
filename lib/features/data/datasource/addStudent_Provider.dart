import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:student_management_v2/features/data/datasource/datasource.dart';
import 'package:student_management_v2/features/data/model/model.dart';
import 'package:student_management_v2/features/presentation/widgets/image_controller.dart';

class addStudentProvider extends ChangeNotifier {
final name_Controller = TextEditingController();
  final batch_Controller = TextEditingController();
  final dept_Controller = TextEditingController();
  final age_Controller = TextEditingController();
  final ImageController imageController = Get.put(ImageController());


  final DatabaseController _dbController = Get.put(
    DatabaseController(),
  );



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
