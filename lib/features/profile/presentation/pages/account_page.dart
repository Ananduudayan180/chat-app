import 'package:chat_app/core/widgets/my_textfield.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/utils/form_validator.dart';
import 'package:chat_app/features/profile/presentation/dialog/dialogs.dart';
import 'package:chat_app/features/profile/presentation/widgets/my_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AccountPage extends StatelessWidget {
  final String email;
  const AccountPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    final reAuthPwController = TextEditingController();
    final changeNameController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    void deleteAccount() {
      //enter pass
      Dialogs.showDialogBox(
        title: 'Delete account',
        actionText: 'Ok',
        context: context,
        content: Form(
          key: formKey,
          child: MyTextField(
            controller: reAuthPwController,
            hintText: 'Password',
            validator: FormValidator.pass,
            obscureText: true,
          ),
        ),

        onTap: () {
          if (formKey.currentState!.validate()) {
            Navigator.pop(context);
            //confirm delete
            Dialogs.showDialogBox(
              title: 'Confirm delete',
              content: Text('Delete your account?'),
              actionText: 'Delete account',
              context: context,
              actionColor: Colors.red,
              onTap: () {
                //dlt action
                context.read<AuthBloc>().add(
                  DeleteAcRequested(email: email, pw: reAuthPwController.text),
                );
                Navigator.pop(context);
              },
            );
          }
        },
      );
    }

    void changeName() {
      Dialogs.showDialogBox(
        title: 'Edit name',
        actionText: 'Change',
        context: context,
        content: Form(
          key: formKey,
          child: MyTextField(
            controller: changeNameController,
            hintText: 'Name',
            validator: FormValidator.name,
          ),
        ),
        onTap: () {
          //change name
          if (formKey.currentState!.validate()) {}
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios, size: 20),
        ),
        title: Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is Unauthenticated) {
            Navigator.of(context).pop();
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return Center(child: CircularProgressIndicator());
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Column(
              children: [
                //Edit name
                MyListTile(
                  title: 'Edit name',
                  onTap: changeName,
                  leadingIcon: Icons.edit_outlined,
                ),
                //delete accout
                MyListTile(
                  title: 'Delete account',
                  onTap: deleteAccount,
                  leadingIcon: Icons.delete_outline,
                  titleColor: Colors.red,
                  leadingColor: Colors.red,
                  trailingColor: Colors.red,
                  divider: false,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
