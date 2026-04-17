import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/widgets/login_box.dart';
import 'package:chat_app/app/home_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  final VoidCallback toggle;
  LoginPage({super.key, required this.toggle});

  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          //Error
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
          //loaded
          if (state is Authenticated) {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => HomeRoute()),
              (route) => false,
            );
          }
        },
        builder: (context, state) {
          //authInitial and unauthenticated
          if (state is AuthInitial || state is Unauthenticated) {
            return Stack(
              children: [
                //Image
                Image.asset(
                  'assets/images/loginblackwhite.jpeg',
                  fit: BoxFit.cover,
                ),
                //Auth column
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    //Divider container
                    Container(
                      width: double.infinity,
                      height: 35,
                      color: theme.primary,
                    ),
                    SizedBox(height: 10),
                    //Auth Box
                    LoginBox(
                      emailController: emailController,
                      pwController: pwController,
                      //Login button tap
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            LoginRequested(
                              email: emailController.text,
                              pw: pwController.text,
                            ),
                          );
                        }
                      },
                      //login or register
                      toggle: toggle,
                      //form validation
                      formKey: formKey,
                    ),
                  ],
                ),
              ],
            );
          }
          //auth loading | auth loaded
          return Scaffold(body: Center(child: CircularProgressIndicator()));
        },
      ),
    );
  }
}
