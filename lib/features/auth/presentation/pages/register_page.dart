import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/widgets/register_box.dart';
import 'package:chat_app/features/chat/presentation/pages/chat_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback toggle;
  RegisterPage({super.key, required this.toggle});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
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
                'assets/images/registerblackwhite.jpeg',
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
                    color: theme.colorScheme.primary,
                  ),
                  SizedBox(height: 10),
                  //Auth Box
                  RegisterBox(
                    nameController: nameController,
                    emailController: emailController,
                    pwController: pwController,
                    //register button tap
                    onTap: () => context.read<AuthBloc>().add(
                      RegisterRequested(
                        name: nameController.text,
                        email: emailController.text,
                        pw: pwController.text,
                      ),
                    ),
                    //login or register
                    toggle: toggle,
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
