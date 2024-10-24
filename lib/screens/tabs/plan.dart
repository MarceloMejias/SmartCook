import 'package:flutter/material.dart';
import 'package:smartcook/screens/widgets/calendar.dart';

class PlanScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plan'),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Column(
        children: [
          CalendarWidget(
            currentDate: DateTime.now(),
            progress: const [
              0.3,
              0.6,
              0.9,
              0.5,
              0.7,
              0.2,
              1.0
            ], // Ejemplo de progreso
          ),
        ],
      ),
    );
  }
}
