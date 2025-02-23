import 'package:get/get.dart';
import 'package:sqflite/sqflite.dart';
import 'package:student_management_v2/features/data/model/model.dart';

class DatabaseController extends GetxController {
  late Database _db;
  var studentList = <StudentModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    initializeDatabase();
  }

  Future<void> initializeDatabase() async {
    _db = await openDatabase(
      'student.db',
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE student (id INTEGER PRIMARY KEY, name TEXT, batch TEXT, pic TEXT, dept TEXT, age TEXT)',
        );
        print("Database initialized and student table created.");
      },
    );
    getAllStudents();
  }

  Future<void> addStudent(StudentModel value) async {
    print("Attempting to add student: ${value.name}");
    await _db.rawInsert(
      'INSERT INTO student (name, batch, pic, dept, age) VALUES(?,?,?,?,?)',
      [value.name, value.batch, value.pic, value.dept, value.age],
    );
    print("Student added: ${value.name}");
    await getAllStudents();
  }

  Future<void> getAllStudents() async {
    final _values = await _db.rawQuery('SELECT * FROM student');
    studentList.clear();
    for (var map in _values) {
      final student = StudentModel.fromMap(map);
      studentList.add(student);
    }
    update();
  }

  Future<void> deleteStudent(int? id) async {
    print("Attempting to delete student with id: $id");
    await _db.rawDelete('DELETE FROM student WHERE id = ?', [id]);
    print("Student with id $id deleted.");
    getAllStudents();
  }

  Future<StudentModel?> updateStudent(
    int? id,
    String name,
    String batch,
    String age,
    String dept,
    String pic,
  ) async {
    print("Attempting to update student with id: $id");
    await _db.rawUpdate(
      'UPDATE student SET name = ?, batch = ?, dept = ?, age = ?, pic = ? WHERE id = ?',
      [name, batch, dept, age, pic, id],
    );
    print("Student with id $id updated.");
    final List<Map<String, dynamic>> updatedData = await _db.rawQuery(
      'SELECT * FROM student WHERE id = ?',
      [id],
    );

    if (updatedData.isNotEmpty) {
      return StudentModel.fromMap(updatedData.first);
    }
    return null;
  }

  Future<void> searchStudent(String sname) async {
    print("Searching for students with name containing: $sname");
    if (sname.isEmpty) {
      getAllStudents();
      return;
    }
    final searchQuery = 'SELECT * FROM student WHERE LOWER(name) LIKE ?';
    final searchResults = await _db.rawQuery(searchQuery, [
      '${sname.toLowerCase()}%',
    ]);
    studentList.value =
        searchResults.map((map) => StudentModel.fromMap(map)).toList();
    print("Search results for '$sname': ${studentList.length} students found.");
  }
  StudentModel? getStudentById(int id) {
  return studentList.firstWhereOrNull((student) => student.id == id);
}
}

class StudentController extends GetxController {
  var student =
      StudentModel(id: 0, name: '', batch: '', age: '', dept: '', pic: '').obs;
  void updateStudent(StudentModel updatedStudent) {
    student.value = updatedStudent;
  }
}
