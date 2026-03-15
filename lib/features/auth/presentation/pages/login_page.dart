import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/widgets/login_box.dart';
import 'package:chat_app/features/chat/presentation/chat_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ColorScheme theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: BlocConsumer(
        listener: (context, state) {
          //Error
          if (state is AuthError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.errorMsg)));
          }
        },
        builder: (context, state) {
          //loding
          if (state is AuthLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          //loaded
          if (state is Authenticated) {
            return ChatHomePage();
          }
          //authInitial and unauthenticated
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
                      //login request
                      context.read<AuthBloc>().add(
                        LoginRequested(
                          email: emailController.text,
                          pw: pwController.text,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
