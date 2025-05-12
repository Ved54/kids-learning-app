import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'providers/app_provider.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppProvider()..initializeDummyData(),
      child: Consumer<AppProvider>(
        builder: (context, appProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Kids Learning App',
            theme: ThemeData(
              primaryColor: Colors.blue,
              brightness: appProvider.userProfile.isDarkMode
                  ? Brightness.dark
                  : Brightness.light,
              textTheme: GoogleFonts.comicNeueTextTheme(),
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.blue,
                brightness: appProvider.userProfile.isDarkMode
                    ? Brightness.dark
                    : Brightness.light,
              ),
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
