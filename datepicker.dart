// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/src/foundation/key.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:syncfusion_flutter_datepicker/datepicker.dart';

// void main(){
//    runApp(const MaterialApp(
//     debugShowCheckedModeBanner: false,
//     home: Datepicker(),
//   ));
// }

// class Datepicker extends StatefulWidget {
//   const Datepicker({Key? key}) : super(key: key);

//   @override
//   State<Datepicker> createState() => _DatepickerState();
// }

// class _DatepickerState extends State<Datepicker> {
//   String? selectDate;
//   DateRangePickerController _pickerController = DateRangePickerController(); 
//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(child: Scaffold(
//       body: SfDateRangePicker(
//         view: DateRangePickerView.month,
//         monthViewSettings: DateRangePickerMonthViewSettings(firstDayOfWeek: 1),
//         selectionMode: DateRangePickerSelectionMode.single,
//         showActionButtons: true,
//         controller: _pickerController,

//         // onSubmit: (Object val){
//         //   print(val);
//         // },
//         onCancel: (){
//           _pickerController.selectedRanges = null;
//         },
//       ),

//     ));
    
//   }
// }