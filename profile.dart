import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:user/dashboard.dart';
import 'package:user/editprofile.dart';
import 'package:http/http.dart' as http;
import 'package:user/enrolledcourse.dart';
import 'dart:convert';

import 'package:user/mainscreen.dart';
import 'package:user/notification.dart';



class Profile extends StatefulWidget {
  final String uemail;
  const Profile({Key? key, required this.uemail}): super(key: key);
  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController uId = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController emailId = TextEditingController();
  TextEditingController phone = TextEditingController();
  List _loaded = [];
  @override
  void initState(){
  super.initState();
  
  getData();
}
getData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"profile",
      "param":{
            "mail":widget.uemail,
            "utype":0
             }
    };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    // print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if(response.statusCode == 200)
    {
      //print(response.body);
      var msg = jsonDecode(response.body);
       setState(() {
       _loaded=msg['data'];  
        uId.text = _loaded[0]["uId"];
        name.text = _loaded[0]["name"];
         emailId.text = _loaded[0]["emailId"];
          phone.text = _loaded[0]["phone"];
       });
        
    }
  }
   
  @override
  Widget build(BuildContext context) {
    return SafeArea(
     child: Container(
      decoration:const BoxDecoration(
       ),
        // color: Color.fromARGB(255, 241, 194, 177),
        child: Scaffold(
        
          appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          leading: IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                              return Dashboard(id: widget.uemail);
              },));
          }, icon: const Icon(Icons.arrow_back),iconSize:25,color: Colors.black,),
          title:const Center(
            child: Text("PROFILE", style: TextStyle(color: Colors.black, fontSize: 30,),)
          ),
          actions:[Column(
            children: [
              IconButton(onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                              return EditProfile(uemail: widget.uemail);
              },));},
              padding: const EdgeInsets.only(top: 5),
              icon: const Icon(Icons.edit),iconSize:30,color: Colors.black,), 
            ],
           ),
          ],
          ),
     body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(right:15,left:15,top: 50),
        child: Container(
          color: Color.fromARGB(169, 251, 193, 45),
          child: Column(
            children: [Padding(padding: EdgeInsets.only(top: 20)),
            Container(
               height:120,
               width: 160,
              // child:
            //  CircleAvatar( backgroundColor: Colors.white,),
             decoration: BoxDecoration(
              image:DecorationImage(image: AssetImage("assets/download.png")),
              shape: BoxShape.circle,
              
             ),
             
             ),
            SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50,left: 50),
                child: TextField(
                  controller: uId,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "User id",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )
                  )       ),
                  
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50,left: 50),
                child: TextField(
                  controller: name,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Name",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )
                  )       ),
                  
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50,left: 50),
                child: TextField(
                  controller: emailId,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Email id",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )
                  )       ),
                  
              ),
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(right: 50,left: 50),
                child: TextField(
                  controller: phone,
                  readOnly: true,
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Contact Number",
                    labelStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.black),
                    )
                  )       ),
              ),
              
              SizedBox(height: 50,)
            ],
          ),
        ),
      ),
     ),
        ),
      ),
   );
     }
     
}