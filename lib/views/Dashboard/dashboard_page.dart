import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../widgets/custom_drawer.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final List<_Task> _tasks = [
    _Task(title: 'Entregar informe final', due: '25 Sep 2025'),
    _Task(title: 'Preparar presentación', due: '27 Sep 2025'),
    _Task(title: 'Enviar actividades', due: '30 Sep 2025'),
    _Task(title: 'Revisar retroalimentación', due: '02 Oct 2025'),
  ];

  void _completeTask(int index) {
    final t = _tasks[index];
    setState(() => _tasks.removeAt(index));
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Tarea completada: ${t.title}')));
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.grid_view), text: 'Grid'),
              Tab(icon: Icon(Icons.list), text: 'Tareas'),
              Tab(icon: Icon(Icons.layers), text: 'Overlay'),
            ],
          ),
        ),
        drawer: const CustomDrawer(),
        body: TabBarView(
          children: [
            // Tab 1: Grid sencillo
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 8,
                mainAxisSpacing: 8,
                children: List.generate(6, (i) {
                  return Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.folder,
                              size: 36,
                              color: theme.colorScheme.primary,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Elemento ${i + 1}',
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 4),
                            const Text(
                              'Descripción breve',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Tab 2: Lista de tareas pendientes (más simple)
            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: Column(
                  children: [
                    Card(
                      margin: EdgeInsets.zero,
                      child: ListTile(
                        leading: const Icon(Icons.task),
                        title: const Text('Tareas pendientes'),
                        subtitle: Text('${_tasks.length} tareas'),
                        trailing: IconButton(
                          icon: const Icon(Icons.refresh),
                          onPressed: () => setState(() {}),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Expanded(
                      child: _tasks.isEmpty
                          ? Center(
                              child: Text(
                                'No hay tareas pendientes',
                                style: TextStyle(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            )
                          : ListView.separated(
                              itemCount: _tasks.length,
                              separatorBuilder: (_, __) =>
                                  const Divider(height: 1),
                              itemBuilder: (context, index) {
                                final t = _tasks[index];
                                return ListTile(
                                  title: Text(t.title),
                                  subtitle: Text('Fecha: ${t.due}'),
                                  leading: CircleAvatar(
                                    backgroundColor: theme.colorScheme.primary
                                        .withOpacity(0.12),
                                    child: Text(
                                      t.title.isNotEmpty ? t.title[0] : '?',
                                      style: TextStyle(
                                        color: theme.colorScheme.primary,
                                      ),
                                    ),
                                  ),
                                  trailing: IconButton(
                                    icon: const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    ),
                                    onPressed: () => _completeTask(index),
                                  ),
                                  onTap: () {
                                    showModalBottomSheet(
                                      context: context,
                                      builder: (_) => Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              t.title,
                                              style: const TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                            Text('Fecha límite: ${t.due}'),
                                            const SizedBox(height: 12),
                                            TextButton.icon(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                                _completeTask(index);
                                              },
                                              icon: const Icon(Icons.check),
                                              label: const Text(
                                                'Marcar como completada',
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              },
                            ),
                    ),
                  ],
                ),
              ),
            ),

            // Tab 3: Overlay simple
            Stack(
              children: [
                SizedBox.expand(
                  child: Image.network(
                    'https://images.unsplash.com/photo-1503264116251-35a269479413?q=80&w=1400&auto=format&fit=crop',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(color: Colors.black26),
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Sección Overlay',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () => context.go(
                          '/',
                        ), // ← navega a la Home usando go_router
                        child: const Text('Ir a Home'),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _Task {
  final String title;
  final String due;
  _Task({required this.title, required this.due});
}
