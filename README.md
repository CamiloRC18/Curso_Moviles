# 📝 Descripción breve
 Este proyecto trata de hacer entreaga del taller 1 de la clase de moviles. el taller incluye lo siguiente:
- **Pantalla principal (HomePage):**
  - `AppBar` con un título inicial: **"Hola, Flutter"**
  - Texto centrado con el **nombre completo del estudiante**.
  - Imágenes mostradas en un `Row`:
    - Una imagen con `Image.network()`.
    - Una imagen con `Image.asset()`.
  - Botón con `setState()`:
    - Alterna el título de la AppBar entre **"Hola, Flutter"** y **"¡Título cambiado!"**.
    - Muestra un **SnackBar** con el mensaje: *"Título actualizado"*.
- **Widgets adicionales:**
  - `Container` con márgenes, colores o bordes aplicados a un widget.
  - `ListView` con 3–4 elementos que incluyen ícono y texto.

#  ⚙️ Pasos para ejecutar
**1. Clonar el repositorio:**
   ```bash
   git https://github.com/CamiloRC18/Curso_Moviles.git
   cd Curso_Moviles
   ```
**2. Verificar si el flutter esta instalado**
```
flutter --version
```
**3. Descargar las librerias**

Para descargar las dependencias del proyecto primero asegurate estar en la carpeta que se creo al clonar el proyecto y luego ejecuta el siguiente comando:
```
flutter pub get
```
**Recomendacion**

Antes de correr el proyecto debes asegurarte que cuentes con un emulador, puedes usar los emuladores de Android Studio

**Ejecutar proyecto**

Para correr el proyecto debes usar el comando:
```
flutter run
```
Debes estar en el directorio del proyecto

# 📸 Capturas de pantalla

**Inicio del proyecto**

![alt text](image.png)

**Cambio del titulo**

![alt text](image-1.png)


# Acualizacion del taller 2

## Arquitectura / Navegación
Rutas definidas (go_router):
- `/` -> Home (lib/views/home/home_page.dart)
- `/dashboard` -> Dashboard (lib/views/Dashboard/dashboard_page.dart)
- `/paso_parametros` -> Pantalla para enviar parámetros (lib/views/paso_parametros/paso_parametro_screen.dart)
- `/detalle/:parametro/:metodo` -> Detalle que recibe parámetros por ruta (lib/views/paso_parametros/detalle_screen.dart)
- `/ciclo_vida` -> Pantalla para demostrar ciclo de vida (lib/views/ciclo_vida/ciclo_vida_screen.dart)

Cómo se pasan parámetros:
- Parámetros de detalle se pasan como path parameters en la ruta `/detalle/:parametro/:metodo`.
  - Ejemplo: context.go('/detalle/miValor/go')
  - En DetalleScreen se recupera con state.pathParameters['parametro'] y ['metodo'] en el router.
- Métodos de navegación usados:
  - context.go(path) — reemplaza la ruta actual (no se puede volver con back).
  - context.push(path) — apila la nueva ruta (se puede volver con back).
  - context.replace(path) — reemplaza la ruta actual en la pila.

Nota: appRouter se declara en lib/routes/app_router.dart y se pasa a MaterialApp.router en main.dart.

## Widgets usados y por qué
- MaterialApp.router / GoRouter
  - Manejo centralizado de rutas y parámetros; permite usar context.go/push/replace.
- Scaffold, AppBar
  - Estructura básica de cada pantalla; AppBarTheme centralizado en lib/themes/app_theme.dart para estilo uniforme.
- Drawer (CustomDrawer)
  - Navegación lateral con opciones reutilizables en todo el app.
- Image.network / Image.asset, Row, Container, Divider
  - Mostrar imágenes (remota y local) y estructura en banner + separación visual.
- Text, TextStyle
  - Mostrar datos estáticos (nombre) y personalizar tipografía del botón y títulos.
- ElevatedButton, OutlinedButton, TextButton, ElevatedButton.icon
  - Diferentes acciones con estilos semánticos: acción principal, secundaria y opciones.
- SnackBar
  - Retroalimentación inmediata al usuario (ej. "Título actualizado").
- ListView / ListTile
  - Listas desplazables para menús y listas de ítems (ej. tareas pendientes).
- GridView
  - Mostrar una rejilla de elementos en el dashboard.
- DefaultTabController / TabBar / TabBarView
  - Secciones dentro de una misma pantalla (Dashboard) para organizar Grid/List/Overlay.
- Stack
  - Superponer texto/controles sobre una imagen (overlay).
- Dismissible
  - Interacción para marcar tareas como completadas con gesto de swipe.
- Modal Bottom Sheet (showModalBottomSheet)
  - Mostrar detalles rápidos de un elemento sin cambiar de pantalla.

## Archivos clave / Ubicación
- main.dart — configura MaterialApp.router y routerConfig
  - filepath: lib/main.dart
- app_router.dart — definición de rutas y errorBuilder
  - filepath: lib/routes/app_router.dart
- Tema centralizado
  - filepath: lib/themes/app_theme.dart
- Vistas principales
  - Home: lib/views/home/home_page.dart
  - Dashboard: lib/views/Dashboard/dashboard_page.dart
  - Paso parámetros: lib/views/paso_parametros/paso_parametro_screen.dart
  - Detalle: lib/views/paso_parametros/detalle_screen.dart
  - Ciclo de vida: lib/views/ciclo_vida/ciclo_vida_screen.dart
- Drawer personalizado
  - filepath: lib/widgets/custom_drawer.dart

# 👤 Datos del Estudiante
- Camilo Rios Cardona
- Codigo: 230221047