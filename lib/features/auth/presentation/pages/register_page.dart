import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/widgets/register_box.dart';
import 'package:chat_app/app/home_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RegisterPage extends StatelessWidget {
  final VoidCallback toggle;
  RegisterPage({super.key, required this.toggle});

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final pwController = TextEditingController();
  final formKey = GlobalKey<FormState>();

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
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          context.read<AuthBloc>().add(
                            RegisterRequested(
                              name: nameController.text,
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
