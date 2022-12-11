import 'package:flutter/material.dart';

// void main(){
//   runApp(MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home:  ForgotPass(),
//   ));
// }

class ForgotPass extends StatefulWidget {
  const ForgotPass({Key? key}) : super(key: key);

  @override
  State<ForgotPass> createState() => _ForgotPassState();
}

class _ForgotPassState extends State<ForgotPass> {

final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();
  final TextEditingController _fieldFive = TextEditingController();

  String? _otp;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        color: Colors.yellow[700],
        child: Scaffold(
          backgroundColor:Colors.transparent,
        body: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.only(top: 125,left: 10,right: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height:50 ,),
                  const Text(
                     'OTP Verification',
                    style: TextStyle(fontSize: 25,color: Colors.black),
                  ),SizedBox(height: 100,),
                  // const Text('send to registered email id',style: TextStyle(fontSize:20,color: Colors.black),),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      OtpInput(_fieldOne, true),
                      OtpInput(_fieldTwo, false),
                      OtpInput(_fieldThree, false),
                      OtpInput(_fieldFour, false),
                      OtpInput(_fieldFive, false)
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Padding(
                           padding: const EdgeInsets.only(left:230),
                           child:  TextButton(onPressed: () {  
                           },child:const Text('Resend OTP? ',style: TextStyle(fontSize: 16,color: Colors.black,),)),
                         ),
                         SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: () {
                        // setState(() {
                        //   _otp = _fieldOne.text +
                        //       _fieldTwo.text +
                        //       _fieldThree.text +
                        //       _fieldFour.text;
                        // });
                      // Navigator.of(context).push(MaterialPageRoute(builder: (ctx){
                      //   return const Mychange();
                      // }));
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Colors.black),
                      padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal:30,vertical: 15))),
                      child: const Text('SUBMIT')),
                         
                  const SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      )),
    );
  }
}
class OtpInput extends StatelessWidget {
  final TextEditingController controller;
  final bool autoFocus;
  const OtpInput(this.controller, this.autoFocus, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        autofocus: autoFocus,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        controller: controller,
        maxLength: 1,
        cursorColor: Theme.of(context).primaryColor,
        decoration: const InputDecoration(
            border: OutlineInputBorder(),
            enabledBorder: OutlineInputBorder(borderSide:BorderSide(color: Colors.black) ),
            counterText: '',
            fillColor: Colors.white,filled: true,),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
    
  }
}