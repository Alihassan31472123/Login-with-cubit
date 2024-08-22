import 'package:auth_app/cubits/RegisterCubit/registerstate.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';


class RegisterCubit extends Cubit<RegisterState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RegisterCubit() : super(RegisterInitial());

  Future<void> register(String email, String password, String name) async {
    if (email.isEmpty || password.isEmpty || name.isEmpty) {
      emit(RegisterError("All fields are required!"));
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emit(RegisterError("Invalid email format!"));
      return;
    }

    emit(RegisterLoading());

    try {
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Optionally update user profile with the name
      await userCredential.user?.updateDisplayName(name);

      emit(RegisterSuccess());
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        emit(RegisterError("This email is already registered."));
      } else if (e.code == 'weak-password') {
        emit(RegisterError("The password provided is too weak."));
      } else {
        emit(RegisterError("Registration failed. Please try again."));
      }
    } catch (e) {
      emit(RegisterError("An unexpected error occurred. Please try again."));
    }
  }
}
