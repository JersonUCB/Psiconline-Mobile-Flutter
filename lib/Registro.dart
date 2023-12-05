import 'package:flutter/material.dart';
import 'package:proyecto_psiconline_mobile/usuarios.dart';
import 'package:proyecto_psiconline_mobile/home.dart';

class RegistroUsuario extends StatefulWidget {
  @override
  _RegistroUsuarioState createState() => _RegistroUsuarioState();
}

class _RegistroUsuarioState extends State<RegistroUsuario> {
  TextEditingController _nombreUsuarioController = TextEditingController();
  TextEditingController _contraseniaController = TextEditingController();
  

  void _registrarUsuario() {
    String nombreUsuario = _nombreUsuarioController.text;
    String contrasenia = _contraseniaController.text;

    // Validar si el nombre de usuario ya existe
    if (usuarios.any((usuario) => usuario.nombreUsuario == nombreUsuario)) {
      // Mostrar un mensaje de error o realizar alguna acción
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: El nombre de usuario ya existe'),
        ),
      );
    } else {
      // Agregar el nuevo usuario a la lista
      usuarios.add(Usuario(nombreUsuario: nombreUsuario, contrasenia: contrasenia));
      // Mostrar un mensaje de éxito o realizar alguna acción
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuario registrado con éxito'),
        ),
      );
      _nombreUsuarioController.clear();
      _contraseniaController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 13, 65, 85),
        title: Text('Registro de Usuario'),
      ),
      body: SingleChildScrollView(
        child:Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/psiconline.jpg',
              height: 200,
            ),
            Row(
              children: [
                //container usuario
                Container(
                  width: 420, //ajustar tamaño
                  margin: const EdgeInsets.all(15),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: TextFormField(
                    controller: _nombreUsuarioController,
                    decoration: const InputDecoration(
                      labelText: 'Ingrese su correo electrónico',
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20,
                      ),
                    ),
                  ),
                ),
                //container de texto
                Container(
                  width: 100, //ajustar tamaño
                  child: Text(
                    '@gmail.com',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              ],
            ),

            //container de contraseña
            Container(
              margin: const EdgeInsets.all(15),
              padding: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                color: Colors.grey.shade200,
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextFormField(
                controller: _contraseniaController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Ingrese su contraseña',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 20,
                  ),
                ),
              ),
            ),
            //container de boton
            Container(
              width: 250,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 13, 65, 85),
                borderRadius: BorderRadius.circular(30),
              ),
              child: TextButton(
                //onPressed: _registrarUsuario,
                onPressed: () {
                  _registrarUsuario();
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Home()),
                  );
                },
                child: const Text(
                  "Registrar",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
        )
      ),
    );
  }
}
