import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/resources/auth_methods.dart';
import 'package:clone_zoom/widgets/custom_text_button.dart';
import 'package:clone_zoom/widgets/input_text_field.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final AuthMethods _authMethods = AuthMethods();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InputTextField(
                  controller: _emailController,
                  textInputType: TextInputType.emailAddress,
                  isEmail: true,
                  shouldValidate: true,
                  labelText: 'E-Mail',
                  hintText: 'Enter your E-Mail',
                ),
                const SizedBox(height: 8),
                InputTextField(
                  controller: _passwordController,
                  isPassword: true,
                  shouldValidate: true,
                  labelText: 'Password',
                  hintText: 'Enter your Password',
                ),
                const SizedBox(height: 32),
                CustomTextButton(
                  backgroundColor: buttonColor,
                  borderColor: secondaryColor,
                  width: size.width - 20,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isLoading = true);
                      final res = await _authMethods.signInWithEmail(
                        email: _emailController.text,
                        password: _passwordController.text,
                      );
                      if (res) {
                        setState(() => _isLoading = false);
                        Navigator.of(context).pushReplacementNamed('/main');
                      } else {
                        setState(() => _isLoading = false);
                      }
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Login',
                          style: TextStyle(
                            color: secondaryColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
