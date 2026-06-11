import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;

  const ProfileScreen({super.key, required this.isDarkMode});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String nombre = "Cargando...";
  String username = "";
  String email = "";

  @override
  void initState() {
    super.initState();
    cargarUsuario();
  }

  Future<void> cargarUsuario() async {
    final prefs = await SharedPreferences.getInstance();

    // 👇 buscamos cualquier usuario guardado (el último login)
    final keys = prefs.getKeys();

    if (keys.isNotEmpty) {
      final key = keys.first; // usuario guardado

      final data = prefs.getString(key);

      if (data != null) {
        final json = jsonDecode(data);

        setState(() {
          nombre = json['name'] ?? key;
          username = key;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool dark = widget.isDarkMode;

    final Color primaryNeon = const Color(0xFF00F2FE);
    final Color secondaryNeon = const Color(0xFF4FACFE);
    final Color accentNeon = const Color(0xFFFF007F);

    return Scaffold(
      backgroundColor: dark ? Colors.black : const Color(0xFFF0F2F9),
      body: Stack(
        children: [
          // UI original (NO TOCADA visualmente)

          CustomScrollView(
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios_new,
                      color: dark ? Colors.white : Colors.black),
                  onPressed: () => Navigator.pop(context),
                ),
                title: const Text('PERFIL USUARIO'),
                centerTitle: true,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      FadeInDown(
                        child: _buildMainAvatarCard(
                          primaryNeon,
                          secondaryNeon,
                          accentNeon,
                          dark,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 🔥 SOLO MODIFICAMOS ESTA PARTE (DINÁMICA)
  Widget _buildMainAvatarCard(
    Color pNeon,
    Color sNeon,
    Color accent,
    bool dark,
  ) {
    return GlassmorphicContainer(
      width: double.infinity,
      height: 280,
      borderRadius: 30,
      blur: 20,
      border: 1.5,
      linearGradient: LinearGradient(
        colors: [
          (dark ? Colors.white : Colors.black).withOpacity(0.05),
          (dark ? Colors.white : Colors.black).withOpacity(0.01),
        ],
      ),
      borderGradient: LinearGradient(
        colors: [pNeon.withOpacity(0.5), sNeon.withOpacity(0.1)],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircleAvatar(
            radius: 48,
            backgroundImage: NetworkImage(
              'https://dummyjson.com/icon/emilys/128',
            ),
          ),

          const SizedBox(height: 15),

          // 👇 DINÁMICO
          Text(
            nombre,
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: dark ? Colors.white : Colors.black,
            ),
          ),

          const SizedBox(height: 4),

          Text(
            '@$username',
            style: TextStyle(
              fontSize: 14,
              color: accent,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 12),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              color: (dark ? Colors.white : Colors.black).withOpacity(0.05),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              'Usuario conectado en sesión local',
              style: TextStyle(
                fontSize: 12,
                color: dark ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
