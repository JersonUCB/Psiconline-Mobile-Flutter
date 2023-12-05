import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FormPage extends StatefulWidget {
  @override
  _FormPageState createState() => _FormPageState();
}

class _FormPageState extends State<FormPage> {
  final TextEditingController _nombreController = TextEditingController();
  String? _nombreGuardado;
  String? _p1;
  String? _p2;
  String? _p3; // Variable para almacenar la respuesta a la pregunta 3
  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 65, 85),
        title: Text('Cuestionario'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Instrucciones:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Este es un cuestionario que busca ayudarte a conseguir un mejor psicólogo dependiendo de tus necesidades. Responde lo más sinceramente posible.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 16),
              TextField(
                controller: _nombreController,
                decoration: InputDecoration(labelText: 'Nombre Completo'),
              ),
              SizedBox(height: 16),
              Text(
                'Pregunta 1: ¿Qué estás sintiendo actualmente?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildOpcionesPregunta1(),
              SizedBox(height: 16),
              Text(
                'Pregunta 2: ¿Cuántos años tienes?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildOpcionesPregunta2(),
              SizedBox(height: 16),
              Text(
                'Pregunta 3: ¿Qué tipo de problema tienes?',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              _buildOpcionesPregunta3(),
              SizedBox(height: 16),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(255, 13, 65, 85),
                ),
                onPressed: _guardarDatos,
                child: Text('Guardar Datos'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOpcionesPregunta1() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadioOption('a) Tristeza', 1, 'p1'),
        _buildRadioOption('b) Enojo', 2, 'p1'),
        _buildRadioOption('c) Depresión', 3, 'p1'),
        _buildRadioOption('d) Ansiedad', 4, 'p1'),
        _buildRadioOption('e) Desesperación', 5, 'p1'),
        _buildRadioOption('f) Otro tipo de sentimiento', 0, 'p1'),
      ],
    );
  }

  Widget _buildOpcionesPregunta2() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadioOption('a) Menos de 18', 0, 'p2'),
        _buildRadioOption('b) 18-24', 1, 'p2'),
        _buildRadioOption('c) 25-34', 2, 'p2'),
        _buildRadioOption('d) 35-44', 3, 'p2'),
        _buildRadioOption('e) 45-54', 4, 'p2'),
        _buildRadioOption('f) 55-64', 5, 'p2'),
        _buildRadioOption('g) 65 o más', 0, 'p2'),
      ],
    );
  }

  Widget _buildOpcionesPregunta3() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildRadioOption('a) Familiar', 3, 'p3'),
        _buildRadioOption('b) Pareja', 2, 'p3'),
        _buildRadioOption('c) Estudios', 1, 'p3'),
        _buildRadioOption('d) Religión', 4, 'p3'),
        _buildRadioOption('e) Personal', 5, 'p3'),
      ],
    );
  }

  Widget _buildRadioOption(String label, int puntaje, String pregunta) {
    return Row(
      children: [
        Radio<String>(
          value: label,
          groupValue: _getGroupValue(pregunta),
          onChanged: (String? value) {
            setState(() {
              _setGroupValue(pregunta, value, puntaje);
            });
          },
          activeColor: Color.fromARGB(255, 13, 65, 85),
        ),
        Text(label),
      ],
    );
  }

  String? _getGroupValue(String pregunta) {
    switch (pregunta) {
      case 'p1':
        return _p1;
      case 'p2':
        return _p2;
      case 'p3':
        return _p3;
      default:
        return null;
    }
  }

  void _setGroupValue(String pregunta, String? value, int puntaje) {
    switch (pregunta) {
      case 'p1':
        _p1 = value;
        break;
      case 'p2':
        _p2 = value;
        break;
      case 'p3':
        _p3 = value;
        break;
    }
  }

  void _guardarDatos() {
    final String nombre = _nombreController.text;

    if (nombre.isNotEmpty && _p1 != null && _p2 != null && _p3 != null) {
      _nombreGuardado = nombre;
      int totalPuntaje = _calcularPuntaje();

      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text(
            'Datos guardados con éxito:\nNombre: $_nombreGuardado\nPregunta 1: $_p1\nPregunta 2: $_p2\nPregunta 3: $_p3\nPuntaje Total: $totalPuntaje',
          ),
        ),
      );

      _redireccionarSegunPuntaje(totalPuntaje);
    } else {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content:
              Text('Por favor, completa todos los campos antes de guardar.'),
        ),
      );
    }
  }

  int _calcularPuntaje() {
    // Asigna puntajes a las respuestas seleccionadas
    int puntajeP1 = _asignarPuntaje(_p1);
    int puntajeP2 = _asignarPuntaje(_p2);
    int puntajeP3 = _asignarPuntaje(_p3);

    // Suma los puntajes
    return puntajeP1 + puntajeP2 + puntajeP3;
  }

  int _asignarPuntaje(String? respuesta) {
    // Define los puntajes para cada respuesta
    Map<String, int> puntajes = {
      'a) Tristeza': 1,
      'b) Enojo': 2,
      'c) Depresión': 3,
      'd) Ansiedad': 4,
      'e) Desesperación': 5,
      'f) Otro tipo de sentimiento': 0,
      'a) Menos de 18': 0,
      'b) 18-24': 1,
      'c) 25-34': 2,
      'd) 35-44': 3,
      'e) 45-54': 4,
      'f) 55-64': 5,
      'g) 65 o más': 0,
      'a) Familiar': 3,
      'b) Pareja': 2,
      'c) Estudios': 1,
      'd) Religión': 4,
      'e) Personal': 5,
    };

    // Retorna el puntaje asignado a la respuesta
    return respuesta != null ? puntajes[respuesta] ?? 0 : 0;
  }

  void _redireccionarSegunPuntaje(int totalPuntaje) async {
    String link;

    if (totalPuntaje < 5) {
      link = 'https://wa.link/d3kxcf';
    } else if (totalPuntaje >= 5 && totalPuntaje <= 10) {
      link = 'https://wa.link/nor0ie';
    } else {
      link = 'https://wa.link/mtwuul';
    }

    if (await canLaunch(link)) {
      await launch(link);
    } else {
      ScaffoldMessenger.of(_context).showSnackBar(
        SnackBar(
          content: Text('No se pudo abrir el enlace.'),
        ),
      );
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: FormPage(),
  ));
}
