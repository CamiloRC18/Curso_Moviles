import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 30, 116, 52),
        ),
      ),
      home: const MyHomePage(title: 'Hola Flutter'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late String _title;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
  }

  void _cambiarTitulo() {
    setState(() {
      _title = _title == "Hola Flutter" ? "¡Título cambiado!" : "Hola Flutter";
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Título actualizado")));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(_title),
      ),
      body: Column(
        children: <Widget>[
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 130,
                height: 130,
                child: Image.network(
                  'https://images.squarespace-cdn.com/content/v1/606d159a953867291018f801/1619987722169-VV6ZASHHZNRBJW9X0PLK/Key_Art_02_layeredjpg.jpg?format=1500w',
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 16), // Espacio entre imágenes
              SizedBox(
                width: 130,
                height: 130,
                child: Image.asset('assets/Hornet.jpg', fit: BoxFit.contain),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Camilo Rios Cardona',
            style: Theme.of(context).textTheme.headlineMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(16),
            margin: const EdgeInsets.symmetric(horizontal: 32),
            color: Colors.green[100],
            child: const Text(
              'Estudiante de Ingeniería de Sistemas',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 24),
          SizedBox(
            width: 200,
            height: 50,
            child: ElevatedButton(
              onPressed: _cambiarTitulo,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(255, 69, 194, 106),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                "Cambiar título",
                style: TextStyle(
                  fontSize: 20,
                  color: Color.fromARGB(255, 0, 0, 0),
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 180,
            child: ListView(
              children: [
                ListTile(
                  leading: Icon(Icons.person, color: Colors.blue),
                  title: Text('Perfil'),
                ),
                ListTile(
                  leading: Icon(Icons.settings, color: Colors.orange),
                  title: Text('Configuración'),
                ),
                ListTile(
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text('Salir'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }
}
