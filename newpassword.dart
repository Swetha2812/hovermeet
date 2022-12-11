// import 'package:flutter/material.dart';
// import 'package:user/login.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';

// class NewPassword extends StatefulWidget {
//   final String email;
//   final String otp;
//   const NewPassword({Key? key, required this.email, required this.otp}) : super(key: key);

//   @override
//   State<NewPassword> createState() => _passwordState();
// }

// // ignore: camel_case_types
// class _passwordState extends State<NewPassword> {
//   final GlobalKey<FormState> _form = GlobalKey<FormState>();
//   TextEditingController name1 = TextEditingController();
//   TextEditingController name2 = TextEditingController();
//     @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: Color.fromARGB(255, 241, 194, 177),
//       child: Scaffold(
//         backgroundColor: Colors.transparent,
//         body: SingleChildScrollView(
//           child: Column(children: [
//             Center(
//               child: Column(
//                 children: [
//                   Container(
//                     padding: const EdgeInsets.only(top: 200),
//                     child: const Text(
//                       "Create New Password",
//                       style: TextStyle(color: Colors.black, fontSize: 35),
//                     ),
//                   ),
//                   SingleChildScrollView(
//               child: Container(
//                 padding: const EdgeInsets.only(
//                     right: 20,
//                     left: 20,
//                     top: 100,),
//                     // top: MediaQuery.of(context).size.height * 0.5),
//                 child: Form(
//                   key: _form,
//                   child: Column(children: [
//                     TextFormField(
//                       controller: name1,
//                       validator:(val){
//                         if(val!.isEmpty)
//                         {
//                           return 'Empty';
//                         }
//                         else{
//                           return null;
//                         }
//                       },
                      
//                       decoration: InputDecoration(
//                         fillColor: Color.fromRGBO(245, 245, 245, 1),
//                         filled: true,
//                         hintText: 'new password',
//                         hintStyle: const TextStyle(color: Colors.black),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(color: Colors.black),
//                         ),
//                       ),
//                     ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     TextFormField(
//                       controller: name2,
//                       validator: (val){
//                         if(val!.isEmpty)
//                         {
//                           return 'Empty';
//                         }
//                         else if(val!=name1.text)
//                         {
//                           return 'Password Not Matching';
//                         }
//                         else{
//                           return null;
//                         }
//                       },
//                       decoration: InputDecoration(
//                         fillColor: Colors.grey.shade100,
//                         filled: true,
//                         hintText: 'confirm password',
//                         hintStyle: const TextStyle(color: Colors.black),
//                         enabledBorder: OutlineInputBorder(
//                           borderRadius: BorderRadius.circular(10),
//                           borderSide: const BorderSide(color: Colors.black),
//                         ),
//                       ),
//                     ), 
                    
//                     const SizedBox(
//                       height: 50,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 225),
//                       child: ElevatedButton(onPressed: (){
//                         if(_form.currentState!.validate()){
//                         insertData();
//                         }
//                       },
//                        style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.black),
//                        padding: MaterialStateProperty.all(const EdgeInsets.symmetric(vertical: 15,horizontal: 20)),),
//                        child:  Text("Submit",
//                        style: TextStyle(color: Colors.white),),
//                        ),
//                     ),     
//                       ],
//                     ),
//                 ),
//             ))]),) 
//           ]),
//         ),
//                     ),  
//         );    
//   }
//   insertData()async{
//     Map data ={
//         "apiKey":"12341234",
//       "functionName":"otp_verify_password",
//         "param":{
//           "email":widget.email,
//           "otp": widget.otp,
//           "password": name1.text
//         }
//       };
//     var body = json.encode(data);
//       var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
//       var response= await http.post(url, body:body);
//       print('Response status: ${response.statusCode}');
//       print('Response body: ${response.body}');
//       if(response.statusCode == 200)
//       {
//         print(response.body);
//         var msg = jsonDecode(response.body);
//         print(msg);
//         if(msg['status']==200)
//         {
//           setState(() {
//             Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//                                   return MyLogin();
//                             },));
//           });
            
//         }
//         }
//       }
//   }



