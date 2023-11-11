import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Login(),
    );
  }
}

class Login extends StatelessWidget {
  final TextEditingController nombreUsuario = TextEditingController();
  final TextEditingController contrasena = TextEditingController();

  Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: nombreUsuario,
              decoration: const InputDecoration(labelText: 'Usuario'),
            ),
            TextField(
              controller: contrasena,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (verifyUser(nombreUsuario.text, contrasena.text)) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Menu()),
                  );
                } else {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Error'),
                      content: const Text('Usuario o contraseña incorrectos.'),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: const Text('Iniciar Sesión'),
            ),
          ],
        ),
      ),
    );
  }

  bool verifyUser(String username, String password) {
    return (username == 'santiago' && password == '12345');
  }
}

class Menu extends StatelessWidget {
  final List<Map<String, String>> usuarios = [];

  Menu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menú'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                          RegistroUsuarios(usuarios: usuarios)),
                );
              },
              child: const Text('Registrar Usuario'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ListarUsuarios(usuarios: usuarios)),
                );
              },
              child: const Text('Listar Usuarios'),
            ),
          ],
        ),
      ),
    );
  }
}

class RegistroUsuarios extends StatelessWidget {
  final TextEditingController id = TextEditingController();
  final TextEditingController nombre = TextEditingController();
  final TextEditingController correo = TextEditingController();
  final TextEditingController contrasena = TextEditingController();
  final TextEditingController fecha = TextEditingController();
  final TextEditingController rol = TextEditingController();
  final TextEditingController estado = TextEditingController();

  final List<Map<String, String>> usuarios;

  RegistroUsuarios({super.key, required this.usuarios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro de Usuario'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: id,
              decoration: const InputDecoration(labelText: 'ID'),
            ),
            TextField(
              controller: nombre,
              decoration: const InputDecoration(labelText: 'Nombre'),
            ),
            TextField(
              controller: correo,
              decoration: const InputDecoration(labelText: 'Correo'),
            ),
            TextField(
              controller: contrasena,
              decoration: const InputDecoration(labelText: 'Contraseña'),
              obscureText: true,
            ),
            TextField(
              controller: fecha,
              decoration: const InputDecoration(labelText: 'Fecha de Creación'),
            ),
            TextField(
              controller: rol,
              decoration: const InputDecoration(labelText: 'Rol'),
            ),
            TextField(
              controller: estado,
              decoration: const InputDecoration(labelText: 'Estado'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                agregarUsuario();
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Éxito'),
                    content: const Text('Usuario registrado con éxito.'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          limpiarCampos();
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                );
              },
              child: const Text('Registrar'),
            ),
          ],
        ),
      ),
    );
  }

  void agregarUsuario() {
    usuarios.add({
      'ID': id.text,
      'Nombre': nombre.text,
      'Correo': correo.text,
      'Contraseña': contrasena.text,
      'Fecha de Creación': fecha.text,
      'Rol': rol.text,
      'Estado': estado.text,
    });
  }

  void limpiarCampos() {
    id.clear();
    nombre.clear();
    correo.clear();
    contrasena.clear();
    fecha.clear();
    rol.clear();
    estado.clear();
  }
}

class ListarUsuarios extends StatelessWidget {
  final List<Map<String, String>> usuarios;

  const ListarUsuarios({super.key, required this.usuarios});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Usuarios'),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: usuarios.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('ID: ${usuarios[index]['ID']}'),
              subtitle: Text(
                  'Nombre: ${usuarios[index]['Nombre']} \nCorreo: ${usuarios[index]['Correo']} \nContraseña: ${usuarios[index]['Contraseña']} \nFecha de creación: ${usuarios[index]['Fecha de Creación']} \nRol: ${usuarios[index]['Rol']} \nEstado: ${usuarios[index]['Estado']}'),
            );
          },
        ),
      ),
    );
  }
}
