import 'package:clone_zoom/constants/assets.dart';
import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/resources/auth_methods.dart';
import 'package:clone_zoom/widgets/custom_text_button.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _authMethods = AuthMethods();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Start or join a Meeting',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: secondaryColor,
              ),
            ),
            const SizedBox(height: 20),
            Image.asset(Assets.icOnBoarding),
            const SizedBox(height: 38),
            CustomTextButton(
              backgroundColor: buttonColor,
              borderColor: secondaryColor,
              width: size.width - 20,
              onTap: () => Navigator.of(context).pushNamed('/login'),
              child: Text(
                'Email Sign In',
                style: TextStyle(
                  color: secondaryColor,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 14),
            CustomTextButton(
              backgroundColor: secondaryColor,
              borderColor: secondaryColor,
              width: size.width - 20,
              onTap: () async {
                // login with google
                bool res = await _authMethods.signInWithGoogle(context);
                if (res) {
                  Navigator.of(context).pushReplacementNamed('/main-screen');
                }
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(Assets.icGoogleIcon),
                  const SizedBox(width: 16),
                  Text(
                    'Google Sign In',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Need an account? ',
                  style: TextStyle(color: primaryColor, fontSize: 16),
                ),
                InkWell(
                  onTap: () => Navigator.of(context).pushNamed('/register'),
                  child: Text(
                    'Register',
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
