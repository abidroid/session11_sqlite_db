import '../utility/data_store.dart';

class Student {
  late int? id;
  late String name;
  late String email;
  late String mobile;
  late String course;
  late String uni;

  Student({
    this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.course,
    required this.uni,
  });

  // Convert Student Object to Map

  Map<String, dynamic> toMap(){
    Map<String, dynamic> map = {

      colId : id,
      colName: name,
      colEmail: email,
      colMobile: mobile,
      colCourse: course,
      colUni: uni,
    };

    return map;
  }


  // Convert Map to Student Object
  // Named Constructor

  Student.fromMap( Map<String, dynamic> map ){

    id = map[colId];
    name = map[colName];
    email = map[colEmail];
    mobile = map[colMobile];
    course = map[colCourse];
    uni = map[colUni];


  }



}
