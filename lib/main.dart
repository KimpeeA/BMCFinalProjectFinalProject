import 'package:ecommerce_app/providers/cart_provider.dart';
import 'package:ecommerce_app/screens/auth_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:google_fonts/google_fonts.dart';

// New Theme Color Palette
const Color kDarkBg = Color(0xFF1F1F1F);
const Color kMetallicGold = Color(0xFFD4AF37); // A nice gold color
const Color kLightGold = Color(0xFFE5C100);
const Color kWhiteText = Color(0xFFFFFFFF);
const Color kGreyText = Color(0xFFBDBDBD);
const Color kErrorRed = Color(0xFFCF6679);

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
        scaffoldBackgroundColor: kDarkBg,
        primaryColor: kMetallicGold,
        // Define the color scheme
        colorScheme: ColorScheme.fromSeed(
          seedColor: kMetallicGold,
          brightness: Brightness.dark,
          background: kDarkBg,
          primary: kMetallicGold,
          secondary: kLightGold,
          onPrimary: kDarkBg,       // Text on top of primary color
          onSecondary: kDarkBg,     // Text on top of secondary color
          surface: kDarkBg,
          onSurface: kWhiteText,    // Default text color
          error: kErrorRed,
          onError: kDarkBg,
        ),

        // Use Material 3 design
        useMaterial3: true,

        // Define Text Theme
        textTheme: GoogleFonts.latoTextTheme(
          Theme.of(context).textTheme.apply(
                bodyColor: kWhiteText,
                displayColor: kWhiteText,
              ),
        ),

        // Define Elevated Button Theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kMetallicGold,
            foregroundColor: kDarkBg, // Text color on button
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),

        // Define Input Decoration Theme for TextFields
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: const Color(0xFF2A2A2A),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          labelStyle: const TextStyle(color: kGreyText),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: const BorderSide(color: kMetallicGold, width: 2.0),
          ),
        ),

        // Define Card Theme
        cardTheme: CardThemeData(
          elevation: 2,
          color: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          clipBehavior: Clip.antiAlias,
        ),

        // Define AppBar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: kDarkBg,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: kWhiteText),
          titleTextStyle: TextStyle(
            color: kWhiteText,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),

        // Define Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: kMetallicGold,
          ),
        ),
      ),
      home: const AuthWrapper(),
    );
  }
}
