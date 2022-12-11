import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:user/dashboard.dart';
import 'package:user/login.dart';
import 'package:http/http.dart' as http;
import 'package:user/mainscreen.dart';
import 'package:user/register%20verify.dart';

class MyRegister extends StatefulWidget
{
  const MyRegister({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> 
{
  bool isSelect =false;
  int undo=1;
  final text1=TextEditingController();
  final text2=TextEditingController();
  final text3=TextEditingController();
  final text4=TextEditingController();
  final text5=TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          color: Colors.yellow[700]
       ),
       
        // color: const Color.fromARGB(255, 241, 194, 177),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   leading: IconButton(onPressed: (){
          //     Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          //                      return Main();
          //     },));
          //   }, icon: Icon(Icons.home)),
          // ),
          body: SingleChildScrollView(
            child: Column(children: [
              Container(
                padding: const EdgeInsets.only(top: 100),
                child: const Text(
                  "CREATE ACCOUNT",
                  style: TextStyle(color: Colors.black, fontSize: 35), 
                ),
              ),
    
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(right: 20,left: 20,),
                  child:  Column(
                    children: [
                    const Padding(padding: EdgeInsets.only(left: 1400,bottom:30,top: 20)),          
                    ToggleSwitch(
                      customWidths: const [90.0, 90.0],
                      // cornerRadius: 30.0,
                      activeBgColors: const [[Colors.black], [Colors.black]],
                      activeFgColor: Colors.white,
                      inactiveBgColor: Colors.white,
                      inactiveFgColor: Colors.black,
                      totalSwitches: 2,
                      initialLabelIndex: isSelect? 0:1,
                      labels: const ['Student', 'Teacher'],
                      onToggle: (index){
                        print('switched to: $index');
                        setState(() {
                            isSelect=!isSelect;
                            undo = index!;
                            print(undo);
                        });
                      }
                      // onToggle: (usertype) {
                      //   // ignore: avoid_print
                      //   controller:text1;
                      //   print('switched to: $usertype');
                      // },
                    ),
    
                     const SizedBox(height:30,),
    
                    TextField(
                      controller: text2,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        hintText: 'Name',
                        hintStyle: const TextStyle(color: Colors.black),),
                    ),
    
                    const SizedBox(height: 30,),
    
                    TextField(
                      controller: text3,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.black),),
                    ),
    
                    const SizedBox(height: 30,),
    
                    TextField(
                        controller: text4,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        hintText: 'Contact Number',
                        hintStyle: const TextStyle(color: Colors.black),),
                    ),
    
                    const SizedBox(height: 30,),
    
                    TextField(
                        controller: text5,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.black),),
                    ),
    
                    const SizedBox(height: 40,),
    
                    Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Padding(padding: EdgeInsets.only(right:200,)),
                          ElevatedButton(      
                                onPressed: () {
                                  insertData();
                                //    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                //  return Dashboard();
                                //     },));
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.black)),
                                child: const Text(
                                  'Register',
                                  style: TextStyle(fontSize: 18,color: Colors.white,),
                                ),
                           ),
                        ]
                    ),
    
                    const SizedBox(height: 10,),
    
                    // Row(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       TextButton(
                    //         onPressed: () {
                    //           Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                    //             return const MyLogin();
                    //           },));
                    //         },
                    //         child: const Text(
                    //           'Login',
                    //           style: TextStyle(decoration: TextDecoration.underline,
                    //             fontSize: 20,color: Colors.black,),
                    //         ),
                    //       ),
                    //     ]
                    //   ),
                  ]),
                ),
              )
            ]),
          ),
        ),
      ),
    );
  }

insertData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"register_user",
      "param":{
            "name":text2.text,
            "email":text3.text,
            "phone":text4.text,
            "password":text5.text,
            "usertype":undo
             }
      };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200)
    {
          // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
          //                        return MyVeri(email:text3.text);}));
                          
        
    }
  }
}