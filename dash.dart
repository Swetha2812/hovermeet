import 'package:flutter/material.dart';
import 'package:user/addclass.dart';
import 'package:user/mainscreen.dart';
import 'package:user/myclass.dart';
import 'package:user/prof.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


class Dash extends StatefulWidget {
  final String umail;
  // final String uemail1;
  // final String uemail2;
   const Dash({Key? key, required this.umail}) : super(key: key);

  @override
  State<Dash> createState() => _DashState();
}

class _DashState extends State<Dash> {
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
          leading:
                    IconButton(onPressed: (() {
                      
                     Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                   return Prof(uemail:widget.umail);
              },));
                    }), icon:const Icon(Icons.person),iconSize:30,color: Colors.white,),
   
          backgroundColor:Colors.yellow[700],//fromARGB(197, 0, 0, 0),
          title:Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text("WELCOME", style: TextStyle(fontSize: 30,color: Colors.white),),
          ),
              ),
        body:SingleChildScrollView(
          child: Container( height: MediaQuery.of(context).size.height*15,
            child: Column(
              children: [
                 Center(child: Padding(
                   padding: const EdgeInsets.only(top:10),
                   child: const Text("Today's class on HoverMeet", style: TextStyle( color: Color.fromARGB(255, 5, 5, 5), fontSize: 20,),),
                 )),
                            // Text(widget.umail),
                            // SizedBox(height: 10,),
                Expanded(
                  child: Container(height: MediaQuery.of(context).size.height,
                    // color: Color.fromARGB(103, 255, 255, 255),
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: ListView.builder( padding:const EdgeInsets.only(top:5,),  
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: _loaded.length,
                      itemBuilder: (BuildContext ctx,i)=>    
                          Column(
                            children: [
                              SizedBox(
                                child: Card( color:Colors.yellow[700],
                                  child: Padding(
                                    padding: const EdgeInsets.all(15),
                                    child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                    
                                      children: [
                                    
                                        Divider(),
                                        SizedBox(
                                          height: 150,width: 150,
                                          child: Image(image: AssetImage("assets/images.jpeg"))),
                                    SizedBox(height: 10,),
                                              Text('${_loaded[i]['title']}',style:TextStyle(color: Color.fromARGB(255, 243, 240, 240), fontSize: 25) ,),
                                              SizedBox(height: 10,),
                                              Text('${_loaded[i]['descr']}',style:TextStyle(color: Color.fromARGB(255, 7, 7, 7), fontSize: 17) ,),
                                               SizedBox(height: 5,),
                                               Text('Day : ${_loaded[i]['day']}',style:TextStyle(color: Color.fromARGB(255, 10, 10, 10), fontSize: 17) ,),
                                              // Text("Sunday"),
                                                        SizedBox(height: 5,),
                                                        Text('Timing : ${_loaded[i]['from_time']} to ${_loaded[i]['to_time']}',style:TextStyle(color: Color.fromARGB(255, 14, 13, 13), fontSize: 17) ,),
                                                       Divider(),
                                              
                                                      ]),
                                  ),
                                ),
                              ),
                              SizedBox(
                            child: Card( color:Colors.yellow[700],
                              child: Padding(
                                padding: const EdgeInsets.all(15),
                                child: Column( crossAxisAlignment: CrossAxisAlignment.start,
                                
                                  children: [
                                
                                    Divider(),
                                    SizedBox(
                                      height: 150,width: 150,
                                      child: Image(image: AssetImage("assets/img.jpeg"))),
                                SizedBox(height: 10,),
                                Text("Organic Chemistry", style: TextStyle(color: Colors.white, fontSize: 25),),
                                          // Text('${_loaded[i]['title']}',style:TextStyle(color: Color.fromARGB(255, 243, 240, 240), fontSize: 25) ,),
                                          SizedBox(height: 10,),
                                          Text('${_loaded[i]['descr']}',style:TextStyle(color: Color.fromARGB(255, 7, 7, 7), fontSize: 17) ,),
                                           SizedBox(height: 5,),
                                           Text('Day : ${_loaded[i]['day']}',style:TextStyle(color: Color.fromARGB(255, 10, 10, 10), fontSize: 17) ,),
                                          // Text("Sunday"),
                                                    SizedBox(height: 5,),
                                                    Text('Timing : ${_loaded[i]['from_time']} to ${_loaded[i]['to_time']}',style:TextStyle(color: Color.fromARGB(255, 14, 13, 13), fontSize: 17) ,),
                                                   Divider(),
                                          
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
                                   return Myclass(umail: widget.umail);
              },));
                      
                    }), icon:const Icon(Icons.class_),iconSize:25,color: Colors.white,),
                  
              Text("Edit class", style: TextStyle(color: Colors.white),),],),
   
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
  Future<String?> openDialog() => showDialog(context: this.context,
   builder: (context) => AlertDialog(
    title: Text("Enter Category",
    textAlign: TextAlign.center,
    style: TextStyle(fontSize: 20),),
    content: TextField(
      autofocus: true,
      controller:_tcontroller,
      decoration: InputDecoration(
        border: OutlineInputBorder(),
        hintText: "Enter your Category",
        fillColor: Colors.white, filled: true,
      ),
    ),
actions: [
  ElevatedButton(onPressed: () {
       insertData();
    Navigator.of(context).pop();
  }, child:Text("submit"))
],
    ),
   );
   insertData()async{
    Map data ={"apiKey":"12341234",
    "functionName":"add_catagory",
      "param":{
            "categoryName":_tcontroller.text,    
             }
      };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
   }
   getData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"category",
      "param":{
            "cate":1
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
      //  print(msg); 
       setState(() {
       _loaded1=msg['data']; 
      
       print(_loaded1);
       });
        
    }
  }
}