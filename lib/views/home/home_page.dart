import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

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
      _title = _title == "Inicio" ? "¡Título cambiado!" : "Inicio";
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
      drawer: const CustomDrawer(),
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
              const SizedBox(width: 16),
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
        ],
      ),
    );
  }
}
