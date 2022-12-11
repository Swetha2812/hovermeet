import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Notify(),
  ));
}

class Notify extends StatefulWidget {
  const Notify({Key? key}) : super(key: key);

  @override
  State<Notify> createState() => _NotifyState();
}

class _NotifyState extends State<Notify> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromARGB(255, 241, 194, 177),
      child:Scaffold(
      backgroundColor: Colors.transparent,
       appBar: AppBar(
        backgroundColor: Colors.transparent,
        title:const Center(
          child: Text("Notifications", style: TextStyle(color: Colors.black, fontSize: 30,),)
        ),
      ),
      body:Column(
        children: [
          Center(
            child: Container(
              padding: const EdgeInsets.only(top:15,left:15,bottom: 15), 
              color: Color.fromARGB(103, 255, 255, 255),
                          child: Column(
                            children: [
                              Row( 
                                children: [
                                  Container(
                                    width: 150,
                                    height: 105,
                                    decoration:  BoxDecoration(
                                      border: Border.all(
                                        color:  Colors.black ,
                                        width: 1,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                 ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Title :    \n\n Date & Time :   \n\n Teacher :",style: TextStyle(fontSize:18)),
                                  )
                                ],
                              ),
                           ],
                         ),
                        ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top:15,left:15,bottom: 15), 
              color: Color.fromARGB(103, 255, 255, 255),
                          child: Column(
                            children: [
                              Row( 
                                children: [
                                  Container(
                                    width: 150,
                                    height: 105,
                                    decoration:  BoxDecoration(
                                      border: Border.all(
                                        color:  Colors.black ,
                                        width: 1,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                 ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Title :    \n\n Date & Time :   \n\n Teacher :",style: TextStyle(fontSize:18)),
                                  )
                                ],
                              ),
                           ],
                         ),
                        ),
          ),
          SizedBox(height: 10,),
          Center(
            child: Container(
              padding: const EdgeInsets.only(top:15,left:15,bottom: 15), 
              color: Color.fromARGB(103, 255, 255, 255),
                          child: Column(
                            children: [
                              Row( 
                                children: [
                                  Container(
                                    width: 150,
                                    height: 105,
                                    decoration:  BoxDecoration(
                                      border: Border.all(
                                        color:  Colors.black ,
                                        width: 1,
                                      ),
                                      shape: BoxShape.rectangle,
                                    ),
                                 ),
                                  const Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Text("Title :    \n\n Date & Time :    \n\n Teacher:",style: TextStyle(fontSize:18)),
                                  )
                                ],
                              ),
                           ],
                         ),
                        ),
          ),
        ],
      ),
                  
      )
    );
  }
}