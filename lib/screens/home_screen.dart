import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/calendar_widget.dart';
import '../widgets/add_med_button.dart';
import '../widgets/bottom_nav_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(),
      body: Column(
        children: [
          const CalendarWidget(),
          const Spacer(),
          const AddMedButton(),
        ],
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
  }
}
