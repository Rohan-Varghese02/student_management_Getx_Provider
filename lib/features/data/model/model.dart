class StudentModel {
  final int id;
  final String name;
  final String batch;
  final String pic;
  final String dept;  // Changed from 'address' to 'dept'
  final String age;

  StudentModel({
    required this.id,
    required this.name,
    required this.batch,
    required this.pic,
    required this.dept,  // Changed from 'address' to 'dept'
    required this.age,
  });

  // Update the fromMap function to use 'dept' instead of 'address'
  factory StudentModel.fromMap(Map<String, dynamic> map) {
    return StudentModel(
      id: map['id'],
      name: map['name'],
      batch: map['batch'],
      pic: map['pic'],
      dept: map['dept'],  // Changed from 'address' to 'dept'
      age: map['age'],
    );
  }
}
