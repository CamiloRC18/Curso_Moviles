import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class CicloVidaScreen extends StatefulWidget {
  const CicloVidaScreen({super.key});

  @override
  State<CicloVidaScreen> createState() => CicloVidaScreenState();
}

class CicloVidaScreenState extends State<CicloVidaScreen> {
  String texto = "texto inicial 🟢";

  @override
  void initState() {
    super.initState();
    if (kDebugMode) {
      print("🟢 initState() -> La pantalla se ha inicializado");
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (kDebugMode) {
      print("🟡 didChangeDependencies() -> Dependencias cambiaron");
    }
  }

  @override
  Widget build(BuildContext context) {
    if (kDebugMode) {
      print("🔵 build() -> Construyendo la pantalla");
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Ciclo de Vida')),
      drawer: const CustomDrawer(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(texto, style: const TextStyle(fontSize: 20)),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: actualizarTexto,
              child: const Text("Actualizar"),
            ),
          ],
        ),
      ),
    );
  }

  void actualizarTexto() {
    setState(() {
      texto = "Texto actualizado 🟠";
      if (kDebugMode) {
        print("🟠 setState() -> Estado actualizado");
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Texto actualizado')));
    });
  }

  @override
  void dispose() {
    if (kDebugMode) {
      print("🔴 dispose() -> La pantalla se ha destruido");
    }
    super.dispose();
  }
}
