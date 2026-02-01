import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/home_screen.dart';
import 'providers/song_provider.dart';
import 'providers/settings_provider.dart';

void main() {
  runApp(const NotenVerwaltungApp());
}

class NotenVerwaltungApp extends StatelessWidget {
  const NotenVerwaltungApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SongProvider()),
        ChangeNotifierProvider(create: (_) => SettingsProvider()),
      ],
      child: MaterialApp(
        title: 'Notenverwaltung',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.dark,
          primaryColor: const Color(0xFFD4AF37),
          scaffoldBackgroundColor: const Color(0xFF0F0F1E),
          colorScheme: const ColorScheme.dark(
            primary: Color(0xFFD4AF37),
            secondary: Color(0xFF16213E),
            surface: Color(0xFF1F1F33),
            background: Color(0xFF0F0F1E),
          ),
          cardTheme: const CardTheme(
            color: Color(0xFF1F1F33),
            elevation: 8,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF1A1A2E),
            elevation: 0,
          ),
          textTheme: const TextTheme(
            displayLarge: TextStyle(
              fontFamily: 'serif',
              fontSize: 32,
              fontWeight: FontWeight.w300,
              color: Color(0xFFD4AF37),
            ),
            headlineMedium: TextStyle(
              fontFamily: 'serif',
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: Color(0xFFF4E4B5),
            ),
            bodyLarge: TextStyle(
              fontSize: 16,
              color: Color(0xFFE8E8E8),
            ),
            bodyMedium: TextStyle(
              fontSize: 14,
              color: Color(0xFFA0A0A0),
            ),
          ),
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
