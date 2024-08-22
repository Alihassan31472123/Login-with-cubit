import 'package:auth_app/cubits/LoginCubit/loginState.dart';
import 'package:auth_app/cubits/LoginCubit/logincubit.dart';
import 'package:auth_app/ui/Screens/HomeScreen.dart';
import 'package:auth_app/ui/animations/navigationAnimation.dart';
import 'package:auth_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(),
      child: Scaffold(
        body: Stack(
          children: [
            // Background color and image
            Container(
              decoration: const BoxDecoration(
                color: AppColors.Loginbackground,
              ),
            ),
            Positioned.fill(
              child: Image.asset(
                'assets/images/Rectangle.png',
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocConsumer<LoginCubit, LoginState>(
                  listener: (context, state) {
                    if (state is LoginSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else if (state is LoginError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            state.message,
                            style: const TextStyle(color: Colors.black),
                          ),
                          behavior: SnackBarBehavior.floating,
                          padding: const EdgeInsets.all(16),
                        ),
                      );
                    }
                  },
                  builder: (context, state) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Text(
                            'Log in!',
                            style: GoogleFonts.poppins(
                              color: AppColors.logintext,
                              fontSize: 41,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: emailController,
                            decoration: const InputDecoration(
                                hintText: 'Email',
                                hintStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                prefixIcon: Icon(
                                  Icons.alternate_email,
                                  color: Colors.white,
                                )),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: passwordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                                hintText: 'Password',
                                hintStyle: TextStyle(color: Colors.white70),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.white,
                                )),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 32),
                        Padding(
                          padding: const EdgeInsets.only(left: 80, right: 80),
                          child: SizedBox(
                            width: 100,
                            height: 39,
                            child: ElevatedButton(
                              onPressed: () {
                                if (state is! LoginLoading) {
                                  if (passwordController.text.isNotEmpty &&
                                      emailController.text.isNotEmpty) {
                                    context.read<LoginCubit>().login(
                                          emailController.text,
                                          passwordController.text,
                                        );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.white,
                                        content: Text(
                                          'Both fields are required!',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        behavior: SnackBarBehavior.floating,
                                        padding: EdgeInsets.all(16),
                                      ),
                                    );
                                  }
                                }
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.white, // Background color
                                foregroundColor: Colors.white, // Text color
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                padding:
                                    EdgeInsets.zero, // Remove extra padding
                              ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Opacity(
                                    opacity: state is LoginLoading ? 0.0 : 1.0,
                                    child: const Text(
                                      'Login',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  if (state is LoginLoading)
                                    const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              "Create your account?",
                              style: TextStyle(color: Colors.white),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white70, // Text color
                              ),
                              onPressed: () {
                                Navigator.of(context).push(Registerroute());
                              },
                              child: const Text('Register'),
                            ),
                          ],
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
