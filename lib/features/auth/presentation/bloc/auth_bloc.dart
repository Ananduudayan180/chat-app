import 'package:chat_app/features/auth/domain/repo/auth_repo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepo _authRepo;
  AuthBloc({required AuthRepo authRepo})
    : _authRepo = authRepo,
      super(AuthInitial()) {
    //Login
    on<LoginRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authRepo.loginUser(event.email, event.pw);
        if (user != null) {
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthError(errorMsg: e.message ?? 'Login failed'));
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });

    //Register
    on<RegisterRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        final user = await _authRepo.registerUser(
          event.name,
          event.email,
          event.pw,
        );
        if (user != null) {
          emit(Authenticated());
        } else {
          emit(Unauthenticated());
        }
      } on FirebaseAuthException catch (e) {
        emit(AuthError(errorMsg: e.message ?? 'Register failed'));
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });

    //Logout
    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepo.logoutUser();
      } on FirebaseAuthException catch (e) {
        emit(AuthError(errorMsg: e.message ?? 'Logout failed'));
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });
  }
}
