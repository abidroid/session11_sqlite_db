import 'package:flutter/material.dart';
import 'package:session11_sqlite_db/screens/student_list_screen.dart';
import 'package:session11_sqlite_db/utility/data_store.dart';

class AddStudentScreen extends StatefulWidget {
  const AddStudentScreen({super.key});

  @override
  State<AddStudentScreen> createState() => _AddStudentScreenState();
}

class _AddStudentScreenState extends State<AddStudentScreen> {


  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late String name, email,mobile, uni;

  String _selectedCourse = courses[0];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Student'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: ListView(
            children: [

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (text){
                  if( text == null || text.isEmpty){
                    return 'Please provide value';
                  }

                  name = text;
                  return null;
                },
              ),
              const SizedBox(height: 16,),

              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (text){
                  if( text == null || text.isEmpty){
                    return 'Please provide value';
                  }

                  email = text;
                  return null;
                },
              ),
              const SizedBox(height: 16,),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Mobile',
                  border: OutlineInputBorder(),
                ),
                validator: (text){
                  if( text == null || text.isEmpty){
                    return 'Please provide value';
                  }

                  mobile = text;
                  return null;
                },
              ),
              const SizedBox(height: 16,),

              DropdownButtonFormField(
                value: _selectedCourse,
                decoration: const InputDecoration(
                  border:  OutlineInputBorder(),
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
                items: courses
                    .map((String val) {
                  return DropdownMenuItem(
                    value: val,
                    child: Text(
                      val,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 16,),TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Uni',
                  border: OutlineInputBorder(),
                ),
                validator: (text){
                  if( text == null || text.isEmpty){
                    return 'Please provide value';
                  }

                  uni = text;
                  return null;
                },
              ),
              const SizedBox(height: 16,),

              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: (){

                    if( formKey.currentState!.validate()){

                      // Save student
                    }


                  }, child: const Text('Save')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: (){

                    Navigator.of(context).push(MaterialPageRoute(builder: (context){
                      return const StudentListScreen();
                    }));

                  }, child: const Text('View All')),

            ],
          ),
        ),
      ),
    );
  }
}
