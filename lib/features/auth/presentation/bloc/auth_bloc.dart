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
    //check auth status
    on<CheckAuthStatus>((event, emit) {
      final user = _authRepo.checkAuthStatus();
      if (user != null) {
        emit(Authenticated());
      } else {
        emit(Unauthenticated());
      }
    });

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
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
        emit(Unauthenticated());
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
        emit(Unauthenticated());
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
        emit(Unauthenticated());
      }
    });

    //Logout
    on<LogoutRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepo.logoutUser();
        emit(Unauthenticated());
      } on FirebaseAuthException catch (e) {
        emit(AuthError(errorMsg: e.message ?? 'Logout failed'));
      } catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });

    //delete account
    on<DeleteAcRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await _authRepo.deleteAccount(event.email, event.pw);
        emit(Unauthenticated());
      } on Exception catch (e) {
        emit(AuthError(errorMsg: e.toString()));
      }
    });
  }
}
