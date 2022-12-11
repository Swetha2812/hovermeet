import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:user/dashboard.dart';
import 'package:user/enrolledcourse.dart';
import 'package:user/mainscreen.dart';
import 'package:user/notification.dart';
// import 'package:user/enrolledcourse.dart';


class EnrollClass extends StatefulWidget {
  final String name,id;
  const EnrollClass({Key? key, required this.name, required this.id}) : super(key: key);

  @override
  State<EnrollClass> createState() => _EnrollClassState();
}

class _EnrollClassState extends State<EnrollClass> {
  List _loaded1 =[];
  var cid;
  var liveid;
  @override
  void initState() {
        super.initState();
        getdata();

  }
  getdata()async{
  Map data ={"apiKey":"12341234",
    "functionName":"classdetails",
      "param":{
              "cate":widget.name,
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
  var buttonText ="Enroll Course";
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
            leading: IconButton(onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return Dashboard(id:widget.id);})); 
            }, icon: Icon(Icons.arrow_back)),
            backgroundColor: Colors.yellow[700],
            title:Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text("Class Details", style: TextStyle(color: Colors.white, fontSize: 30,),),
            ),
            ),
          body:
          SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 10,),
                Container(
                  color: Colors.white,
                  height: MediaQuery.of(context).size.height,
                  child: Expanded(
                    child:ListView.builder( itemCount: _loaded1.length,
                            itemBuilder: (BuildContext ctx, i) {
                              return Card(
                                color: Colors.yellow[700],
                                child: Container(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Image(image: AssetImage("assets/images.jpeg")),
                                        SizedBox(height: 15,),
                                      Text('${_loaded1[i]['title']}', style: TextStyle(fontSize: 20, color: Colors.white),),
                                      SizedBox(height: 10,),
                                      Text('${_loaded1[i]['descr']}', style: TextStyle(fontSize: 17, color: Colors.black),),
                                       SizedBox(height: 10,),
                                       Text('${_loaded1[i]['day']}',style: TextStyle(fontSize: 17, color: Colors.black)),
                                      // Text("Sunday"),
                                                SizedBox(height: 10,),
                                                Text('Timing : ${_loaded1[i]['from_time']} to ${_loaded1[i]['to_time']} ',style:TextStyle(fontSize: 17, color: Colors.black) , ),
                                                // Text("10:00:00 AM"),
                                                // SizedBox(height: 10,),
                                                // Text('${_loaded1[i]['to_time']}'),
                                                // Text("11:00:00 AM"),
                                                SizedBox(height: 10,),
                                    
                                            Padding(
                                              padding: const EdgeInsets.only(left: 235,bottom: 5),
                                              child: ElevatedButton(onPressed: (){
                                                liveid=_loaded1[i]['liveId'];
                                                cid=_loaded1[i]['cId'];
                                                print(liveid);
                                                  frstdata();
                                                
                                              
                                              },style:ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black)),
                                               child:Text(buttonText)),
                                            ),
                                      ]),
                                  ),
                                ),
                              );
    
                            })
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
              },));
              },
              // padding: const EdgeInsets.only(top: 7),
              icon: const Icon(Icons.home,size: 30,color: Colors.white),),
              Text("Home", style: TextStyle(color: Colors.white),)
                  ],
                ),
                Column(
                  children: [
                    IconButton(onPressed: (() {
                       Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                               return Enrolled(id: widget.id);
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
        ),
      ),
    );
    
  }
  frstdata() async{
    Map data ={"apiKey":"12341234",
    "functionName":"enroll",
      "param":{
              "uid":widget.id,
               "lid":liveid,
               "cid":cid

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
                                            return EnrollClass(name:widget. name, id:widget. id);
                                         },));
      
       });
        
    }
  }
}