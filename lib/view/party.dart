
import 'package:flutter/material.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import '../db/mongo_dart.dart';

class Party extends StatefulWidget {
  const Party({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<Party> createState() => _PartyState();
}

class _PartyState extends State<Party> {

  final List<Card> _counter = [];
  late String _hour, _minute, _time;
  late String dateTime;
  late DateTime selectedDate = DateTime.now();
  late TimeOfDay selectedTime = const TimeOfDay(hour: 00, minute: 00);
  TextEditingController nameController = TextEditingController();
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

  Future<void> _insertData(String name, String dateTime, String dayTime) async {
    try {
      var id = M.ObjectId();
      var data =
      ({
        "_id": id,
        "name": nameController.text,
        "dateTime": _dateController.text,
        "dayTime": _timeController.text,
      });
      await MongoDatabase.insertOneParty(data);
      // ignore: empty_catches
    } catch (e) {
    }
  }


  void _incrementCounter(name, date, time) {
    setState(() {
      _counter.add(Card(
        elevation: 8.0,
        child: SizedBox(
          width: 300,
          child: Column(
              children: <Widget>[
                ListTile(
                  title: Text(name),
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
    nameController.dispose();
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
            content: Text("Are You Sure Want To Proceed?"),
            actions: <Widget>[
              TextField(
                controller: nameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Name',
                ),
              ),

            // InkWell(),

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
                  _incrementCounter(nameController.text, _dateController.text, _timeController.text);
                  _insertData(
                    nameController.text,
                    _dateController.text,
                    _timeController.text,
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
