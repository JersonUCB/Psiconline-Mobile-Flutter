import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:proyecto_psiconline_mobile/Registro.dart';
import 'package:proyecto_psiconline_mobile/_cubit.dart';
import 'package:proyecto_psiconline_mobile/_state.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'usuarios.dart';
import 'cuestionario.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<FormState> _signInKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final RegExp emailValid =
      RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$");
  final RegExp passwordValid = RegExp(r"^psiconline12{1}[0-9]{1}$");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(255, 13, 65, 85),
          title: Text("Bienvenido a Psiconline"),
        ),
        body: BlocProvider(
          create: (_) => StringCubit(),
          child: SingleChildScrollView(
          child: BlocBuilder<StringCubit, StringState>(
            builder: (context, state) {
              return Form(
                key: _signInKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/psiconline.jpg',
                      height: 200,
                    ),
                    Text(
                      "Acceso",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: const InputDecoration(
                          labelText: 'Ingrese su correo electrónico',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Este campo es requerido";
                          } else if (!emailValid.hasMatch(value)) {
                            return "Por favor ingrese un correo válido";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.all(15),
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: const InputDecoration(
                          labelText: 'Escriba su contraseña',
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 15,
                            horizontal: 20,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Este campo es requerido";
                          } else if (!passwordValid.hasMatch(value)) {
                            return "La contraseña debe tener al menos 8 caracteres y contener letras y números";
                          }
                          return null;
                        },
                      ),
                    ),
                    Container(
                      width: 250,
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 13, 65, 85),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: TextButton(
                        onPressed: () async {
                          if (_signInKey.currentState!.validate()) {
                            bool credencialesCorrectas = false;
                            for (Usuario usuario in usuarios) {
                              if (_emailController.text ==
                                      usuario.nombreUsuario &&
                                  _passwordController.text ==
                                      usuario.contrasenia) {
                                // El usuario está autenticado con éxito
                                debugPrint("Correo: ${_emailController.text}");
                                credencialesCorrectas = true;
                                debugPrint("Usuario autenticado con éxito");
                                break;
                              }
                            }
                            if (!credencialesCorrectas) {
                              final prefs =
                                  await SharedPreferences.getInstance();
                              await prefs.setBool('isAuthenticated', true);
                              await prefs.setString(
                                  'username', _emailController.text);

                              String? username = prefs.getString('username');

                              if (username != null) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text('¡Bienvenido, $username!'),
                                  ),
                                );
                                // Redirigir a la página del cuestionario
                                //Navigator.push(
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Cuestionario()),
                                );
                              }
                            } else {
                              // Si la autenticación falla, muestra un mensaje de error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Error de autenticación, revise contraseña o correo'),
                                ),
                              );
                            }
                          }
                        },
                        child: const Text(
                          "Iniciar Sesión",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
                    Container(
                        width: 250,
                        padding: EdgeInsets.all(16.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          //color: Color.fromARGB(255, 13, 65, 85),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: InkWell(
                          // InkWell es un widget que detecta toques.
                          onTap: () {
                            //Navigato.push; se utiliza para navegar a una nueva vista.
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RegistroUsuario()),
                            );
                          },
                          child: Text(
                            'Registrarse',
                            style: TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 13, 65, 85),
                            ),
                          ),
                        ))
                  ],
                ),
              );
            },
          ),
        ),
        ),
      ),
    );
  }
}
