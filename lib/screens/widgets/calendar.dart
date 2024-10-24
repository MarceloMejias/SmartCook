import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class CalendarWidget extends StatefulWidget implements PreferredSizeWidget {
  final DateTime currentDate;
  final List<double> progress;
  final Function(DateTime) onDateChanged; // Callback para cambiar la fecha

  const CalendarWidget({
    super.key,
    required this.currentDate,
    required this.progress,
    required this.onDateChanged, // Recibir el callback
  });

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();

  @override
  Size get preferredSize => const Size.fromHeight(100);
}

class _CalendarWidgetState extends State<CalendarWidget> {
  int selectedDayIndex = 3;

  // Definir los días de la semana
  final List<String> daysOfWeek = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];

  // Función para obtener el primer día de la semana (lunes)
  DateTime getStartOfWeek(DateTime date) {
    int weekday = date.weekday;
    return date.subtract(Duration(days: weekday - 1)); // Lunes como primer día
  }

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).colorScheme.primary;
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    double itemWidth = screenWidth / 7;
    double circleSize = screenHeight *
        0.05; // Tamaño del círculo basado en la altura de la pantalla

    // Obtener el primer día de la semana
    final DateTime startOfWeek = getStartOfWeek(widget.currentDate);

    // Generar la lista de fechas de la semana
    final List<DateTime> weekDates = List.generate(
      7,
      (index) => startOfWeek.add(Duration(days: index)),
    );

    // Obtener el índice del día actual en la semana
    int todayIndex = weekDates.indexWhere((date) =>
        date.day == DateTime.now().day &&
        date.month == DateTime.now().month &&
        date.year == DateTime.now().year);

    return Column(
      children: [
        const SizedBox(height: 5),
        SizedBox(
          height: circleSize +
              40, // Ajustar la altura del widget para evitar overflow
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: daysOfWeek.length,
            itemBuilder: (context, index) {
              bool isSelected = index == selectedDayIndex;
              bool isToday =
                  index == todayIndex; // Usar el índice del día actual

              return SizedBox(
                width: itemWidth,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Mostrar el día de la semana con un círculo envolvente
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isToday ? primaryColor : Colors.transparent,
                        border: Border.all(
                          color: isToday ? primaryColor : Colors.transparent,
                        ),
                      ),
                      padding: const EdgeInsets.all(6.0), // Padding del círculo
                      child: Text(
                        daysOfWeek[index],
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              fontSize: 12, // Tamaño de letra más pequeño
                              color: isToday
                                  ? Colors.white
                                  : isDarkMode
                                      ? Colors.white
                                      : Colors.black,
                            ),
                      ),
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedDayIndex = index;
                          // Cambiar la fecha actual cuando se seleccione un día
                          widget.onDateChanged(
                              weekDates[index]); // Llamar al callback
                        });
                      },
                      child: CircularPercentIndicator(
                        radius: circleSize / 2, // Tamaño ajustado del círculo
                        lineWidth: 5.0,
                        percent: widget.progress[index],
                        center: Text(
                          weekDates[index].day.toString(),
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    fontSize: 14,
                                    color: isSelected
                                        ? primaryColor
                                        : isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                        ),
                        progressColor: isSelected
                            ? primaryColor
                            : isDarkMode
                                ? Colors.grey[400]
                                : Colors.grey[600],
                        backgroundColor: isDarkMode
                            ? Colors.grey.shade800
                            : Colors.grey.shade200,
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
