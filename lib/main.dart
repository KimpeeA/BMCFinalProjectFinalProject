import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_fonts/google_fonts.dart'; // 1. ADD THIS IMPORT

// Gruvbox Dark Theme Color Palette
const Color kGruvboxBg = Color(0xFF282828);
const Color kGruvboxFg = Color(0xFFEBDBB2);
const Color kGruvboxRed = Color(0xFFCC241D);
const Color kGruvboxGreen = Color(0xFF98971A);
const Color kGruvboxYellow = Color(0xFFD79921);
const Color kGruvboxBlue = Color(0xFF458588);
const Color kGruvboxPurple = Color(0xFFB16286);
const Color kGruvboxAqua = Color(0xFF689D6A);
const Color kGruvboxGray = Color(0xFFA89984);
const Color kGruvboxOrange = Color(0xFFD65D0E);
const Color kGruvboxLightBg = Color(0xFF3C3836);
const Color kGruvboxDarkRed = Color(0xFFFB4934);


void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final cartProvider = CartProvider();
  runApp(
    ChangeNotifierProvider.value(
      value: cartProvider,
      child: const MyApp(),
    ),
  );
  FlutterNativeSplash.remove();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'eCommerce App',
      theme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: kGruvboxBlue,
          brightness: Brightness.dark,
          primary: kGruvboxBlue,
          onPrimary: kGruvboxFg,
          secondary: kGruvboxAqua,
          background: kGruvboxBg,
          surface: kGruvboxLightBg,
          onSurface: kGruvboxFg,
          error: kGruvboxRed,
          onError: kGruvboxFg,
        ),
        useMaterial3: true,
        scaffoldBackgroundColor: kGruvboxBg,
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: kGruvboxFg,
                displayColor: kGruvboxFg,
              ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kGruvboxBlue,
            foregroundColor: kGruvboxFg, // Corrected from kGruvboxBg
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(color: kGruvboxGray.withOpacity(0.5)),
          ),
          labelStyle: TextStyle(color: kGruvboxGray),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kGruvboxBlue, width: 2.0),
          ),
          fillColor: kGruvboxLightBg,
          filled: true,
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          color: kGruvboxLightBg,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: kGruvboxLightBg,
          foregroundColor: kGruvboxFg,
          elevation: 0,
          centerTitle: true,
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kGruvboxAqua,
          ),
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}
