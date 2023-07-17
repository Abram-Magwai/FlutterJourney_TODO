// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo/pages/tasks.dart';

import '../components/text_form_field_decoration.dart';
import '../components/text_form_field_validator.dart';
import '../components/todo_button.dart';

class CreateTask extends StatefulWidget {
  const CreateTask({super.key});

  @override
  State<CreateTask> createState() => _CreateTaskState();
}

class _CreateTaskState extends State<CreateTask> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _startController = TextEditingController();
  final TextEditingController _endController = TextEditingController();

  late String _taskName;
  late String _taskDescription;
  late String _date;
  late String _start;
  late String _end;

  DateTime selectedDate = DateTime.now();
  Priority _selectedPriority = Priority.low;

  bool _decideWhichDayToEnable(DateTime day) {
    if ((day.isAfter(DateTime.now().subtract(const Duration(days: 1))) &&
        day.isBefore(DateTime.now().add(const Duration(days: 7))))) {
      return true;
    }
    return false;
  }

  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2025),
        selectableDayPredicate: _decideWhichDayToEnable,
        helpText: 'Select task date', // Can be used as title
        cancelText: 'Not now',
        confirmText: 'Pick',
        builder: (context, child) {
          return Theme(
            data: ThemeData.dark(), // This will change to light theme.
            child: child!,
          );
        });
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  TimeOfDay? selectedStartTime;
  TimeOfDay? selectedEndTime;

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedStartTime) {
      setState(() {
        selectedStartTime = pickedTime;
        _startController.text = formatTime(selectedStartTime!);
      });
    }
  }
Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (pickedTime != null && pickedTime != selectedStartTime) {
      setState(() {
        selectedEndTime = pickedTime;
        _endController.text = formatTime(selectedEndTime!);
      });
    }
  }
  String formatTime(TimeOfDay timeOfDay) {
    String period = timeOfDay.period == DayPeriod.am ? 'AM' : 'PM';
    int hour = timeOfDay.hourOfPeriod;
    int minute = timeOfDay.minute;
    return '$hour:${minute.toString().padLeft(2, '0')} $period';
  }
  bool isBefore(TimeOfDay time1, TimeOfDay time2) {
    final DateTime dateTime1 = DateTime(0, 0, 0, time1.hour, time1.minute);
    final DateTime dateTime2 = DateTime(0, 0, 0, time2.hour, time2.minute);
    return dateTime1.compareTo(dateTime2) < 0;
  }
  String? _validateEndTime() {
    if (selectedStartTime != null && selectedEndTime != null) {
      if (isBefore(selectedEndTime!, selectedStartTime!)) {
        return 'End time must be after';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/tasks': (context) => const Tasks(),
        },
        home: Builder(builder: (context) {
          return Scaffold(
              backgroundColor: const Color.fromARGB(255, 236, 236, 236),
              body: Stack(children: [
                Positioned(
                  left: -100,
                  top: -100,
                  child: Container(
                    width: 200.0,
                    height: 200.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color.fromARGB(99, 83, 116, 95),
                    ),
                  ),
                ),
                Positioned(
                    top: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_circle_left_outlined,
                        size: 35,
                      ),
                      onPressed: () {
                        Navigator.popAndPushNamed(context, '/tasks');
                      },
                    )),
                Positioned(
                    left: -20,
                    top: -150,
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(99, 83, 116, 95),
                      ),
                    )),
                Container(
                    margin: const EdgeInsets.only(top: 150),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Center(
                        child: ListView(children: [
                      const Center(
                        child: Text('Create your Task!',
                            style: TextStyle(
                                fontWeight: FontWeight.w500, fontSize: 20)),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 120,
                        child: Image.asset(
                          'assets/images/3.png',
                          width: 20,
                        ),
                      ),
                      Container(
                          margin: const EdgeInsets.only(top: 50),
                          child: Form(
                              key: _formKey,
                              child: Column(children: [
                                TextFormField(
                                  decoration: textFormFieldDecoration(
                                      'Enter your Task'),
                                  validator: textFormFieldValidator(
                                      'Please enter your task'),
                                  onSaved: (value) {
                                    _taskName = value!;
                                  },
                                ),
                                const SizedBox(height: 20,),
                                TextFormField(
                                  decoration: textFormFieldDecoration(
                                      'Enter Task Description'),
                                  validator: textFormFieldValidator(
                                      'Please enter task description'),
                                  onSaved: (value) {
                                    _taskDescription = value!;
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                TextFormField(
                                  controller: _dateController,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: const EdgeInsets.all(12.0),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide.none,
                                    ),
                                    labelText: 'Select Date',
                                    suffixIcon: IconButton(
                                      icon: const Icon(Icons.calendar_today),
                                      onPressed: () {
                                        _selectDate(context);
                                      },
                                    ),
                                  ),
                                  validator:
                                      textFormFieldValidator('Please set date'),
                                  onSaved: (value) {
                                    _date = value!;
                                  },
                                  readOnly: true,
                                  onTap: () {
                                    _selectDate(context);
                                  },
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(right: 4),
                                        child: TextFormField(
                                          controller: _startController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            labelText: 'Start Time',
                                            suffixIcon: IconButton(
                                              icon:
                                                  const Icon(Icons.lock_clock),
                                              onPressed: () {
                                                _selectStartTime(context);
                                              },
                                            ),
                                          ),
                                          validator: textFormFieldValidator(
                                              'Please set start time'),
                                          onSaved: (value) {
                                            _start = value!;
                                          },
                                          readOnly: true,
                                          onTap: () {
                                            _selectStartTime(context);
                                          },
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        margin: const EdgeInsets.only(left: 4),
                                        child: TextFormField(
                                          controller: _endController,
                                          decoration: InputDecoration(
                                            filled: true,
                                            fillColor: Colors.white,
                                            contentPadding:
                                                const EdgeInsets.all(12.0),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              borderSide: BorderSide.none,
                                            ),
                                            labelText: 'End Time',
                                            suffixIcon: IconButton(
                                              icon:
                                                  const Icon(Icons.lock_clock),
                                              onPressed: () {
                                                _selectEndTime(context);
                                              },
                                            ),
                                          ),
                                          validator: (value) => _validateEndTime(),
                                          onSaved: (value) {
                                            _end = value!;
                                          },
                                          readOnly: true,
                                          onTap: () {
                                            _selectEndTime(context);
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const SizedBox(height: 20.0),
                                const Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Task Priority',
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton<Priority>(
                                            isExpanded: true,
                                            dropdownColor: Colors.white,
                                            value: _selectedPriority,
                                            onChanged: (Priority? newValue) {
                                              setState(() {
                                                _selectedPriority = newValue!;
                                              });
                                            },
                                            items: Priority.values
                                                .map((Priority priority) {
                                              return DropdownMenuItem<Priority>(
                                                value: priority,
                                                child: Row(
                                                  children: [
                                                    Icon(
                                                      getPriorityIcon(priority),
                                                      color: getPriorityColor(
                                                          priority),
                                                    ),
                                                    const SizedBox(width: 10.0),
                                                    Text(getPriorityText(
                                                        priority)),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Flex(direction: Axis.horizontal, children: [
                                  Expanded(
                                      child: todoButton(() {
                                    if (_formKey.currentState!.validate()) {
                                      _formKey.currentState!.save();
                                      print(_taskName);
                                      print(_taskDescription);
                                      print(_date);
                                      print(_start);
                                      print(_end);
                                      Navigator.pushNamed(context, '/tasks');
                                    }
                                  }, 'Create Task'))
                                ]),
                              ])))
                    ])))
              ]));
        }));
  }

  IconData getPriorityIcon(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Icons.arrow_downward;
      case Priority.medium:
        return Icons.arrow_right;
      case Priority.high:
        return Icons.arrow_upward;
    }
  }

  Color getPriorityColor(Priority priority) {
    switch (priority) {
      case Priority.low:
        return Colors.green;
      case Priority.medium:
        return Colors.blue;
      case Priority.high:
        return Colors.red;
    }
  }

  String getPriorityText(Priority priority) {
    switch (priority) {
      case Priority.low:
        return 'Low';
      case Priority.medium:
        return 'Medium';
      case Priority.high:
        return 'High';
    }
  }
}

enum Priority { low, medium, high }
