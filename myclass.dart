import 'package:flutter/material.dart';
import 'package:user/addclass.dart';
import 'package:user/dash.dart';
import 'package:user/editclass.dart';
import 'package:user/mainscreen.dart';
import 'package:user/prof.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Myclass extends StatefulWidget {
  final String umail;
   const Myclass({Key? key, required this.umail}) : super(key: key);

  @override
  State<Myclass> createState() => _MyclassState();
}

class _MyclassState extends State<Myclass> {
  TextEditingController title = TextEditingController();
  TextEditingController descr = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController day = TextEditingController();
  TextEditingController from_time= TextEditingController();
  TextEditingController to_time = TextEditingController();
  List _loaded = [];
  List _loaded1 = [];
  List _loaded2 = [];
  final _tcontroller = TextEditingController();
  @override
   void initState(){
  super.initState();
  getData1();
  // getData2();
}
getData1() async{
  Map data ={"apiKey":"12341234",
    "functionName":"own_class",
      "param":{
            "uid":widget.umail,
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
       print(_loaded);
        // title.text = _loaded[0]["title"];
        // descr.text = _loaded[0]["descr"];
       });
        
    }
}

@override
  Widget build(BuildContext context) {
   return SafeArea(
     child: Container(
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 248, 248, 248),
        border:Border.symmetric(horizontal:BorderSide(color: Colors.white))
       ),
        //  color: Color.fromARGB(255, 241, 194, 177),
        
     // ignore: dead_code
     child:Scaffold(
        backgroundColor: Colors.transparent,
         appBar: AppBar(   
          backgroundColor:Colors.yellow[700],//fromARGB(197, 0, 0, 0),
          title:Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text("My Class", style: TextStyle(fontSize: 30,color: Colors.white),),
          ),
              ),
        body:SingleChildScrollView(
          child: Container( height: MediaQuery.of(context).size.height,
            child: Column(
              children: [
                 Center(child: Padding(
                   padding: const EdgeInsets.only(top:10),
                  //  child: const Text("Today's class on HoverMeet", style: TextStyle( color: Color.fromARGB(255, 5, 5, 5), fontSize: 20,),),
                 )),
                            // Text(widget.umail),
                            // SizedBox(height: 10,),
                Expanded(
                  child: Container(height: MediaQuery.of(context).size.height*15,
                    // color: Color.fromARGB(103, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder( padding:const EdgeInsets.only(top:15,), 
                      // physics: NeverScrollableScrollPhysics(), 
                      itemCount: _loaded.length,
                      itemBuilder: (BuildContext ctx,i)=>    
                          Column(
                            children: [
                              SizedBox(
                                child: Card( color:Colors.yellow[700],
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:15,right: 15,left: 15),
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    SizedBox(height: 10,),
                                              Text('${_loaded[i]['title']}',style:TextStyle(color: Colors.white, fontSize: 25) ,),
                                              SizedBox(height: 10,),
                                              Text('${_loaded[i]['descr']}',style:TextStyle(color: Colors.black, fontSize: 17) ,),
                                               SizedBox(height: 10,),
                                               Text('Day : ${_loaded[i]['day']}',style:TextStyle(color: Colors.black, fontSize: 17) ,),
                                              // Text("Sunday"),
                                                        SizedBox(height: 5,),
                                                        Text('Timing : ${_loaded[i]['from_time']} to ${_loaded[i]['to_time']}',style:TextStyle(color: Colors.black, fontSize: 17) ,),
                                                        // Text("10:00:00 AM"),
                                                        // SizedBox(height: 10,),
                                                        // Text('${_loaded[i]['to_time']}',style:TextStyle(color: Colors.white) ,),
                                                        // // Text("11:00:00 AM"),
                                                        // SizedBox(height: 10,),
                                                        Divider(thickness:3,),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(onPressed: (() {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                       return Editclass(email: widget.umail, liveid: _loaded[i]['liveId']);
              },));
                                                }), icon:Icon(Icons.edit)),

                                                IconButton(onPressed: () {
                                                  
                                                }, icon: Icon(Icons.delete))
                                              ],
                                            )
                                                      ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                                child: Card( color:Colors.yellow[700],
                                  child: Padding(
                                    padding: const EdgeInsets.only(top:15,right: 15,left: 15),
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                    
                                              Text('Organic Chemistry',style:TextStyle(color: Color.fromARGB(255, 250, 248, 248),fontSize: 25) ,),
                                              SizedBox(height: 10,),
                                              Text("Portions to be covered :\nDefinition of Organic Chemistry, it's bond, reagent, stability etc",style:TextStyle(color: Color.fromARGB(255, 14, 13, 13), fontSize: 17) ),
                                               SizedBox(height: 10,),
                                               Text('Day : Wednesday',style:TextStyle(color: Color.fromARGB(255, 17, 17, 17), fontSize: 17) ,),
                                              // Text("Sunday"),
                                                        SizedBox(height: 10,),
                                                        Text('Timing : 11:00:00 to 12:30:00',style:TextStyle(color: Color.fromARGB(255, 10, 10, 10), fontSize: 17) ,),
                                                        // Text("10:00:00 AM"),
                                                        SizedBox(height: 10,),
                                                        // Text('${_loaded[i]['to_time']}',style:TextStyle(color: Colors.white) ,),
                                                        // Text("11:00:00 AM"),
                                                        SizedBox(height: 10,),
                                                        Divider(thickness:3,),
                                            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                IconButton(onPressed: (() {
                                                        Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                       return Editclass(email: widget.umail, liveid: _loaded[i]['liveId']);
              },));
                                                }), icon:Icon(Icons.edit)),

                                                IconButton(onPressed: () {
                                                  
                                                }, icon: Icon(Icons.delete))
                                              ],
                                            )
                                                      ]),
                                  ),
                                ),
                              ),
                              
                            ],
                          ), 
                      ),
                    ),
                    
                  ),
                )]
            ),
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
                    IconButton(onPressed: (() {
                           Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                   return Dash(umail: widget.umail);
              },));
                    }), icon:const Icon(Icons.home),iconSize:25,color: Colors.white,),
                  
              Text("Home", style: TextStyle(color: Colors.white),),],),
   
                Column(
                  children: [
                    IconButton(onPressed: (() {
                      
                     Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                   return Addclass(email: widget.umail);
              },));
                    }), icon:const Icon(Icons.add),iconSize:25,color: Colors.white,),
                  
              Text("Add class", style: TextStyle(color: Colors.white),),],),
   
              Column(
                  children: [
                    IconButton(onPressed: (() {
                    
                    }), icon:const Icon(Icons.notifications),iconSize:25,color: Colors.white,),
                  
              Text("Notification", style: TextStyle(color: Colors.white),),],),
   
              // Column(
              //   children: [
              //     IconButton(onPressed: (() async {
              //       await openDialog();
              //     }), icon:const Icon(Icons.add),iconSize:25,),
               
              // Text("Add Category", style: TextStyle(color: Colors.white),), ],),
   
               Column(
                 children: [
                   IconButton(onPressed: (() {
                    Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                   return Main();
              },));
              }), icon:const Icon(Icons.logout_outlined),iconSize:25,color: Colors.white,),
                 Text("Logout", style: TextStyle(color: Colors.white),),
                 ],
               ),
              ],
            ),
          ),
     ),),
   );
  }
}