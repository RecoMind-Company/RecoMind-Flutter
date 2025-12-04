import 'package:flutter/material.dart';


class Tabbar extends StatelessWidget {
  const Tabbar({super.key});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      dividerColor: Color(0xFF474747),
      indicatorColor: Colors.blue,
      indicatorWeight: 2.0,
      labelColor: Colors.white,
      unselectedLabelColor: Colors.grey,
      labelStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.normal,
      ),
      indicatorSize: TabBarIndicatorSize.label,
      // هذه هي الخاصية التي تزيد المسافة بين التبويبات
      // labelPadding: EdgeInsets.symmetric(horizontal: 30.0),
      tabs: [
        Tab(text: '   Management   '),
        Tab(text: '   Departments   '),
      ],
    );
  }
}
