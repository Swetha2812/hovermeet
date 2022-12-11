import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user/mainscreen.dart';
import 'package:user/notification.dart';

class Enrolled extends StatefulWidget {
  final String id;
  const Enrolled({Key? key, required this.id}) : super(key: key);

  @override
  State<Enrolled> createState() => _EnrolledState();
}

class _EnrolledState extends State<Enrolled> {
List _loaded1 =[];
var cid;
var liveid;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getenroll();
  }
  getenroll()async{
  Map data ={"apiKey":"12341234",
    "functionName":"enrolleddata",
      "param":{
              "uid":widget.id
             }
      };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200)
    {
      //print(response.body);
      var msg = jsonDecode(response.body);
       setState(() {
       _loaded1=msg['data'];  
       print(_loaded1);
       });
        
    }
   }

  @override
  Widget build(BuildContext context) {

 return Container(
  decoration:const BoxDecoration(
      image: DecorationImage(
        image:AssetImage("assets/1.jpg"),
        fit: BoxFit.fill, ),
     ),
      // color: Color.fromARGB(255, 241, 194, 177),
    child: Scaffold(
      backgroundColor: Colors.transparent,
       appBar: AppBar(
        backgroundColor: Colors.black,
        leading:IconButton(onPressed: (){
          
        }, icon: Icon(Icons.arrow_back)),
        title:Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Enrolled Courses", style: TextStyle(color: Colors.white, fontSize: 30,),),
        ),
      
        ),
      body: 
          Card( 
            color: Color.fromARGB(103, 255, 255, 255),
            child: ListView.builder( padding:const EdgeInsets.only(top:10,),  
              itemCount:_loaded1.length ,
               itemBuilder:(context,i) =>
                 Card(
                              child: Container(
                                child: Column(
                                  children: [
                                    SizedBox(height: 10,),
                                  Text('${_loaded1[i]['title']}'),
                                  SizedBox(height: 10,),
                                  Text('${_loaded1[i]['descr']}'),
                                   SizedBox(height: 10,),
                                   Text('${_loaded1[i]['day']}'),
                                  // Text("Sunday"),
                                            SizedBox(height: 10,),
                                            Text('${_loaded1[i]['from_time']}'),
                                            // Text("10:00:00 AM"),
                                            SizedBox(height: 10,),
                                            Text('${_loaded1[i]['to_time']}'),
                                            // Text("11:00:00 AM"),
                                            SizedBox(height: 10,),
                                  SizedBox(height: 20,),
                                        ElevatedButton(onPressed: (){
                                          liveid=_loaded1[i]['liveId'];
                                          cid=_loaded1[i]['cId'];
                                          print(liveid);
                                          setState(() {
                                            frstdata();
                                          });

                                        }, child:Text("UnEnroll")),
                                  ]),
                              ),
                            ) 
              
                    ),
                  ),
                  bottomNavigationBar: Container(
          color: Colors.black,
          height: 70,
          // decoration: ,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(onPressed:() {
              // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
              //                return Dashboard(id: widget.id);
            // },));
            },
            // padding: const EdgeInsets.only(top: 7),
            icon: const Icon(Icons.home,size: 30,color: Colors.white),),
            Text("Home", style: TextStyle(color: Colors.white),)
                ],
              ),
              Column(
                children: [
                  IconButton(onPressed: (() {
            //          Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
            //                  return Enrolled(id: widget.id);
            // },));
                  }), 
                  icon:const Icon(Icons.pages),iconSize:30,color: Colors.white),
                
            Text("Enrolled Courses", style: TextStyle(color: Colors.white),),],),

            Column(
          children: [
            IconButton(onPressed:() {
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                             return Notify();
            },));},
            // padding: const EdgeInsets.only(top: 5),
            icon: const Icon(Icons.notifications),iconSize:30,color: Colors.white,),
            Text("Notification", style: TextStyle(color: Colors.white),)
          ],
         ),

             Column(
               children: [
                 IconButton(onPressed: (() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return Main();
            },));
            }), icon:const Icon(Icons.logout_outlined),iconSize:30,color: Colors.white),
            Text("Logout", style: TextStyle(color: Colors.white),)
               ],
             ),
            ],
          ),
        ),
                  ),
               ); 
  }
    frstdata() async{
    Map data ={"apiKey":"12341234",
    "functionName":"unenroll",
      "param":{           
               "lid":liveid
             }
      };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode == 200)
    {
      //print(response.body);
      var msg = jsonDecode(response.body);
       setState(() {
        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                            return Enrolled( id:widget. id);
                                         },));
      
       });
        
    }
  }
}
   