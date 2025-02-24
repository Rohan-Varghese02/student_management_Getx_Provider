import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:student_management_v2/core/routes/routes.dart';
import 'package:student_management_v2/features/data/datasource/addStudent_Provider.dart';
import 'package:student_management_v2/features/data/datasource/datasource.dart';

void main() async {
  final DatabaseController _dbController = Get.put(
    DatabaseController(),
  ); // Get the controller instance
  WidgetsFlutterBinding.ensureInitialized();
  await _dbController.initializeDatabase();
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => addStudentProvider())],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(getPages: Routes.routes, initialRoute: '/homepage');
  }
}
