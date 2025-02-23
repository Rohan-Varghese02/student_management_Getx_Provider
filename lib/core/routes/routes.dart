import 'package:get/get.dart';
import 'package:student_management_v2/features/presentation/pages/add_student.dart';
import 'package:student_management_v2/features/presentation/pages/detailed_screen.dart';
import 'package:student_management_v2/features/presentation/pages/edit_student.dart';
import 'package:student_management_v2/features/presentation/pages/home_page.dart';

class Routes {
  static final routes = [
    GetPage(name: '/homepage', page: () => HomePage()),
    GetPage(name: '/add_student', page: () => AddStudent()),
    GetPage(name: '/detailed', page: () => DetailedScreen()),
    GetPage(name: '/edit', page: () => EditStudent()),
  ];
}
