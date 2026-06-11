import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final bool isDarkMode;
  final Function(bool) onThemeChanged;

  const SettingsScreen({
    super.key,
    required this.isDarkMode,
    required this.onThemeChanged,
  });

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool notifications = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
        backgroundColor: const Color(0xFF8E2DE2),
      ),

      body: ListView(
        padding: const EdgeInsets.all(20),

        children: [
          // TEMA
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: SwitchListTile(
              secondary: Icon(
                widget.isDarkMode ? Icons.dark_mode : Icons.light_mode,
                color: Colors.purple,
              ),

              title: const Text(
                'Modo oscuro',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: Text(
                widget.isDarkMode
                    ? 'Tema oscuro activado'
                    : 'Tema claro activado',
              ),

              value: widget.isDarkMode,

              onChanged: (value) {
                widget.onThemeChanged(value);

                setState(() {});
              },
            ),
          ),

          const SizedBox(height: 15),

          // NOTIFICACIONES
          Card(
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),

            child: SwitchListTile(
              secondary: const Icon(Icons.notifications, color: Colors.purple),

              title: const Text(
                'Notificaciones',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),

              subtitle: const Text('Recibir avisos del sistema'),

              value: notifications,

              onChanged: (value) {
                setState(() {
                  notifications = value;
                });
              },
            ),
          ),

          const SizedBox(height: 15),

          // SEGURIDAD
          Card(
            child: ListTile(
              leading: const Icon(Icons.lock, color: Colors.purple),

              title: const Text('Seguridad'),

              subtitle: const Text('Cambiar contraseña'),

              trailing: const Icon(Icons.arrow_forward_ios),
            ),
          ),

          const SizedBox(height: 15),

          // INFO APP
          Card(
            child: ListTile(
              leading: const Icon(Icons.info, color: Colors.purple),

              title: const Text('Información'),

              subtitle: const Text('Versión 1.0.0'),
            ),
          ),
        ],
      ),
    );
  }
}
