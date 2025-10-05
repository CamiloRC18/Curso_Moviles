import 'dart:async';
import 'package:flutter/material.dart';
import '../../widgets/custom_drawer.dart';

class CronometroPage extends StatefulWidget {
  const CronometroPage({super.key});

  @override
  State<CronometroPage> createState() => _CronometroPageState();
}

class _CronometroPageState extends State<CronometroPage> {
  Timer? _timer;
  Duration _elapsed = Duration.zero;
  bool get _isRunning => _timer != null && _timer!.isActive;

  static const int _tickMs = 100;

  void _start() {
    if (_isRunning) return;
    _timer = Timer.periodic(const Duration(milliseconds: _tickMs), (_) {
      setState(() {
        _elapsed += const Duration(milliseconds: _tickMs);
      });
    });
  }

  void _pause() {
    _timer?.cancel();
    _timer = null;
    setState(() {});
  }

  void _resume() {
    if (_isRunning) return;
    _start();
  }

  void _reset() {
    _timer?.cancel();
    _timer = null;
    setState(() {
      _elapsed = Duration.zero;
    });
  }

  String _format(Duration d) {
    final minutes = d.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = d.inSeconds.remainder(60).toString().padLeft(2, '0');
    final centis = (d.inMilliseconds / 10)
        .floor()
        .remainder(100)
        .toString()
        .padLeft(2, '0');
    return '$minutes:$seconds.$centis';
  }

  @override
  void dispose() {
    _timer?.cancel(); // limpiar recurso
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cronómetro')),
      drawer: const CustomDrawer(),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Text(
                    _format(_elapsed),
                    style: TextStyle(
                      fontSize: 56,
                      fontWeight: FontWeight.w700,
                      color: theme.colorScheme.onBackground,
                      letterSpacing: 1.2,
                    ),
                  ),
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  // Start (visible cuando no hay tiempo transcurrido y no está corriendo)
                  if (!_isRunning && _elapsed == Duration.zero)
                    ElevatedButton.icon(
                      onPressed: _start,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Iniciar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 44),
                      ),
                    ),

                  // Pause (visible cuando está corriendo)
                  if (_isRunning)
                    ElevatedButton.icon(
                      onPressed: _pause,
                      icon: const Icon(Icons.pause),
                      label: const Text('Pausar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 44),
                      ),
                    ),

                  // Resume (visible cuando no está corriendo pero hay tiempo transcurrido)
                  if (!_isRunning && _elapsed > Duration.zero)
                    ElevatedButton.icon(
                      onPressed: _resume,
                      icon: const Icon(Icons.play_arrow),
                      label: const Text('Reanudar'),
                      style: ElevatedButton.styleFrom(
                        minimumSize: const Size(140, 44),
                      ),
                    ),

                  // Reset (siempre disponible cuando hay tiempo acumulado)
                  ElevatedButton.icon(
                    onPressed: _reset,
                    icon: const Icon(Icons.restart_alt),
                    label: const Text('Reiniciar'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: theme.colorScheme.errorContainer,
                      foregroundColor: theme.colorScheme.onErrorContainer,
                      minimumSize: const Size(120, 44),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
