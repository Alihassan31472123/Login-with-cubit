import 'package:auth_app/cubits/LoginCubit/loginState.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginCubit extends Cubit<LoginState> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  LoginCubit() : super(LoginInitial());

  Future<void> login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      emit(LoginError("Email and password cannot be empty"));
      return;
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      emit(LoginError("Invalid email format"));
      return;
    }
    emit(LoginLoading());

    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(LoginSuccess(userCredential.user));
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        try {
          UserCredential userCredential = await _auth
              .createUserWithEmailAndPassword(email: email, password: password);
          emit(LoginSuccess(userCredential.user));
        } on FirebaseAuthException catch (e) {
          emit(LoginError(e.message ?? "An error occurred"));
        }
      } else {
        emit(LoginError(e.message ?? "An error occurred"));
      }
    }
  }

  Future<void> logout() async {
    await _auth.signOut();
    emit(LoginInitial());
  }
}
