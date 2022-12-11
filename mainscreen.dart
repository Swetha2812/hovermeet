import 'package:flutter/material.dart';
import 'package:user/login.dart';
import 'package:user/register.dart';

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.yellow[700],
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 200,),
              const Text("HOVERMEET",style: TextStyle(fontSize: 45, color: Colors.black),),

              const SizedBox(height: 150,),
              
              ElevatedButton(onPressed: (() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return const MyLogin();
                                },));
              }),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),
              padding:MaterialStateProperty.all( const EdgeInsets.symmetric(horizontal: 107,vertical: 20))),
               child: const Text("LOGIN",style: TextStyle(color: Colors.black, fontSize: 18),)
              ),

              const SizedBox(height: 15,),

              ElevatedButton(onPressed: (() {
                  Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                                 return const MyRegister();
                                },));
              }),
              style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.white),
              padding:MaterialStateProperty.all( const EdgeInsets.symmetric(horizontal: 92,vertical: 20))),
               child: const Text("REGISTER", style: TextStyle(color: Colors.black, fontSize: 18),)
              ),
            ],
          ),
        ),
      ),
    );
  }
}