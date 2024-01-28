import 'package:flutter/material.dart';
import 'package:session11_sqlite_db/db/database_helper.dart';
import 'package:session11_sqlite_db/models/student.dart';
import 'package:session11_sqlite_db/widgets/student_card_widget.dart';
import 'package:session11_sqlite_db/widgets/student_item_info_widget.dart';

class StudentListScreen extends StatefulWidget {
  const StudentListScreen({super.key});

  @override
  State<StudentListScreen> createState() => _StudentListScreenState();
}

class _StudentListScreenState extends State<StudentListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Student List'),
      ),
      body: FutureBuilder<List<Student>>(
        future: DatabaseHelper.instance.getAllStudents(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            List<Student> students = snapshot.data;

            return ListView.builder(
                itemCount: students.length,
                itemBuilder: (context, index) {
                  Student student = students[index];

                  return StudentCardWidget(
                    student: student,
                    onDelete: () {},
                    onUpdate: () {},
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
