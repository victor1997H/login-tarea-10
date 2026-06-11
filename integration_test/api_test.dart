import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:login1_0/services/api_service.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('Pruebas API REST (LOCAL)', () {

    testWidgets('Debe iniciar sesion correctamente', (tester) async {

      final api = ApiService();

      // 🧹 LIMPIAR STORAGE
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      // 🧾 REGISTRAR USUARIO
      await api.register(
        'Emilys',
        'emilys',
        'emilyspass',
      );

      // 🔐 LOGIN
      final loginCorrecto = await api.login(
        'emilys',
        'emilyspass',
      );

      // ✅ VALIDACIÓN
      expect(loginCorrecto, true);
    });

  });
}