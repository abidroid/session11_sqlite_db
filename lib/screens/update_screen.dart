import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:session11_sqlite_db/db/database_helper.dart';
import 'package:session11_sqlite_db/models/student.dart';

import '../utility/data_store.dart';

class UpdateScreen extends StatefulWidget {
  final Student student;

  const UpdateScreen({super.key, required this.student});

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  late String name, email, mobile, uni;
  String _selectedCourse = courses[0];

  @override
  void initState() {
    _selectedCourse = widget.student.course;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(
                initialValue: widget.student.name,
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  name = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                initialValue: widget.student.email,
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  email = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                initialValue: widget.student.mobile,
                decoration: const InputDecoration(
                  hintText: 'Mobile',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  mobile = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              DropdownButtonFormField(
                value: _selectedCourse,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                isExpanded: true,
                onChanged: (value) {
                  setState(() {
                    _selectedCourse = value!;
                  });
                },
                onSaved: (value) {
                  setState(() {
                    _selectedCourse = value!;
                  });
                },
                validator: (String? value) {
                  if (value == null || value.isEmpty) {
                    return "can't empty";
                  } else {
                    return null;
                  }
                },
                items: courses.map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                    ),
                  );
                }).toList(),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFormField(
                initialValue: widget.student.uni,
                decoration: const InputDecoration(
                  hintText: 'Uni',
                  border: OutlineInputBorder(),
                ),
                validator: (text) {
                  if (text == null || text.isEmpty) {
                    return 'Please provide value';
                  }

                  uni = text;
                  return null;
                },
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async{
                    if (formKey.currentState!.validate()) {
                      // Update student

                      Student student = Student(
                        id: widget.student.id,
                        name: name,
                        email: email,
                        mobile: mobile,
                        course: _selectedCourse,
                        uni: uni,
                      );

                      int result = await DatabaseHelper.instance.updateStudent(student);

                      if( result > 0 ){
                        Fluttertoast.showToast(msg: 'Record Updated', backgroundColor: Colors.green);

                        Navigator.pop(context, true);
                      }else{
                        Fluttertoast.showToast(msg: 'Failed', backgroundColor: Colors.red);
                      }

                    }
                  },
                  child: const Text('Update')),
            ],
          ),
        ),
      ),
    );
  }
}
