import 'package:flutter/material.dart';

class ThemeManager extends ChangeNotifier {
  // 1. Estado Inicial: Tema Claro
  // É o modo padrão que o aplicativo inicia
  ThemeMode _themeMode = ThemeMode.light; 

  // Getter para permitir que outros widgets leiam o modo atual
  ThemeMode get themeMode => _themeMode;

  /// 2. Alterna entre o Modo Claro e o Modo Escuro.
  /// Recebe um booleano: true para Dark Mode, false para Light Mode.
  void toggleTheme(bool isDarkMode) {
    // Define o novo modo baseado no valor de entrada
    _themeMode = isDarkMode ? ThemeMode.dark : ThemeMode.light;
    
    // Notifica todos os widgets que estão "ouvindo" (usando Provider)
    // para que eles se reconstruam com o novo tema.
    notifyListeners();
    
    // 💡 Melhoria Futura: Você pode adicionar aqui a lógica de
    // salvamento (ex: SharedPreferences) para persistir a escolha.
  }
}