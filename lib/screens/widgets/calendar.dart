import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:smartcook/theme.dart';

class CalendarWidget extends StatefulWidget implements PreferredSizeWidget {
  final DateTime currentDate;
  final List<double> progress; // Lista de progreso

  const CalendarWidget(
      {Key? key, required this.currentDate, required this.progress})
      : super(key: key);

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();

  @override
  Size get preferredSize =>
      const Size.fromHeight(100); // Ajustar altura del widget
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int selectedDayIndex = 3; // El índice del día seleccionado

  final List<String> daysOfWeek = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

  @override
  Widget build(BuildContext context) {
    // Obtener el color principal de la app
    final primaryColor = Theme.of(context).primaryColor;
    // Obtener el ancho de la pantalla
    final screenWidth = MediaQuery.of(context).size.width;

    // Calcular el ancho de cada día para que se ajuste automáticamente
    double itemWidth = screenWidth / 7; // 7 días de la semana

    // Obtener la fecha actual
    final currentDate = widget.currentDate;
    final List<int> dates =
        List.generate(7, (index) => currentDate.day + index);

    return Column(
      children: [
        const SizedBox(height: 5),
        SizedBox(
          height: 70, // Altura ajustada
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: daysOfWeek.length,
            itemBuilder: (context, index) {
              bool isSelected = index == selectedDayIndex;
              return SizedBox(
                width: itemWidth, // Ajustamos el ancho de cada elemento
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      daysOfWeek[index],
                      style: TextStyle(
                        fontSize: 16,
                        color: isSelected ? primaryColor : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                        });
                      },
                      child: CircularPercentIndicator(
                        radius: 20.0, // Tamaño del círculo
                        lineWidth: 5.0, // Ancho del progreso
                        percent: widget.progress[index], // Progreso de cada día
                        center: Text(
                          dates[index].toString(),
                          style: TextStyle(
                            fontSize: 14,
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        progressColor:
                            isSelected ? primaryColor : Colors.grey.shade300,
                        backgroundColor: Colors.grey.shade200,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
