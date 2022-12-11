import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:user/mainscreen.dart';
import 'package:user/notification.dart';
import 'package:user/profile.dart';


class EditProfile extends StatefulWidget {
  final String uemail;
  const EditProfile({Key? key, required this.uemail}) : super(key: key);

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
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
          // backgroundColor: Colors.transparent,
          appBar: AppBar(
            toolbarHeight: 60,
          backgroundColor: Color.fromARGB(255, 251, 192, 45),
          // leading:const  Icon(Icons.article_outlined),
          title:Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(" EDIT PROFILE", style: TextStyle(color: Colors.white, fontSize: 30,),),
          ),
          ),
      body: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.only(top:35,right: 15,left: 15),
        child: Container(
          color: Color.fromARGB(169, 251, 193, 45),
          child: Column(
            children: [Padding(padding: EdgeInsets.only(top: 20)),
            Container(
               height:120,
               width: 160,
            //   child:
            //  CircleAvatar( backgroundColor: Colors.white,),
             decoration: BoxDecoration(
              image:DecorationImage(image: AssetImage("assets/download.png")),
              shape: BoxShape.circle
             ),
             child: Column(crossAxisAlignment: CrossAxisAlignment.end,
               children: [
                 Icon(Icons.add),
               ],
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
              SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 150),
                child: ElevatedButton(onPressed: () {
                 insertData();
                },
                style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)), 
                child: Text("Submit",style: TextStyle(color: Colors.black, fontSize: 16),)),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
        
      ),
      ),
        ),
      ),
    );
 
      }
  insertData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"user_update",
      "param":{
            "id":widget.uemail,
            "email":emailId.text
      }
    };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode==200)
    {
      var msg=jsonDecode(response.body);
      
      setState(() {
               Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return Profile(uemail:widget.uemail);})); 
        });
     
    }
     else
      {
        print('Error');
      }
  }
  }
