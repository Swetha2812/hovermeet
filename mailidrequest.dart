import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:user/login.dart';
import 'package:user/otp.dart';
import 'dart:convert';
import 'package:user/verify.dart';

class EmailCheck extends StatefulWidget 
{
  const EmailCheck({Key? key}) : super(key: key);
  @override
  _EmailCheckState createState() => _EmailCheckState();  
}

class _EmailCheckState extends State<EmailCheck> 
{
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  TextEditingController name1 = TextEditingController();
  TextEditingController name2 = TextEditingController();
  final text3=TextEditingController();
  @override
  Widget build(BuildContext context) 
  {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
        color: Colors.yellow[700]
       ),
        // color: const Color.fromARGB(255, 241, 194, 177),
        child: SafeArea(
          child: Scaffold(
            backgroundColor: Colors.transparent,
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(left: 10,right: 10,bottom: 20),
                  child: Column(
                    children: [Padding(padding: EdgeInsets.only(top: 150,)),
                              
                              SizedBox(height: 10,),
                      SingleChildScrollView(
                        child: Container(
                          padding: const EdgeInsets.only(right: 15,left: 15),
                            child: Column(children: [
                              Text(
                         "Enter your registered email id",
                         
                         style: TextStyle(color: Color.fromARGB(255, 12, 12, 12), fontSize: 23),
                        ),
                          SizedBox(height: 100,),   
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
                            SizedBox(height: 15,),
                            TextFormField(
                      controller: name1,
                      validator:(val){
                      if(val!.isEmpty)
                      {
                        return 'Empty';
                      }
                      else{
                        return null;
                      }
                      },
                       obscureText: true,
                      decoration: InputDecoration(
                      fillColor: Color.fromRGBO(245, 245, 245, 1),
                      filled: true,
                      hintText: 'new password',
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      ),
                      ),
                      const SizedBox(
                      height: 20,
                      ),
                      TextFormField(
                      controller: name2,
                      validator: (val){
                      if(val!.isEmpty)
                      {
                        return 'Empty';
                      }
                      else if(val!=name1.text)
                      {
                        return 'Password Not Matching';
                      }
                      else{
                        return null;
                      }
                      },
                       obscureText: true,
                      decoration: InputDecoration(
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      hintText: 'confirm password',
                      hintStyle: const TextStyle(color: Colors.black),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: const BorderSide(color: Colors.black),
                      ),
                      ),
                      ), 
                      SizedBox(height: 15,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Padding(padding: EdgeInsets.only(left: 100)),
                                ElevatedButton(
                                        onPressed: () {
                                          insertData();
                              //             Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                              //  return  MyVeri(email: text3.text);
                        // },)); 
                                        },
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                                        child: const Text(
                                          'Submit',
                                          style: TextStyle(fontSize: 18,color: Colors.white,),
                                        ),
                                  ),
                              ],
                            ),
                            SizedBox(height: 15,),
                          ],),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
  insertData()async{
    Map data ={
      "apiKey":"12341234",
    "functionName":"forgot_password",
      "param":{
        "email":text3.text,
    }
  };
  var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200)
    {
      
        setState(() {
          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return ForgotPass();
                          },));  
        });
        
        }
        else{
          setState(() {
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return  MyLogin();
                          },));  
          });
        }
      }
    }

