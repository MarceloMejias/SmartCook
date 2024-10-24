import 'package:flutter/material.dart';
import 'package:smartcook/screens/widgets/calendar.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart'; // Import necesario

class PlanScreen extends StatefulWidget {
  const PlanScreen({super.key});

  @override
  _PlanScreenState createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  late DateTime currentDate;
  late Map<String, DateTime> weekDates;
  List<double> progress =
      List.generate(7, (index) => 0.0); // Inicializado vacío
  bool _progressFetched = false; // Nueva variable para controlar la carga

  @override
  void initState() {
    super.initState();
    currentDate = DateTime.now();
    weekDates = _generateWeekDates(currentDate);

    // Inicializar el formato de fecha en español
    initializeDateFormatting('es_ES', null).then((_) {
      setState(() {});
    });

    // Solo cargar progreso una vez, al iniciar
    if (!_progressFetched) {
      _fetchProgress();
    }
  }

  // Simular la obtención de los valores de progreso (esto será reemplazable con una API)
  Future<void> _fetchProgress() async {
    await Future.delayed(
        const Duration(seconds: 2)); // Simular una espera de carga
    setState(() {
      progress = List.generate(7, (index) => 0.7); // Progreso simulado
      _progressFetched = true; // Marcar progreso como cargado
    });
  }

  // Método para cambiar la fecha actual y actualizar el estado
  void _changeCurrentDate(DateTime newDate) {
    setState(() {
      currentDate = newDate;
      weekDates =
          _generateWeekDates(currentDate); // Actualiza las fechas de la semana
    });
  }

  @override
  Widget build(BuildContext context) {
    // Formatear la fecha actual para mostrarla en el AppBar
    String formattedDate = DateFormat('EEEE d', 'es_ES').format(currentDate);
    formattedDate = formattedDate[0].toUpperCase() +
        formattedDate.substring(1); // Capitaliza solo la primera letra

    return Scaffold(
      appBar: AppBar(
        // Título dinámico con la fecha actual
        title: Text(formattedDate), // Mostrar fecha actual en el AppBar
      ),
      body: Column(
        children: [
          CalendarWidget(
            currentDate: currentDate,
            progress: progress, // Progreso dinámico
            onDateChanged:
                _changeCurrentDate, // Pasar el callback al widget del calendario
          ),
        ],
      ),
    );
  }

  // Generar un mapa con los días de la semana y las fechas correspondientes
  Map<String, DateTime> _generateWeekDates(DateTime currentDate) {
    final List<String> daysOfWeek = ['L', 'M', 'M', 'J', 'V', 'S', 'D'];
    final Map<String, DateTime> weekDates = {};

    for (int i = 0; i < 7; i++) {
      final day = daysOfWeek[i];
      final date =
          currentDate.add(Duration(days: i)); // Sumar días al día actual
      weekDates[day] =
          date; // Asignar el día de la semana y la fecha correspondiente
    }

    return weekDates;
  }
}
