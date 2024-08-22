import 'package:auth_app/cubits/LoginCubit/logincubit.dart';
import 'package:auth_app/cubits/RegisterCubit/registercubit.dart';
import 'package:auth_app/ui/Screens/LoginScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MultiBlocProvider(providers: [
    BlocProvider<RegisterCubit>(
      create: (context) => RegisterCubit(),
    ),
     BlocProvider<LoginCubit>(
      create: (context) => LoginCubit(),
    ),
    //We Can Add other Cubits or BlocProviders here if needed
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login with Cubit',
      home: BlocProvider(
        create: (context) => LoginCubit(),
        child: LoginScreen(),
      ),
    );
  }
}
