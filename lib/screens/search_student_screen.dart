import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:session11_sqlite_db/models/student.dart';
import 'package:session11_sqlite_db/screens/update_screen.dart';
import 'package:session11_sqlite_db/widgets/student_card_widget.dart';

import '../db/database_helper.dart';

class SearchStudentScreen extends StatefulWidget {
  const SearchStudentScreen({super.key});

  @override
  State<SearchStudentScreen> createState() => _SearchStudentScreenState();
}

class _SearchStudentScreenState extends State<SearchStudentScreen> {

  late TextEditingController nameC;

  @override
  void initState() {
    nameC   = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Here...'),
      ),
      
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(children: [
          TextField(
            controller: nameC,
            decoration: InputDecoration(
              hintText: 'Search',
              suffixIcon: IconButton(onPressed: (){

                String name = nameC.text.trim();

                if( name.isEmpty){
                  Fluttertoast.showToast(msg: 'Please provide name to search');
                }else{

                  DatabaseHelper.instance.searchStudents(name: name);
                  setState(() {

                  });

                }

              }, icon: Icon(Icons.search))
            ),

          ),

          const SizedBox(height: 16,),

          Expanded(
            child: FutureBuilder<List<Student>>(
              future: DatabaseHelper.instance.searchStudents(name: nameC.text.trim()),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData) {
                  if( snapshot.data.isEmpty){
                    return const Center(
                      child: Text('No students found'),
                    );
                  }


                  List<Student> students = snapshot.data;

                  return ListView.builder(
                      itemCount: students.length,
                      itemBuilder: (context, index) {
                        Student student = students[index];

                        return StudentCardWidget(
                          student: student,
                          onDelete: () {
                            // show alert dialog

                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: const Text('Confirmation'),
                                    content: const Text('Are you sure to delete ? '),
                                    actions: [
                                      TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          }, child: const Text('No')),
                                      TextButton(
                                          onPressed: () async{
                                            Navigator.pop(context);

                                            int result = await DatabaseHelper.instance.deleteStudent(student.id!);

                                            if( result > 0 ){
                                              Fluttertoast.showToast(msg: 'Deleted');
                                              setState(() {

                                              });
                                            }else{
                                              Fluttertoast.showToast(msg: 'Failed');

                                            }
                                          }, child: const Text('Yes')),
                                    ],
                                  );
                                });
                          },
                          onUpdate: () async {

                            bool updated = await Navigator.of(context).push(MaterialPageRoute(builder: (context){
                              return UpdateScreen(student: student);
                            }));

                            if( updated){
                              setState(() {

                              });
                            }
                          },
                        );
                      });
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),

        ],),
      ),
    );
  }
}
