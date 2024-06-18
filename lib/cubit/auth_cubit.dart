import 'package:bloc/bloc.dart';
import 'package:flutter_navigation_1/api/auth_services.dart';
import 'package:flutter_navigation_1/model/auth_model.dart';
import 'package:meta/meta.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      emit(AuthLoading());

      AuthModel authModel = await AuthServices().login(email, password);

      emit(AuthSuccess(authModel));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
