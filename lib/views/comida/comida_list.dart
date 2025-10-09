import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/custom_drawer.dart';
import '../../services/comida.services.dart';
import '../../models/comida.dart';

class ComidaListView extends StatefulWidget {
  const ComidaListView({super.key});

  @override
  State<ComidaListView> createState() => _ComidaListViewState();
}

class _ComidaListViewState extends State<ComidaListView> {
  final ComidaService _comidaService = ComidaService();
  late Future<List<comida>> _futureComidas;

  @override
  void initState() {
    super.initState();
    _futureComidas = _comidaService.fetchComidas();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Comidas')),
      drawer: const CustomDrawer(),
      body: FutureBuilder<List<comida>>(
        future: _futureComidas,
        builder: (context, snapshot) {
          // Estado: cargando
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  CircularProgressIndicator(),
                  SizedBox(height: 12),
                  Text('Cargando categorías...', style: TextStyle(fontSize: 16)),
                ],
              ),
            );
          }

          // Estado: error
          if (snapshot.hasError) {
            return Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                    const SizedBox(height: 8),
                    const Text(
                      'No se pudieron cargar las categorías.',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Verifica tu conexión e intenta nuevamente.',
                      style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed: () => setState(() => _futureComidas = _comidaService.fetchComidas()),
                      icon: const Icon(Icons.refresh),
                      label: const Text('Reintentar'),
                    ),
                  ],
                ),
              ),
            );
          }

          // Estado: éxito (data disponible)
          if (snapshot.hasData) {
            final comidas = snapshot.data!;
            if (comidas.isEmpty) {
              return Center(
                child: Text('No hay categorías disponibles.', style: theme.textTheme.bodyMedium),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(12),
              itemCount: comidas.length,
              itemBuilder: (context, index) {
                final c = comidas[index];
                final title = c.nombre;
                final leadingChar = title.isNotEmpty ? title[0].toUpperCase() : '?';

                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: theme.colorScheme.primary.withOpacity(0.12),
                      child: Text(
                        leadingChar,
                        style: TextStyle(color: theme.colorScheme.primary),
                      ),
                    ),
                    title: Text(
                      title,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      c.descripcion,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      final path = '/comida/${c.id}';
                      debugPrint('navegando a $path');
                      context.push(path);
                    },
                  ),
                );
              },
            );
          }

          // Fallback por si hay otro estado
          return Center(child: Text('Sin datos', style: theme.textTheme.bodyMedium));
        },
      ),
    );
  }
}
