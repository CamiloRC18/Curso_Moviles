import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
            ),
            child: const Text(
              'Menú',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              context.go('/');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text('Dashboard'),
            onTap: () {
              context.replace('/dashboard');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.input),
            title: const Text('Paso de Parámetros'),
            onTap: () {
              context.go('/paso_parametros');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.loop),
            title: const Text('Ciclo de Vida'),
            onTap: () {
              context.go('/ciclo_vida');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: const Text('Cronometro'),
            onTap: () {
              context.push('/cronometro');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.sync_alt),
            title: const Text('Asincronía '),
            onTap: () {
              context.go('/asincronia');
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: const Icon(Icons.restaurant),
            title: const Text('comida'),
            onTap: () {
              context.go('/comidas');
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}
