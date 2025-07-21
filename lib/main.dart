import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/resources/firebase_methods.dart';
import 'package:clone_zoom/screens/inner_screens/video_call_screen.dart';
import 'package:clone_zoom/screens/login_screen.dart';
import 'package:clone_zoom/screens/welcome_screen.dart';
import 'package:clone_zoom/screens/main_screen.dart';
import 'package:clone_zoom/screens/register_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
  } catch (e) {
    debugPrint('--- Error by initializing Firebase: $e ---');
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FLutter Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor,
      ),
      routes: {
        '/welcome': (context) => const WelcomeScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/main': (context) => const MainScreen(),
        '/video-call': (context) => const VideoCallScreen(),
      },
      home: StreamBuilder(
        stream: firebaseAuth.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              return MainScreen();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Some errors occured: ${snapshot.error}'),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }
          return const WelcomeScreen();
        },
      ),
    );
  }
}
