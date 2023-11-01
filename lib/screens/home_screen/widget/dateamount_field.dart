import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:roomexps/provider/home_provider/home_provider.dart';

class DateAmountForm extends StatefulWidget {
  const DateAmountForm({super.key});

  @override
  _DateAmountFormState createState() => _DateAmountFormState();
}

class _DateAmountFormState extends State<DateAmountForm> {
  DateTime? selectedDate;

  String selectedDateString = "";
  var dateFormat = DateFormat('dd/MM/yyyy');

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        print('Arshad');
        DateFormat('dd/MM/yyyy');
        selectedDateString = dateFormat.format(selectedDate!);
        print(selectedDate);
        print(selectedDateString);
        Provider.of<HomeProvider>(context, listen: false).selectedDateString = selectedDateString;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Date',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
                  onTap: (){
                    _selectDate(context);
                  },
                  readOnly: true,
                  controller: TextEditingController(
                    text: selectedDateString != ""
                        ? selectedDateString
                        : '',
                  ),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue[50],
                    // hintText: 'Select date',
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     color: Colors.white,
                    //     width: 1.0,
                    //   ),
                    // ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Amount',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              Expanded(
                flex: 3,
                child: TextFormField(
                  controller: Provider.of<HomeProvider>(context, listen: false).selectedAmountCon,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.blue[50],
                    hintText: 'Enter amount',
                    // border: OutlineInputBorder(
                    //   borderSide: BorderSide(
                    //     color: Colors.white,
                    //     width: 0.0,
                    //   ),
                    // ),
                    contentPadding: EdgeInsets.symmetric(horizontal: 10),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}