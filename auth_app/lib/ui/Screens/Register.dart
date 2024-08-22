import 'package:auth_app/cubits/RegisterCubit/registercubit.dart';
import 'package:auth_app/cubits/RegisterCubit/registerstate.dart';
import 'package:auth_app/ui/Screens/HomeScreen.dart';
import 'package:auth_app/ui/animations/navigationAnimation.dart';
import 'package:auth_app/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegisterScreen extends StatefulWidget {
  RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterCubit(),
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
                'assets/images/Rectangle.png', // Your background image
                fit: BoxFit.cover,
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: BlocConsumer<RegisterCubit, RegisterState>(
                  listener: (context, state) {
                    if (state is RegisterSuccess) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => HomeScreen()),
                      );
                    } else if (state is RegisterError) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.white,
                          content: Text(
                            state.message,
                            style: TextStyle(color: Colors.black),
                          ),
                          behavior: SnackBarBehavior.floating,
                          padding: EdgeInsets.all(16),
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
                            'Register!',
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
                            controller: nameController,
                            decoration: const InputDecoration(
                              hintText: 'Name',
                              hintStyle: TextStyle(color: Colors.white70),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.white,
                              ),
                            ),
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16),
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
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          child: TextField(
                            controller: passwordController,
                            obscureText: _obscureText,
                            decoration: InputDecoration(
                              hintText: 'Password',
                              hintStyle: const TextStyle(color: Colors.white70),
                              enabledBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: const UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                color: Colors.white,
                              ),
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscureText
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                              ),
                            ),
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
                                if (state is! RegisterLoading) {
                                  if (passwordController.text.isNotEmpty &&
                                      emailController.text.isNotEmpty &&
                                      nameController.text.isNotEmpty) {
                                    context.read<RegisterCubit>().register(
                                          emailController.text,
                                          passwordController.text,
                                          nameController.text,
                                        );
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        backgroundColor: Colors.white,
                                        content: Text(
                                          'All fields are required!',
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
                                    opacity:
                                        state is RegisterLoading ? 0.0 : 1.0,
                                    child: const Text(
                                      'Register',
                                      style: TextStyle(color: Colors.black),
                                    ),
                                  ),
                                  if (state is RegisterLoading)
                                    SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: const CircularProgressIndicator(
                                        color: Colors.black,
                                        strokeWidth: 3,
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Row(mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("already have an account?",style: TextStyle(color: Colors.white),),
                            TextButton(
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.white70, // Text color
                              ),
                              onPressed: () {
                                Navigator.of(context).push(Loginroute());
                              },
                              child: Text('Login'),
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
