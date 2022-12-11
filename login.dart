// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:toggle_switch/toggle_switch.dart';
import 'package:user/dash.dart';
import 'package:user/dashboard.dart';
import 'package:user/mailidrequest.dart';
import 'dart:convert';
import 'package:user/register.dart';
import 'package:user/verify.dart';
import 'package:http/http.dart' as http;

class MyLogin extends StatefulWidget 
{
  const MyLogin({Key? key}) : super(key: key);
  @override
  // ignore: library_private_types_in_public_api
  _MyLoginState createState() => _MyLoginState();  
}

class _MyLoginState extends State<MyLogin> 
{
  bool isSelect =false;
  int undo=1;
  bool isSwitchOn = false;
  final text3=TextEditingController();
  final text5=TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
        color: Colors.yellow[700],
        // border: Border.all(color: Colors.white, width: 3),
        // borderRadius: BorderRadius.circular(20)
       ),
        // color: Color.fromARGB(255, 141, 192, 142),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Column(children: [
               Center(
                 child: Padding(
                   padding: EdgeInsets.only(top: 150),
                   child: const Text(
                     "LOGIN",
                     style: TextStyle(color: Color.fromARGB(255, 8, 8, 8), fontSize: 45),
                    ),
                  ),
                ), 
    
              SingleChildScrollView(
                child: Container(
                  padding: const EdgeInsets.only(top:50,right: 20,left: 20),
                    child: Column(children: [
                    ToggleSwitch(
                      // borderColor: [Colors.black, Colors.white],
                    customWidths: const [90.0, 90.0],
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
                  ),
                  SizedBox(height: 30,),   
    
                    TextField(
                      controller: text3,
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        hintText: 'Email',
                        hintStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
    
                    const SizedBox(height: 30,),
    
                    TextField(
                      controller: text5,
                      obscureText: true,
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        hintText: 'Password',
                        hintStyle: const TextStyle(color: Colors.black),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
    
                    const SizedBox(height: 10,),
                    
                    Row(
                      children: [
                        const Padding(padding: EdgeInsets.only(left:3)),
                        TextButton(
                                onPressed: () {
                                   Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return EmailCheck();
                                },));
                                },
                                child: const Text(
                                  'Forgot Password ?',
                                  style: TextStyle(fontSize: 18,color:Colors.black,),
                                ),
                          ),
                      ],
                    ),
    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Padding(padding: EdgeInsets.only(left: 100)),
                        ElevatedButton(
                                onPressed: () {
                                  insertData();
                                },
                                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                                child: const Text(
                                  'Login',
                                  style: TextStyle(fontSize: 18,color: Colors.white,),
                                ),
                          ),
                      ],
                    ),
    
                    const SizedBox(height:80,),
                    
                    // Column(
                    //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    //     children: [
                    //       TextButton(
                    //         onPressed: () {
                    //           Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                    //             return const MyRegister();
                    //           }));
                    //         },
                    //         child: const Text(
                    //           'Sign Up',
                    //           style: TextStyle(decoration: TextDecoration.underline,
                    //             fontSize: 18,color: Color.fromARGB(255, 3, 5, 8),
                    //           ),
                    //         ),
                    //       ),  
                    //     ],
                    //   ),
                  ],),
                ),
              ), 
            ],),
          ),
        ),
      ),
    );
  }
    


  insertData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"login_user",
      "param":{
            "email":text3.text,
            "passwrd":text5.text,
            "usrtyp":undo
             }
    };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200)
    {
      print(response.body);
      var msg = jsonDecode(response.body);
       print(msg);
      if(msg["status"]==200)
      {
        var umail=msg["userInfo"];
        if(undo==0){
        setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return Dashboard(id:umail);
                          },));  
        }); 
      }
      else if(undo==1){
        setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return Dash(umail:umail);
                          },));  
        }); 
      }
      else
      {
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return MyLogin();
                                },));
        });
        
      }
    }
  }
}
}