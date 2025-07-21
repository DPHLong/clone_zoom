import 'package:clone_zoom/constants/colors.dart';
import 'package:clone_zoom/resources/auth_methods.dart';
import 'package:clone_zoom/screens/welcome_screen.dart';
import 'package:clone_zoom/utils/utils.dart';
import 'package:clone_zoom/widgets/custom_text_button.dart';
import 'package:clone_zoom/widgets/input_text_field.dart';
import 'package:clone_zoom/widgets/user_avatar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final AuthMethods _authMethods = AuthMethods();
  Uint8List? _image;
  bool _isLoading = false;

  void _pickImageFromSource(ImageSource src) async {
    final pickedImage = await pickImage(src);
    setState(() => _image = pickedImage);
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(title: Text('Regsiter')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Center(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Stack(
                    children: [
                      UserAvatar(radius: 80, image: _image),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: IconButton(
                          iconSize: 40,
                          onPressed: () => showDialog(
                            context: context,
                            builder: (context) {
                              return SimpleDialog(
                                children: [
                                  SimpleDialogOption(
                                    onPressed: () {
                                      _pickImageFromSource(ImageSource.gallery);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('From Gallery'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () {
                                      _pickImageFromSource(ImageSource.camera);
                                      Navigator.of(context).pop();
                                    },
                                    child: Text('From Camera'),
                                  ),
                                  SimpleDialogOption(
                                    onPressed: () =>
                                        Navigator.of(context).pop(),
                                    child: Text('Cancel'),
                                  ),
                                ],
                              );
                            },
                          ),
                          icon: Icon(Icons.photo),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
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
                const SizedBox(height: 8),
                InputTextField(
                  controller: _usernameController,
                  shouldValidate: true,
                  labelText: 'Username',
                  hintText: 'Enter an Username',
                ),
                const SizedBox(height: 8),
                InputTextField(
                  controller: _bioController,
                  labelText: 'Bio',
                  hintText: 'Enter your Bio',
                ),
                const SizedBox(height: 32),
                CustomTextButton(
                  backgroundColor: buttonColor,
                  borderColor: secondaryColor,
                  width: size.width - 20,
                  onTap: () async {
                    if (_formKey.currentState!.validate()) {
                      setState(() => _isLoading = true);
                      final res = await _authMethods.signUpUser(
                        username: _usernameController.text,
                        email: _emailController.text,
                        password: _passwordController.text,
                        bio: _bioController.text,
                        profileImage: _image,
                      );
                      if (res) {
                        setState(() => _isLoading = false);
                        Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) {
                              return WelcomeScreen();
                            },
                          ),
                        );
                      } else {
                        setState(() => _isLoading = false);
                      }
                    }
                  },
                  child: _isLoading
                      ? const CircularProgressIndicator()
                      : Text(
                          'Register',
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
