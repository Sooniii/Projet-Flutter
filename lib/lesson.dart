// ignore_for_file: constant_identifier_names

import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'db/mongo_dart.dart';


class RidingLesson extends StatefulWidget {
  const RidingLesson({super.key, required this.title});

  final String title;

  @override
  State<RidingLesson> createState() => _RidingLesson();
}

class _RidingLesson extends State<RidingLesson> {

  final List<Card> _counter = [];
  final List<String> listDiscipline = <String>['Dressage', 'Saut Obstable', 'Endurance'];
  String dropDownValueDiscipline = "Dressage";
  final List<String> listPlace = <String>['Manege', 'Carriere'];
  String dropDownValuePlace = "Manege";
  final List<String> listTime = <String>['1 heure', '30 mins'];
  String dropDownValueTime = "1";
  late String _hour, _minute, _time;
  late String dateTime;
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  TextEditingController place = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null) {
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = '$_hour : $_minute';
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
    }
  }

  Future<void> _insertData(String dateTime, String dayTime, String place, String discipline, String duration) async {
    try {
      var id = M.ObjectId();
      var data =
      ({
        "_id": id,
        "dateTime": _dateController.text,
        "dayTime": _timeController.text,
        "place": dropDownValuePlace,
        "discipline": dropDownValueDiscipline,
        "duration": dropDownValueTime,
      });
      await MongoDatabase.insertRidingLessons(data);
    // ignore: empty_catches
    } catch (e) {
  }
  }

  void _incrementCounter(name, discipline, duration, date, time) {
    setState(() {

      _counter.add(Card(
        elevation: 8.0,
        child: SizedBox(
          width: 300,
          child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(dropDownValuePlace),
                ),
                ListTile(
                  title: Text(dropDownValueDiscipline),
                ),
                ListTile(
                  title: Text(dropDownValueTime),
                ),
                ListTile(
                    title: Text(date),
                ),
                ListTile(
                  title: Text(time),
                )
              ]
          ),
        ),
      ));
    });
  }


  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    _dateController.dispose();
    _timeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(

        child: ListView.builder(
          itemCount: _counter.length,
          itemBuilder: (context, index) {
            return _counter[index];
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showDialog,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), //
    );
  }
  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return StatefulBuilder(builder: (context, setState){

          return AlertDialog(
            title: const Text("Ajouter une lesson"),
            actions: <Widget>[
              DropdownButton(
                style: const TextStyle(color: Colors.blue),
                items: listPlace.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: dropDownValuePlace,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newvalue) {
                  setState((){
                    dropDownValuePlace = newvalue!;
                  });
                },
              ),

              DropdownButton(
                style: const TextStyle(color: Colors.blue),
                items: listDiscipline.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: dropDownValueDiscipline,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newvalue) {
                  setState((){
                    dropDownValueDiscipline = newvalue!;
                  });
                },),

              DropdownButton<String>(

                style: const TextStyle(color: Colors.blue),
                onChanged: (String? newvalueTime) {
                  setState((){
                    dropDownValueTime = newvalueTime!;
                  });
                },
                items: listTime.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                value: listTime.first, // guard it with null if empty


              ),

              InkWell(
                onTap: () {
                  _selectDate(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,
                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _dateController,

                    decoration: const InputDecoration(
                        disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.only(top: 0.0)),
                  ),
                ),
              ),
              InkWell(
                onTap: () {
                  _selectTime(context);
                },
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  child: TextFormField(
                    style: const TextStyle(fontSize: 40),
                    textAlign: TextAlign.center,

                    enabled: false,
                    keyboardType: TextInputType.text,
                    controller: _timeController,
                    decoration: const InputDecoration(
                        disabledBorder:
                        UnderlineInputBorder(borderSide: BorderSide.none),
                        // labelText: 'Time',
                        contentPadding: EdgeInsets.all(5)),
                  ),
                ),
              ),

              TextButton(
                onPressed: () {
                  _incrementCounter(listDiscipline.toString(), listDiscipline.toString(), listTime.toString(), _dateController.text, _timeController.text);
                  _insertData(
                    listPlace.toString(),
                    _dateController.text,
                    _timeController.text,
                    listDiscipline.toString(),
                    listTime.toString(),
                  );
                  Navigator.of(context).pop();
                  const snackBar = SnackBar(
                    content: Text('People Added!'),
                  );

                  // Find the ScaffoldMessenger in the widget tree
                  // and use it to show a SnackBar.
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
                child: const Text("Valider"),
              )

              // usually buttons at the bottom of the dialog
            ],
          );
        });
      },
    );
  }

}