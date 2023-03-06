// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// class AddUserPage extends StatelessWidget {
//   AddUserPage({super.key});

//   var formKey = GlobalKey<FormState>();
//   var nameController = TextEditingController();
//   var salaryController = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//         child: Scaffold(
//       body: Form(
//         child: Column(children: [
//           TextFormField(
//             decoration: InputDecoration(hintText: 'Enter Name'),
//             validator: ((value) {
//               if(value!=null && value.isEmpty){
//                 return "Enter Valid Name";
//               }
//             }),
//             controller: nameController,
//           ),
//           TextFormField(
//             decoration: InputDecoration(hintText: 'Enter salary'),
//             validator: ((value) {
//               if(value!=null && value.isEmpty){
//                 return "Enter Valid Salary";
//               }
//             }),
//             controller: salaryController,
//           ),
//           TextButton(onPressed: () {
//             if(formKey.currentState!.validate()){
//               insertUser();
//             }
//           }, child: Text('Submit'))
//         ]),
//       ),
//     ));
//   }

//   Future<void> insertUser() async {
//     Map map = {};
//     map['name'] = nameController.text;
//     map['salary'] = salaryController.text;

//     var res = await http.post(Uri.parse('https://630ee9663792563418834e75.mockapi.io/empoyee'),body: map);
//     print(res.body);
//   }
// }
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
class AddEmployee extends StatefulWidget {
  @override
  State<AddEmployee> createState() => _AddEmployeeState();

  dynamic? map;
  AddEmployee(this.map);

  GlobalKey<FormState> formkey = GlobalKey();
  var name = new TextEditingController();
  var salary = new TextEditingController();


}

class _AddEmployeeState extends State<AddEmployee> {
  void initState(){
    widget.name.text = widget.map==null?'':widget.map['name'];
    widget.salary.text = widget.map==null?'':widget.map['salary'];
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: TextFormField(
              controller: widget.name,
              decoration: InputDecoration(
                hintText: "Enter Employee's name",
              ),
              cursorColor: Colors.black,
            ),
            color: Color(0xFFE57734),
          ),
          Container(
            child: TextFormField(
              decoration: InputDecoration(
                hintText: "Enter Employee's salary",

              ),
              cursorColor: Colors.black,
              controller: widget.salary,
            ),
            color: Color(0xFFE57734),
          ),
          Container(
            margin: EdgeInsets.only(top: 20),
            child: ElevatedButton(
              onPressed: () async {
                if(widget.map==null){
                  await addEmployee().then((value) => (value) {

                  });
                }
                else{
                  await editEmployee().then((value) => (value) {
                    setState(() {

                    });
                  });
                }

                Navigator.of(context).pop(true);

              }, child: Text("Submit",style: TextStyle(fontSize: 24,color: Color(0xFFE57734)),),

            ),
          )
        ],
      ),
      backgroundColor: Colors.black,
    );
  }

  Future<void> addEmployee() async{
    var map ={};
    map['name']=widget.name.text;
    map['salary']=widget.salary.text;
    var response1 = http.post(Uri.parse("https://630ee64b37925634188319ff.mockapi.io/faculties1",),body: map);
  }

  Future<void> editEmployee() async{
    var map ={};
    map['name']=widget.name.text;
    map['salary']=widget.salary.text;
    var response1 = http.put(Uri.parse("https://630ee64b37925634188319ff.mockapi.io/faculties1/"+widget.map['id'].toString(),),body: map);
  }
}