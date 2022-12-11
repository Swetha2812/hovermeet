import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:http/http.dart' as http;
import 'package:user/dashboard.dart';
import 'dart:convert';
import 'package:user/enrolledcourse.dart';


class Search extends StatefulWidget {
  final String id;
  const Search({Key? key, required this.id}) : super(key: key);

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  bool error=false, data=false;
  List _loaded = [];
     insertData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"get_all_classes",
      "param":{
            "search":text3.text,
            "uId":widget.id,
            "search_enroll":text3.text
             }
    };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    // print('Response body: ${response.body}');
    if(response.statusCode == 200)
    {
      //print(response.body);
      var msg = jsonDecode(response.body);
       setState(() {
       _loaded=msg['data'];  
       print(_loaded);
       });
        
    }
  }
  final text3=TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration:const BoxDecoration(
          color: Colors.white
       ),
        
        child: Scaffold(
          backgroundColor: Colors.transparent,
           appBar: AppBar(
          leading:IconButton(onPressed: (){
            Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                               return Dashboard(id: widget.id);
              },));
          }, icon:const Icon(Icons.arrow_back),iconSize:25,),
          backgroundColor: Colors.yellow[700],
          title:Padding(
            padding: const EdgeInsets.all(50.0),
            child: Text("Search", style: TextStyle(fontSize: 30,),),
          ),
             actions:[
          ], 
          ),
        body:Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top:25,right: 10,left: 10,),
              child: TextField(
                      controller: text3,
                      decoration: InputDecoration(
                        fillColor: Colors.yellow[700],
                        filled: true,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(color: Colors.black),),
                        suffix: IconButton(onPressed: (() {
                    insertData();
                  }),icon: Icon(Icons.search)),
                        hintText: 'Search Category',
                        hintStyle: const TextStyle(color: Colors.black),),
                    ),
            ),
            
            SizedBox(height: 10,),
            Expanded(
              child: Container(
                color: Color.fromARGB(103, 12, 12, 12),
                child: ListView.builder(
                          itemCount: _loaded.length,
                          itemBuilder: (BuildContext ctx, index) {
                            return ListTile(
                              title: Row( 
                                children: [
                                  // Icon(Icons.filter_frames_sharp),
                                  Column(crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('${_loaded[index]["title"]}'),
                                      SizedBox(height: 10,),
                                      Text('${_loaded[index]["descr"]}'),
                                      SizedBox(height: 10,),
                                      Text('${_loaded[index]["day"]}'),
                                      // Text("Sunday"),
                                      SizedBox(height: 10,),
                                      Text('${_loaded[index]["from_time"]}'),
                                      // Text("10:00:00 AM"),
                                      SizedBox(height: 10,),
                                      Text('${_loaded[index]["to_time"]}'),
                                      // Text("11:00:00 AM"),
                                      SizedBox(height: 10,),
                                      Padding(
                                        padding: const EdgeInsets.only(left: 150),
                                        child: Row(mainAxisAlignment: MainAxisAlignment.end,
                                          children: [
                                            ElevatedButton(onPressed: (){
                                              Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                              return Enrolled(id: widget.id,);
                                             },));
                                            }, child:Text("ENROLL CLASS")),
                                          ],
                                        ),
                                      ),
                                      Divider(),
                                    ],
                                  ),
                                ],
                              ),                           
                            );
                          },
                        ),
              ),
            ),
          ],
        ),
      )),
    ); 
  }

}