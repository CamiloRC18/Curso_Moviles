import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../widgets/custom_drawer.dart';
import '../../../services/comida.services.dart';
import '../../../models/comida.dart';

class ComidaDetailView extends StatefulWidget {
  final String id;

  const ComidaDetailView({super.key, required this.id});

  @override
  State<ComidaDetailView> createState() => _ComidaDetailViewState();
}

class _ComidaDetailViewState extends State<ComidaDetailView> {
  final ComidaService _comidaService = ComidaService();
  late Future<comida> _futureComida;

  void initState() {
    super.initState();
    // asegúrate de que en ComidaService exista getComidaById (o ajusta el nombre)
    _futureComida = _comidaService.getComidaById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle')),
      drawer: const CustomDrawer(),
      body: FutureBuilder<comida>(
        future: _futureComida,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final comidaItem = snapshot.data!;
            final title = comidaItem.nombre;
            final desc = comidaItem.descripcion;
            final imageUrl = comidaItem.imagen;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Imagen (si existe)
                      if (imageUrl.isNotEmpty)
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            imageUrl,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stack) => Container(
                              height: 200,
                              color: theme.colorScheme.surfaceVariant,
                              child: const Center(
                                child: Icon(Icons.broken_image, size: 48),
                              ),
                            ),
                          ),
                        )
                      else
                        Container(
                          height: 200,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surfaceVariant,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Center(
                            child: Icon(Icons.fastfood, size: 56),
                          ),
                        ),
                      const SizedBox(height: 16),

                      // Título
                      Text(
                        title.toUpperCase(),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 12),

                      // Descripción si existe
                      if (desc.isNotEmpty)
                        Text(
                          desc,
                          style: const TextStyle(fontSize: 14),
                          textAlign: TextAlign.justify,
                        ),

                      const SizedBox(height: 16),

                      // Botón volver
                      ElevatedButton.icon(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back),
                        label: const Text('Volver'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
