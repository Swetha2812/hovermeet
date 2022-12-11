// import 'package:flutter/material.dart';
// import 'package:user/login.dart';
// import 'dart:async';
// import 'package:user/newpassword.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert';


// class MyVeri extends StatefulWidget {
//    final String email;
//    // ignore: prefer_const_constructors_in_immutables
//    const MyVeri({Key? key, required this.email}) : super(key: key);

//   @override
//   State<MyVeri> createState() => _VerificationState();
// }

// class _VerificationState extends State<MyVeri> {
//  TextEditingController value = TextEditingController();
// bool _isResendAgain=false;
// bool _isVerified=false;
// bool _isLoading=false;

// String _code='';

// // ignore: unused_field
// late Timer _timer;
// int _start=60;

// // ignore: non_constant_identifier_names
// void Resend(){
//   setState(() {
//     _isResendAgain=true;
//   });

//   const oneSec=Duration(seconds: 1);
//   // ignore: unnecessary_new
//   _timer=new Timer.periodic(oneSec, (timer) {
//     setState(() {
//       if(_start==0)
//       {
//         _start=60;
//         _isResendAgain=false;
//         timer.cancel();
//       }
//       else{
//         _start--;
//       }
//     });
//    });
// }

// verify(){
// setState(() {
//   _isLoading=true;
// });

// const oneSec=Duration(milliseconds: 1000);
//   // ignore: unnecessary_new
//   _timer=new Timer.periodic(oneSec, (timer) {
//     setState(() {
//       _isLoading=false;
//       _isVerified=true;
//     });
//    });
// }

//   @override
//   Widget build(BuildContext context) {
//    return Container(
//       color: Color.fromARGB(255, 241, 194, 177),
//      child: Scaffold(
//        backgroundColor: Colors.transparent,
//       body: SingleChildScrollView(
//         // ignore: avoid_unnecessary_containers
//         child: Padding(
//           padding: const EdgeInsets.only(top: 150,left: 20,right: 20),
//           child: Column(
//             children: [Container(
//                       padding: const EdgeInsets.only(right:10,bottom: 50),
//                       child: const Text(
//                         "OTP Verification", 
//                         style:TextStyle(fontSize: 40,color:Colors.black) ,
//                       ),
//                     ),
//               Container(
//                 color: Color.fromARGB(136, 158, 158, 158),
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Column(
//                   children: [
//                     const SizedBox(height: 20,),
//                     const Text("Please enter the 6 digit code ",
//                     textAlign: TextAlign.center,
//                     style: TextStyle(fontSize: 20, color: Colors.black,height: 1.5),
//                     ),
//                     const SizedBox(
//                       height: 30,
//                       ),
//                     SingleChildScrollView(
//                       child: TextField(
//                                   controller: value,
//                                   decoration: InputDecoration(
//                                     fillColor: Colors.grey.shade100,
//                                     filled: true,
//                                     hintText: 'otp',
//                                     hintStyle: const TextStyle(color: Colors.black),
//                                     enabledBorder: OutlineInputBorder(
//                                       borderRadius: BorderRadius.circular(10),
//                                       borderSide: const BorderSide(color: Colors.black),
//                                     ),
//                                   ),
//                                 ),
//                     ),
//                     const SizedBox(
//                       height: 10,
//                       ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         const Text("Don't receive the OTP?", style: TextStyle(fontSize: 18,color: Colors.black),),
//                       TextButton(
//                         onPressed: (){
//                           if(_isResendAgain) return;
                          
//                           Resend();
//                         },
//                          child: Text(
//                           // ignore: prefer_interpolation_to_compose_strings
//                           _isResendAgain ? "Try again in"+_start.toString():"Resend", 
//                           style: const TextStyle(fontSize: 16,color: Colors.white),)
//                           )
//                       ],
//                     ),
//                     const SizedBox(
//                       height: 50,
//                       ),
//                       ElevatedButton(onPressed: _code.length>=6? null:() {
//                         insertData();
//                       },
//                       style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
//                       child: const Text(
//                           "Verify", 
//                           style: TextStyle(color: Colors.white),),),
//                           SizedBox(height: 30,),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//      ),
//    ) ;
//   }
//   insertData()async{
//     Map data ={
//       "apiKey":"12341234",
//     "functionName":"otp_verify",
//       "param":{
//         "email":widget.email,
//         "otp": value.text
//       }
//     };
//   var body = json.encode(data);
//     var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
//     var response= await http.post(url, body:body);
//     print('Response status: ${response.statusCode}');
//     print('Response body: ${response.body}');
//     if(response.statusCode == 200)
//     {
//       print(response.body);
//       var msg = jsonDecode(response.body);
//        print(msg);
//        if(msg['status']==200)
//       {
//         setState(() {
//           Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//                                  return MyLogin();
//                           },));  
//         });
        
//         }
//         // else{
//         //   setState(() {
//         //      Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
//         //                          return  MyLogin();
//         //                   },)); 
//         //   });
          
//         // }
//       }
//     }
// }