import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'form.dart'; // Importa el archivo form.dart

class Cuestionario extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 65, 85),
        title: Text('Cuestionario'),
      ),
      body: SingleChildScrollView(
        child:Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Image.asset(
                      'assets/psiconline.jpg',
                      height: 200,
                    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 13, 65, 85),
              ),
              onPressed: () {
                // Navegar a la página de formulario
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FormPage()),
                );
              },
              child: Text('Ir al Cuestionario'),
            ),
                SizedBox(height: 100),
                SizedBox(width:100),
                ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Color.fromARGB(255, 13, 65, 85),
              ),
              onPressed: () {
                // Lógica para abrir WhatsApp enlace de emergencia
                // En este ejemplo, se abre un enlace de WhatsApp Web
                const url =
                    'https://api.whatsapp.com/send?phone=+59160708230&text=Hola,%20soy...necesito%20una%20sesion%20urgente,%20es%20una%20emergencia';
                launch(
                    url); // Asegúrate de importar 'package:url_launcher/url_launcher.dart';
              },
              child: Text('Emergencia'),
            ),
              ],
            ),
          ],
        ),
      ),
      ),
    );
  }
}
