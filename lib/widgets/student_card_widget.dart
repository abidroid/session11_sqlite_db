
import 'package:flutter/material.dart';
import 'package:session11_sqlite_db/models/student.dart';
import 'package:session11_sqlite_db/widgets/student_item_info_widget.dart';

class StudentCardWidget extends StatelessWidget {
  final Student student;
  final VoidCallback onDelete;
  final VoidCallback onUpdate;
  const StudentCardWidget({super.key, required this.student, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.teal,
      child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [

        StudentItemInfoWidget(title: 'ID', value: student.id.toString()),

        StudentItemInfoWidget(title: 'Name', value: student.name),
        StudentItemInfoWidget(title: 'Email', value: student.email),
        StudentItemInfoWidget(title: 'Mobile', value: student.mobile),
        StudentItemInfoWidget(title: 'Course', value: student.course),
        StudentItemInfoWidget(title: 'Uni', value: student.uni),
        Row(children: [
          Expanded(child: ElevatedButton(onPressed: onDelete, child: const Text('Delete'))),
          const SizedBox(width: 10,),
          Expanded(child: ElevatedButton(onPressed: onUpdate, child: const Text('Update'))),

        ],)
      ],),
    ),);
  }
}
