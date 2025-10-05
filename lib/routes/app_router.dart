import 'package:go_router/go_router.dart';
import '../views/home/home_page.dart';
import '../views/Dashboard/dashboard_page.dart';
import '../views/paso_parametros/paso_parametro_screen.dart';
import '../views/paso_parametros/detalle_screen.dart';
import '../views/ciclo_vida/ciclo_vida_screen.dart';
import '../views/Cronometro/cronometro_page.dart';
import '../views/Asincronia/Asincronia_page.dart';

final GoRouter appRouter = GoRouter(
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const MyHomePage(title: 'Inicio'),
    ),
    GoRoute(
      path: '/dashboard',
      builder: (context, state) => const DashboardPage(),
    ),
    GoRoute(
      path: '/paso_parametros',
      builder: (context, state) => const PasoParametrosScreen(),
    ),
    GoRoute(
      path: '/cronometro',
      builder: (context, state) => const CronometroPage(),
    ),
    GoRoute(path: '/asincronia', builder: (c, s) => const AsincroniaPage()),
    GoRoute(
      path: '/detalle/:parametro/:metodo',
      builder: (context, state) {
        final parametro = state.pathParameters['parametro'] ?? '';
        final metodo = state.pathParameters['metodo'] ?? '';
        return DetalleScreen(parametro: parametro, metodoNavegacion: metodo);
      },
    ),
    GoRoute(
      path: '/ciclo_vida',
      builder: (context, state) => const CicloVidaScreen(),
    ),
  ],
  errorBuilder: (context, state) {
    // evita excepción si no se encuentra ruta; redirige a Home visualmente
    return const MyHomePage(title: 'Inicio');
  },
);
