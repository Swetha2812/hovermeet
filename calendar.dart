
// import 'package:intl/intl.dart';
// import 'package:flutter/material.dart';

// void main() => runApp(const MyApp());

// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);

//   static const String _title = 'Flutter Code Sample';

//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       restorationScopeId: 'app',
//       title: _title,
//       home: MyStatefulWidget(),
//     );
//   }
// }

// class MyStatefulWidget extends StatefulWidget {
//   const MyStatefulWidget({Key? key}) : super(key: key);
  

//   //final String? restorationId;

//   @override
//   State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
// }

// /// RestorationProperty objects can be used because of RestorationMixin.
// class _MyStatefulWidgetState extends State<MyStatefulWidget>{
//   // In this example, the restoration ID for the mixin is passed in through
//   // the [StatefulWidget]'s constructor.
//   @override
//   //String? get restorationId => widget.restorationId;

//   // final RestorableDateTime _selectedDate =
//   //     RestorableDateTime(DateTime(2021, 7, 25));
//   // late final RestorableRouteFuture<DateTime?> _restorableDatePickerRouteFuture =
//   //     RestorableRouteFuture<DateTime?>(
//   //   onComplete: _selectDate,
//   //   onPresent: (NavigatorState navigator, Object? arguments) {
//   //     return navigator.restorablePush(
//   //       _datePickerRoute,
//   //       arguments: _selectedDate.value.millisecondsSinceEpoch,
//   //     );
//   //   },
//   // );

//   // static Route<DateTime> _datePickerRoute(
//   //   BuildContext context,
//   //   Object? arguments,
//   // ) {
//   //   return 
//   TextEditingController dateInput=TextEditingController();
//   @override
//   void initState(){
//     dateInput.text="";
//     super.initState();
//   }
//   // void restoreState(RestorationBucket? oldBucket, bool initialRestore) {
//   //   registerForRestoration(_selectedDate, 'selected_date');
//   //   registerForRestoration(
//   //       _restorableDatePickerRouteFuture, 'date_picker_route_future');
//   // }

//   // void _selectDate(DateTime? newSelectedDate) {
//   //   if (newSelectedDate != null) {
//   //     setState(() {
//   //       _selectedDate.value = newSelectedDate;
//   //       ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//   //         content: Text(
//   //             'Selected: ${_selectedDate.value.day}/${_selectedDate.value.month}/${_selectedDate.value.year}'),
//   //       ));
//   //     });
//   //   }
//   // }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: TextField(
//           controller: dateInput,
//           decoration: InputDecoration(icon: Icon(Icons.calendar_today),labelText: "Enter Date"),
//           readOnly: true,
//           onTap: ()async{
//             DateTime?pickedDate=await showDatePicker(context: context, initialDate: DateTime.now(), 
//             firstDate: DateTime(2022), lastDate: DateTime(2030));
//             if (pickedDate!=null)
//             {
//               print (pickedDate);
//               String formattedDate=DateFormat('yyyy-mm-dd').format(pickedDate);
//               print (formattedDate);
              
//               setState(() {
//                 dateInput.text=formattedDate;
//                 print(dateInput.text);
//               });           
//                }else{}
//           },
          
//         ),
//       ),
//     );
//   }
//  // ignore: non_constant_identifier_names
//  DialogRout()async {
//      DatePickerDialog(
//           restorationId: 'date_picker_dialog',
//           initialEntryMode: DatePickerEntryMode.calendarOnly,
//           initialDate: DateTime(2022),
//           firstDate: DateTime(2021),
//           lastDate: DateTime(2034),
//     );

//   }
// }
