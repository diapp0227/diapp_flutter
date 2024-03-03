import 'package:diapp/view/CalendarWidget.dart';
import 'package:diapp/view/SettingWidget.dart';
import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: getBody(_currentIndex),
        bottomNavigationBar: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: _onTabTapped,
            items: getAllBottomNavigationBarItem()));
  }

  int _currentIndex = 0;

  // タブバータップ時のアクション
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  // タブバータップ時のインデックスをenumの値に変換する
  TabType parseIntToTabType(int index) {
    return TabType.values.firstWhere((element) => element.index == index);
  }

  // 選択したタブに対応したWidgetを取得
  Widget getBody(int index) {
    switch (parseIntToTabType(index)) {
      case TabType.Calendar:
        return CalendarPage();
      case TabType.Report:
        return SizedBox();
      case TabType.Settings:
        return SettingPage();
    }
  }

  List<BottomNavigationBarItem> getAllBottomNavigationBarItem() {
    return [
      TabType.Calendar.getBottomNavigationBarItem(),
      TabType.Report.getBottomNavigationBarItem(),
      TabType.Settings.getBottomNavigationBarItem()
    ];
  }
}

enum TabType {
  Calendar,
  Report,
  Settings;

  int toInt() {
    switch (this) {
      case TabType.Calendar:
        return 0;
      case TabType.Report:
        return 1;
      case TabType.Settings:
        return 2;
    }
  }

  Widget getIcon() {
    switch (this) {
      case TabType.Calendar:
        return Icon(Icons.calendar_month);
      case TabType.Report:
        return Icon(Icons.menu_book);
      case TabType.Settings:
        return Icon(Icons.settings);
    }
  }

  Widget getActiveIcon() {
    switch (this) {
      case TabType.Calendar:
        return Icon(Icons.calendar_month_outlined);
      case TabType.Report:
        return Icon(Icons.menu_book_outlined);
      case TabType.Settings:
        return Icon(Icons.settings_sharp);
    }
  }

  String getLabel() {
    switch (this) {
      case TabType.Calendar:
        return "カレンダー";
      case TabType.Report:
        return "分析";
      case TabType.Settings:
        return "設定";
    }
  }

  BottomNavigationBarItem getBottomNavigationBarItem() {
    return BottomNavigationBarItem(
      icon: this.getIcon(),
      activeIcon: this.getActiveIcon(),
      label: "",
      backgroundColor: Colors.blue,
    );
  }
}
