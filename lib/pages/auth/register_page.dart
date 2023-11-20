import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../components/custom_text.dart';
import '../../components/login_tile.dart';
import '../../components/my_button.dart';
import '../../services/auth_service.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
      } else {
        showErrorMessage("Passwords don't match!");
      }

      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      showErrorMessage("Account creation error!");
    }
  }

  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Colors.pink,
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),

                // icon
                const Icon(
                  Icons.lock,
                  size: 100,
                ),

                const SizedBox(height: 50),

                // Welcome sentence
                const Text(
                  'Let`s create an account for you!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                  ),
                ),

                const SizedBox(height: 40),

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

                const SizedBox(height: 25),

                // Confirm Password
                CustomText(
                  controller: confirmPasswordController,
                  hindText: 'Confrim Password',
                  obscureText: true,
                ),

                const SizedBox(height: 50),

                // Sign In
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
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

                    const SizedBox(height: 25),

                    LoginTile(
                      onTap: () => {},
                      imagePath: 'lib/images/apple.png',
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // Log in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                        'Log in now!',
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
