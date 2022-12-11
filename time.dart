import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: DateTime(),
  ));
}
class DateTime extends StatefulWidget {
  const DateTime({Key? key}) : super(key: key);

  @override
  State<DateTime> createState() => _DateTimeState();
}

class _DateTimeState extends State<DateTime> {
String? selectTime;
TextEditingController timeInput= TextEditingController();
  @override
  void initState(){
    timeInput.text="";
    super.initState();
  }
  Widget build(BuildContext context) {
  return Scaffold(
    body: Center(
      child: Column(children: [
          Text(timeInput.text, 
          style: const TextStyle(fontSize: 25),
          ),
          ElevatedButton(onPressed: ((
          ) {
            show();
          }), child: Text('time pick'))
      ]
      ),
      
    ),

  );
  
  
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
      setState(() {
        timeInput.text=result.format(context);
      });
    }
  }
  }
