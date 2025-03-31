import 'package:flutter/material.dart';
import 'package:haritha_connect/components/Components.dart';
import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../service/Database.dart';


class EditEventScreen extends StatefulWidget {
  @override
  _EditEventScreenState createState() => _EditEventScreenState();
}

class _EditEventScreenState extends State<EditEventScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController  _EventController = TextEditingController();
  TextEditingController  _OrganizerController = TextEditingController();
  TextEditingController  _DescriptionController = TextEditingController();
  TextEditingController  _LocationController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  String  _eventType = "Workshop";

  Future<void> _selectDate(BuildContext context) async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null) {
      setState(() {
        _dateController.text = "${pickedDate.toLocal()}".split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null) {
      setState(() {
        _timeController.text = pickedTime.format(context);
      });
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: CurvedBackground(
              height: 150,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),   Row(
                    children: [
                      // Padding(
                      // padding: EdgeInsets.only(left: 20.0),
                      // child: IconButton(
                      IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                      ),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Text(
                          "Add Event",
                          style: Kheaderstyle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 130,
            left: 20,
            right: 20,
            bottom: 20, // Ensure it expands properly
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _EventController,
                        decoration: const InputDecoration(
                          labelText: "Event Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? "Please enter event name" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _OrganizerController,
                        decoration: const InputDecoration(
                          labelText: "Organizer Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? "Please enter organizer name" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _DescriptionController,
                        decoration: const InputDecoration(
                          labelText: "Event Description",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? "Please enter event description" : null,
                      ),
                      const SizedBox(height: 30),
                      TextFormField(
                        controller: _LocationController,
                        decoration: const InputDecoration(
                          labelText: "Event Location",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? "Please enter event location" : null,
                      ),
                      const SizedBox(height: 30),

                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _dateController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: "Event Date",
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              onTap: () => _selectDate(context),
                              validator: (value) => value!.isEmpty ? "Please select event date" : null,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: TextFormField(
                              controller: _timeController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                labelText: "Event Time",
                                border: OutlineInputBorder(),
                                suffixIcon: Icon(Icons.access_time),
                              ),
                              onTap: () => _selectTime(context),
                              validator: (value) => value!.isEmpty ? "Please select event time" : null,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 30),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _eventType = "Workshop";
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: _eventType == "Workshop" ? Colors.blue : Colors.transparent,
                              side: BorderSide(color: _eventType == "Workshop" ? Colors.blue : Colors.black),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            child: Text(
                              "Workshop",
                              style: TextStyle(color: _eventType == "Workshop" ? Colors.white : Colors.black),
                            ),
                          ),
                          SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                _eventType = "Event";
                              });
                            },
                            style: OutlinedButton.styleFrom(
                              backgroundColor: _eventType == "Event" ? Colors.blue : Colors.transparent,
                              side: BorderSide(color: _eventType == "Event" ? Colors.blue : Colors.black),
                              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            ),
                            child: Text(
                              "Event",
                              style: TextStyle(color: _eventType == "Event" ? Colors.white : Colors.black),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async{
                            String id = randomAlphaNumeric(10);
                            Map<String,dynamic> addEventMap = {

                              "id": id,
                              "EventName": _EventController.text,
                              "OrganizerName": _OrganizerController.text,
                              "EventDescription": _DescriptionController.text,
                              "EventLocation": _LocationController.text,
                              "EventType": _eventType,
                            };

                            await  DatabaseMethods().addEvent(addEventMap,id).then((value) {
                              Fluttertoast.showToast(
                                  msg: "Event added successfully",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );});

                            _dateController.clear();
                            _timeController.clear();
                            _EventController.clear();
                            _OrganizerController.clear();
                            _DescriptionController.clear();
                            _LocationController.clear();

                          },
                          child: Text("Submit Event"),
                        ),
                      ),

                      const SizedBox(height: 50), // Extra spacing at the bottom
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
