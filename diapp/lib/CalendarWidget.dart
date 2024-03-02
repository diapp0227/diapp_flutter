import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

class CalenderWidget extends StatelessWidget {
  const CalenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const CalenderPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class CalenderPage extends StatefulWidget {
  const CalenderPage({super.key, required this.title});
  final String title;

  @override
  State<CalenderPage> createState() => _CalenderPageState();
}

class _CalenderPageState extends State<CalenderPage> {
  DateTime _focusedDay = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            TableCalendar(
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              firstDay: DateTime.utc(2023, 1, 15),
              lastDay: DateTime.utc(2024, 12, 31),
              focusedDay: _focusedDay,
              calendarFormat: CalendarFormat.month,
            ),
          ],
        ),
      ),
    );
  }
}