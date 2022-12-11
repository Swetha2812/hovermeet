import 'package:flutter/material.dart';
import 'package:user/enrollclass.dart';
import 'package:user/enrolledcourse.dart';
import 'package:user/mainscreen.dart';
import 'package:user/notification.dart';
import 'package:user/profile.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:user/search.dart';
class Dashboard extends StatefulWidget {
  final String id;
  const Dashboard({Key? key, required this.id}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
List _loaded1 = [];

  @override
  void initState() 
  {
      super.initState();
    getdata();
  }
getdata()async{
  Map data ={"apiKey":"12341234",
    "functionName":"category",
      "param":{
              "cate":1
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
   return SafeArea(
     child: Container(
      // decoration:const BoxDecoration(
      //   image: DecorationImage(
      //     image:AssetImage("assets/1.jpg"),
      //     fit: BoxFit.fill, ),
      //  ),
        color: Colors.white,
      child: Scaffold(
        backgroundColor: Colors.transparent,
         appBar: AppBar(
          leading:IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                               return Profile(uemail: widget.id);
              },));
          }, icon:const Icon(Icons.person),iconSize:30,),
          backgroundColor: Colors.yellow[700],
          title:Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text("Welcome", style: TextStyle(fontSize: 30,),),
          ),
             actions:[
          ], 
          ),
          body:SingleChildScrollView(
            child: Column(
              children: [
                SizedBox( height: 60,
                  child: Container(
                          // color: Color.fromARGB(103, 255, 255, 255),
                          color: Colors.transparent,
                          width: MediaQuery.of(context).size.width,
                          child: Row(
                            children: [
                              SizedBox(width: 100,),
                              Center(child: Text("Categories", style: TextStyle(fontSize: 30),)),
                              SizedBox(width: 90,),
                              IconButton(onPressed: (() {
                                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                             return Search(id:widget.id);}));
                              }), 
                                icon:const Icon(Icons.search),),
                            ],
                          )),
                ),
                Container(
                  height: MediaQuery.of(context).size.height,
                  padding: EdgeInsets.only(left: 10,right: 10,top: 10),
                  child: Expanded(
                    child: CustomScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    primary: false,
                    slivers: <Widget>[
                      SliverPadding(
                        padding: const EdgeInsets.only(left: 10,right: 10,bottom: 10),
                        sliver: SliverGrid.count(
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    crossAxisCount: 2,
                    children: <Widget>[for(int i=0; i<_loaded1.length;i++)
                      Container(
                        // padding: const EdgeInsets.all(30),
                        color: Colors.yellow[700],
                        child: Center(
                          child: Column(mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(onPressed: (() {
                                setState(() {
                                  var data = _loaded1[i]['categoryName'];
                                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                     return EnrollClass(name:data,id: widget.id,);
                  },));
                                });
                              }), 
                              
                              icon: Icon(Icons.computer),iconSize: 45,),
                              Text('${_loaded1[i]['categoryName']}'),
                            ],
                          ),
                        ),
                      ),
                    ],
                        ),
                      ),
                  
                                              ]),
                  ),
                ),
              ],
            ),
          ),
          bottomNavigationBar: Container(
            color: Colors.yellow[700],
            height: 70,
            // decoration: ,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    IconButton(onPressed:() {
                Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                               return Dashboard(id: widget.id);
              },));},
              // padding: const EdgeInsets.only(top: 7),
              icon: const Icon(Icons.home,size: 30,color: Colors.white),),
              Text("Home", style: TextStyle(color: Colors.white),)
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: (() {
                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                               return Enrolled(id: widget.id,);
              },));
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
     )),
   ); 
  }

  insertData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"get_all_classes",
      "param":{
        "search": "chemistry"
      }
    };
  }
}  