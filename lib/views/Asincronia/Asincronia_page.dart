import 'dart:isolate';
import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';
import 'package:go_router/go_router.dart';

class AsincroniaPage extends StatefulWidget {
  const AsincroniaPage({super.key});

  @override
  State<AsincroniaPage> createState() => _AsincroniaPageState();
}

class _AsincroniaPageState extends State<AsincroniaPage> {
  // --- Future / async demo state
  String _futureStatus = 'Idle';
  String _futureResult = '';

  // --- Isolate demo state
  bool _isolateRunning = false;
  String _isolateResult = '';
  Isolate? _isolate;

  final TextEditingController _countController = TextEditingController(
    text: '5000000',
  );

  @override
  void dispose() {
    _countController.dispose();
    _isolate?.kill(priority: 0);
    super.dispose();
  }

  Future<String> _fakeFetch() async {
    print('[FakeFetch] inicio (simulado)'); // consola: durante
    await Future.delayed(const Duration(seconds: 2));
    print('[FakeFetch] finalizado');
    return 'Datos simulados (${DateTime.now().toIso8601String()})';
  }

  Future<void> _loadData() async {
    print('[UI] Antes de await _fakeFetch()');
    setState(() {
      _futureStatus = 'Cargando…';
      _futureResult = '';
    });

    try {
      final res = await _fakeFetch();
      print('[UI] Después de await (resultado obtenido)');
      setState(() {
        _futureStatus = 'Éxito';
        _futureResult = res;
      });
    } catch (e, st) {
      print('[UI] Error en fetch: $e\n$st');
      setState(() {
        _futureStatus = 'Error';
        _futureResult = e.toString();
      });
    }
  }

  static void _isolateEntry(List<dynamic> args) {
    final SendPort send = args[0] as SendPort;
    final int count = args[1] as int;

    // función CPU-bound: suma 0..count-1
    print('[Isolate] iniciado, count=$count');
    int sum = 0;
    for (int i = 0; i < count; i++) {
      sum += i;
    }
    print('[Isolate] terminado, enviando resultado');
    send.send(sum);
  }

  Future<void> _startIsolate() async {
    final int count = int.tryParse(_countController.text) ?? 5000000;
    final rp = ReceivePort();

    setState(() {
      _isolateRunning = true;
      _isolateResult = '';
    });

    print('[UI] Spawn isolate (count=$count)');

    try {
      final isolate = await Isolate.spawn<List<dynamic>>(
        _isolateEntry,
        [rp.sendPort, count],
        onError: rp.sendPort,
        onExit: rp.sendPort,
      );
      _isolate = isolate;

      rp.listen((message) {
        if (message is int) {
          print('[UI] Mensaje recibido del isolate: $message');
          setState(() {
            _isolateResult = 'Resultado: $message';
            _isolateRunning = false;
          });
          rp.close();
          isolate.kill(priority: 0);
        } else {
          print('[UI] mensaje no esperado isolate: $message');
        }
      });
    } catch (e, st) {
      print('[UI] Error al spawn isolate: $e\n$st');
      setState(() {
        _isolateResult = 'Error al ejecutar isolate: $e';
        _isolateRunning = false;
      });
      rp.close();
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Asincronía & Isolate')),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Async / Future (simulado)',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    Text('Estado: $_futureStatus'),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: _loadData,
                            child: const Text('Cargar datos (Future.delayed)'),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              _futureStatus = 'Idle';
                              _futureResult = '';
                            });
                          },
                          child: const Text('Limpiar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: theme.colorScheme.errorContainer,
                            foregroundColor: theme.colorScheme.onErrorContainer,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _futureResult.isEmpty ? 'Sin resultado' : _futureResult,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 16),

            Card(
              child: Padding(
                padding: const EdgeInsets.all(14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Isolate (tarea CPU-bound)',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Ingresa la cantidad para la suma (ej. 5,000,000)',
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _countController,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              border: OutlineInputBorder(),
                              isDense: true,
                            ),
                          ),
                        ),
                        const SizedBox(width: 8),
                        ElevatedButton(
                          onPressed: _isolateRunning ? null : _startIsolate,
                          child: _isolateRunning
                              ? const SizedBox(
                                  width: 18,
                                  height: 18,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text('Ejecutar'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _isolateResult.isEmpty ? 'Sin resultado' : _isolateResult,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Observa la consola para el orden de ejecución (prints).',
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton.icon(
              onPressed: () => context.go('/'),
              icon: const Icon(Icons.home),
              label: const Text('Ir a Home'),
            ),
          ],
        ),
      ),
    );
  }
}
