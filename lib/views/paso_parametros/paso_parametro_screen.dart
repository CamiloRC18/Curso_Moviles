import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_drawer.dart';

class PasoParametrosScreen extends StatefulWidget {
  const PasoParametrosScreen({super.key});

  @override
  State<PasoParametrosScreen> createState() => PasoParametrosScreenState();
}

class PasoParametrosScreenState extends State<PasoParametrosScreen> {
  final TextEditingController controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _showMessage(String text) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(text)));
  }

  void goToDetalle(String metodo) {
    final valor = controller.text.trim();
    if (valor.isEmpty) {
      _showMessage('Por favor ingresa un valor');
      return;
    }
    FocusScope.of(context).unfocus();

    switch (metodo) {
      case 'go':
        context.go('/detalle/$valor/$metodo');
        break;
      case 'push':
        context.push('/detalle/$valor/$metodo');
        break;
      case 'replace':
        context.replace('/detalle/$valor/$metodo');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Paso de Parámetros')),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 6,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 18,
                ),
                child: Row(
                  children: [
                    const Icon(Icons.input, size: 36),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            'Enviar parámetro',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Ingresa un texto y envíalo a la pantalla detalle',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.text_fields),
                hintText: 'Ej: Hola Mundo',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),

            const SizedBox(height: 16),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => goToDetalle('go'),
                    icon: const Icon(Icons.send),
                    label: const Text('Ir con Go'),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () => goToDetalle('push'),
                    icon: const Icon(Icons.arrow_forward),
                    label: const Text('Ir con Push'),
                    style: OutlinedButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      side: BorderSide(color: theme.colorScheme.primary),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: TextButton.icon(
                    onPressed: () => goToDetalle('replace'),
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Ir con Replace'),
                    style: TextButton.styleFrom(
                      minimumSize: const Size.fromHeight(48),
                      backgroundColor: theme.colorScheme.surfaceVariant,
                      foregroundColor: theme.colorScheme.onSurface,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            Card(
              margin: EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: ListTile(
                leading: const Icon(Icons.visibility),
                title: const Text('Previsualización'),
                subtitle: Text(
                  controller.text.isEmpty
                      ? 'No hay valor ingresado'
                      : controller.text,
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    controller.clear();
                    setState(() {});
                  },
                ),
              ),
            ),

            const SizedBox(height: 12),

            const Text(
              'Diferencia de comportamiento:\n• go reemplaza la pila (no podrás volver con atrás)\n• push apila la nueva ruta (puedes volver con atrás)\n• replace reemplaza la ruta actual en la pila',
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 26, 26, 26),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
