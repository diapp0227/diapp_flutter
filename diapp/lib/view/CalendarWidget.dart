import 'dart:collection';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/OnMemory.dart';
import '../model/data/Diary.dart';

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});

  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  String _memo = "";
  final formatter = DateFormat('yyyy-MM-dd');
  OnMemory _onMemory = OnMemory();

  // 選択した日付の表示用文字列
  String selectedDateTimeString() {
    DateTime? dateTime = _selectedDay;
    if (dateTime == null) {
      return "";
    }
    return formatter.format(dateTime);
  }

  // 枠線設定
  // - 引数に枠線の長さ
  BorderSide commonBorderSide(double width) {
    return BorderSide(color: Colors.black, width: width //枠線の太さ
        );
  }

  // カレンダー各日付の設定
  AnimatedContainer calendarBuilders(DateTime day, CalendarRowType type) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 360),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: getCalendarBoxColor(type),
        border: Border(
          top: commonBorderSide(0.5),
          bottom: commonBorderSide(0.5),
        ),
      ),
      child: Text(
        day.day.toString(),
        style: TextStyle(
          fontSize: 18,
          color: Colors.black,
        ),
      ),
    );
  }

  // カレンダー各日付の背景色を取得
  Color getCalendarBoxColor(CalendarRowType type) {
    switch (type) {
      case CalendarRowType.selected:
        return Colors.lightGreen;
      case CalendarRowType.outside:
        return Colors.white;
    }
  }

  updateDiaryData() {
    print("updateDiaryData()");
    DateTime? dateTime = _selectedDay;
    if (dateTime == null) {
      reloadViewData(null);
      return;
    }

    _onMemory.getDiary(selectedDateTimeString()).then((value) {
      reloadViewData(value);
    }) ;
  }

  reloadViewData(Diary? diary) {
    _memo = diary?.memo ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text("カレンダー"),
      ),
      body: Column(
        children: <Widget>[
          TableCalendar<dynamic>(
            headerStyle: HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
            ),
            firstDay: DateTime.utc(2023, 1, 15),
            lastDay: DateTime.utc(2024, 12, 31),
            focusedDay: _focusedDay,
            calendarFormat: CalendarFormat.week,
            selectedDayPredicate: (day) {
              return isSameDay(_selectedDay, day);
            },
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
                // カレンダー情報を画面更新
                updateDiaryData();
              });
            },
            onPageChanged: (focusedDay) {
              setState(() {
                _focusedDay = focusedDay;
              });
            },
            daysOfWeekHeight: 30,
            daysOfWeekStyle: DaysOfWeekStyle(
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(
                    color: Colors.black,
                    width: 0.5, //枠線の太さ
                  ),
                ),
              ),
              weekdayStyle: TextStyle(color: Colors.black38),
              weekendStyle: TextStyle(color: Colors.red),
            ),
            calendarBuilders: CalendarBuilders(defaultBuilder:
                (BuildContext context, DateTime day, DateTime focusedDay) {
              return calendarBuilders(day, CalendarRowType.outside);
            }, todayBuilder:
                (BuildContext context, DateTime day, DateTime focusedDay) {
              return calendarBuilders(day, CalendarRowType.outside);
            }, outsideBuilder:
                (BuildContext context, DateTime day, DateTime focusedDay) {
              return calendarBuilders(day, CalendarRowType.outside);
            }, selectedBuilder:
                (BuildContext context, DateTime day, DateTime focusedDay) {
              return calendarBuilders(day, CalendarRowType.selected);
            }),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              decoration: BoxDecoration(
                  border: Border(
                top: commonBorderSide(0.5),
                bottom: commonBorderSide(0.5),
              )),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.calendar_month_outlined)
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      selectedDateTimeString(),
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              )
          ),
          SizedBox(
            height: 20,
          ),

          Container(
              decoration: BoxDecoration(
                  border: Border(
                    top: commonBorderSide(0.5),
                    bottom: commonBorderSide(0.5),
                  )),
              child: Row(
                children: [
                  SizedBox(
                    width: 20,
                  ),
                  Container(
                      width: 30,
                      height: 30,
                      child: Icon(Icons.calendar_month_outlined)
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      _memo,
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 30,
                      ),
                    ),
                  ),
                ],
              )
          ),

        ],
      ),
    );
  }
}

enum CalendarRowType {
  // 選択中
  selected,
  // 選択外
  outside
}