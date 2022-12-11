import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:user/calendar.dart';
import 'package:user/myclass.dart';

class Editclass extends StatefulWidget {
  final String email,liveid;
  const Editclass({Key? key, required this.email, required this.liveid}) : super(key: key);

  @override
  State<Editclass> createState() => _EditclassState();
}
const List<String> list = <String>['Select any day',
                        'Sunday',
                        'Monday',
                        'Tuesday',
                        'Wednesday',
                        'Thursday',
                        'Friday',
                        'Saturday',];

class _EditclassState extends State<Editclass> {

   List<DayTime> week = [];
  String? selectTime;
  TextEditingController timeInput= TextEditingController();
  TextEditingController timeInput1= TextEditingController();
  // TextEditingController dateInput= TextEditingController();
  final _tcontroller = TextEditingController();
  final _tcon=TextEditingController();
  final _tcontr=TextEditingController();
  final _tcontrll=TextEditingController();
  List _loaded = [];
    String dropdownvalue=list.first; 
     void initState() {
    timeInput.text="";
    super.initState();
    getData();
  }
   getData() async{
    Map data ={"apiKey":"12341234",
    "functionName":"own_class1",
      "param":{
            "uid":widget.email,
            "lid":widget.liveid
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
        _tcontr.text = _loaded[0]["title"];
        _tcontrll.text = _loaded[0]["descr"];
        //  dropdownvalue = _loaded[0]["day"];
          timeInput.text = _loaded[0]["from_time"];
            timeInput1.text = _loaded[0]["to_time"];
       });
        
    }
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.yellow[700],
          title:Padding(
            padding: const EdgeInsets.only(left: 35),
            child: Text("EDIT CLASS", style: TextStyle(color: Colors.white, fontSize: 30,),),
          ),
          ),
          body: SingleChildScrollView(
            child: Padding(
                         padding: const EdgeInsets.only(right:10,left:10,top: 25,bottom: 15),
                         child: Container(
                  // color: const Color.fromARGB(103, 255, 255, 255),
                  child: Container(
                    color: Colors.yellow[700],
                    child: Column(
                      children: [const Padding(padding: EdgeInsets.only(top: 20)),
                          Padding(
                            padding: const EdgeInsets.only(right: 20,left: 20),
                            child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container( 
                                  width: 150,height: 105,
                                  decoration: BoxDecoration(color: Colors.white,
                                                  image: DecorationImage(image: AssetImage("assets/images.jpeg")),
                                                  border: Border.all(color: const Color.fromARGB(246, 8, 8, 8),width: 1,),
                                                  shape: BoxShape.rectangle,  
                                              ),
                                  child: Column(crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Icon(Icons.add),
                                  ],
                                ),
                                ),
                              ],
                            ),
                          ),
                        
                        // const SizedBox(height: 20,),
                         
                      SizedBox(height: 15,),
    
                        Column(
                          children: [
                            Padding(padding: EdgeInsets.only(right: 20,left: 20),
                              child: TextField(
                                controller: _tcontr,
                                decoration: InputDecoration(
                                  fillColor: Colors.white,
                                  filled: true,
                                  labelText: "Title",
                                  labelStyle: TextStyle(fontSize: 20),
                                  border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),)
                                )       
                              ),
                            ),
                          ],
                        ),
                        
                        
                        const SizedBox(height: 15,),
                         
                         Padding(
                          padding: EdgeInsets.only(right: 20,left: 20),
                          child: TextField( 
                            controller: _tcontrll,
                            maxLines: 5,
                            keyboardType: TextInputType.multiline,
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Description",
                              hintMaxLines: null,
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),)
                            ) 
                          ),
                        ),
                        SizedBox(height: 15,),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(padding: EdgeInsets.only(left: 65,right: 65),
                              color: Colors.white,
                              child: DropdownButton<String>(
                                value: dropdownvalue,
                                dropdownColor: Colors.white,
                                icon: Padding(
                                  padding: const EdgeInsets.only(left:5),
                                  child: Icon(Icons.arrow_downward),
                                ),
                                
                                elevation: 16,
                                onChanged: (String? value) {
                                  setState(() {
                                    dropdownvalue = value!;
                                  });
                                },
                                  items: list.map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                              
                              ),
                            ),
                          ],
                        ),
                         
                          const SizedBox(height: 15,),
                         
                          Padding(
                          padding: EdgeInsets.only(right: 50,left: 50),
                          child: TextField( 
                            controller: timeInput,
                            decoration:InputDecoration(
                              labelText: "from time",
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                              ),
                              suffixIcon: IconButton(onPressed: (){
                                show();
                              }, icon:Icon(Icons.access_time),iconSize: 30,color:Colors. black,),
                              fillColor: Color.fromARGB(237, 255, 255, 255),
                              filled: true,
                            ) 
                          ),
                        ),
                         
                          const SizedBox(height: 15,),
                          Padding(
                          padding: EdgeInsets.only(right: 50,left: 50),
                          child: TextField( 
                            controller: timeInput1,
                            decoration:InputDecoration(
                              labelText: "To time",
                              labelStyle: TextStyle(fontSize: 20),
                              border: OutlineInputBorder(borderSide: BorderSide(color: Colors.black),
                              ),
                              suffixIcon: IconButton(onPressed: (){
                                show1();
                              }, icon:Icon(Icons.access_time),iconSize: 30,color:Colors. black,),
                              fillColor: Color.fromARGB(237, 255, 255, 255),
                              filled: true,
                            ) 
                          ),
                        ),
                          const SizedBox(height: 10,),
                    
                        
                        
                        const SizedBox(height: 20),
                         
                        Center(
                          child: ElevatedButton(onPressed: () {
                            // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                          // return  Dash(umail: umail,);}));
                                          insertData();
                          },
                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.white)), 
                          child: const Text("Submit",style: TextStyle(color: Colors.black, fontSize: 16),)),
                        ),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                         )),
          ),
    ));
  }
  insertData() async{
    List<Map> days =[];
    week.forEach((element) {days.add(element.toMap());});
    Map data ={"apiKey":"12341234",
    "functionName":"add_live_class1",
      "param":{
            "tId":widget.email,
            "lId":widget.liveid,
            "title":_tcontr.text,
            "descr":_tcontrll.text,
            "days":days
      }
    };
    var body = json.encode(data);
    var url = Uri.parse("https://taskswetha.000webhostapp.com//api.php");
    var response= await http.post(url, body:body);
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');
    if(response.statusCode==200)
    {
      setState(() {
             Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                   return Myclass(umail: widget.email);
              },));
      });
    }
  }
  Future<void>show()async{
    final TimeOfDay? result= await showTimePicker(context: context, initialTime: TimeOfDay.now(),
    builder: (context,child)
    {
      return MediaQuery(data:MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false) , child: child!);
    }
    );
    if(result!=null)
    {
      if(week.isEmpty)
      {week.add(DayTime("Monday", result,TimeOfDay.now()));}
      else{
        week[0].from_time=result;
      }
      setState(() {
        timeInput.text=result.format(context);
      });
    }
  }
 
    Future<void>show1()async{
    final TimeOfDay? result= await showTimePicker(context: context, initialTime: TimeOfDay.now(),
    builder: (context,child)
    {
      return MediaQuery(data:MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false) , child: child!);
    }
    );
    if(result!=null)
    {
      if(week.isEmpty)
      {week.add(DayTime("Monday", TimeOfDay.now(),result));}
      else{
        week[0].to_time=result;
      }
      setState(() {
        timeInput1.text=result.format(context);
      });
    }
  }
}

class DayTime{
  late String day;
  late TimeOfDay from_time;
  late TimeOfDay to_time;
 DayTime(this.day,this.from_time,this.to_time);
  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);  //"6:00 AM"
    return DateFormat("HH:mm:ss").format(dt);
}
 toMap (){
//  final localizations = MaterialLocalizations.of(context);
// final formattedTimeOfDay = localizations.formatTimeOfDay(timeOfDay);
  return{
    "day":day,
                "from_time":formatTimeOfDay(from_time),
                "to_time":formatTimeOfDay(to_time)
  };
 }
}