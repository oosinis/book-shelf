import 'package:book_shelf/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/custom_text.dart';
import '../../components/login_tile.dart';
import '../../components/my_button.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      authProblemMessage();
    }
  }

  void authProblemMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          backgroundColor: Colors.pink,
          title: Center(
            child: Text(
              'Wrong credentials',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomTheme.color1,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                // icon
                const Icon(
                  Icons.book,
                  size: 100,
                ),
                const SizedBox(height: 50),
                // Email
                CustomText(
                  controller: emailController,
                  hindText: 'Email',
                  obscureText: false,
                ),
                const SizedBox(height: 25),
                // Password
                CustomText(
                  controller: passwordController,
                  hindText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(height: 10),
                // Forgot password
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot password?',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                // Sign In
                MyButton(
                  text: "Sign In",
                  onTap: signUserIn,
                ),

                const SizedBox(height: 25),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(color: Colors.grey[700]),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),
                
                //google+apple
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoginTile(
                      onTap: () => AuthService().signInWithGoogle(),
                      imagePath: 'lib/images/google.jpg',
                    ),

                    const SizedBox(height: 55),

                    LoginTile(
                      onTap: () => {},
                      imagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),

                const SizedBox(height: 25),
                // Register
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Register now',
                        style: TextStyle(
                            color: Colors.pink, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
