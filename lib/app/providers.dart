import 'package:chat_app/app/app.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/chat/data/repo/chat_repo_impl.dart';
import 'package:chat_app/features/chat/data/service/chat_service.dart';
import 'package:chat_app/features/chat/data/service/message_service.dart';
import 'package:chat_app/features/chat/presentation/bloc/chat/chat_bloc.dart';
import 'package:chat_app/features/chat/presentation/bloc/message/message_bloc.dart';
import 'package:chat_app/features/profile/data/repo/profile_repo_impl.dart';
import 'package:chat_app/features/profile/data/service/profile_firestore_service.dart';
import 'package:chat_app/features/profile/data/service/profile_storage_service.dart';
import 'package:chat_app/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:chat_app/features/users/data/repo/users_repo_impl.dart';
import 'package:chat_app/features/users/data/service/users_service.dart';
import 'package:chat_app/features/users/presentation/bloc/users_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppProviders extends StatelessWidget {
  AppProviders({super.key});

  //instance
  final chatRepoImpl = ChatRepoImpl(
    chatService: ChatService(),
    messageService: MessageService(),
  );

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //Auth Bloc
        BlocProvider<AuthBloc>(
          create: (context) =>
              AuthBloc(authRepo: AuthRepoImpl(authService: AuthService()))
                ..add(CheckAuthStatus()),
        ),
        //Profile Bloc
        BlocProvider<ProfileBloc>(
          create: (context) => ProfileBloc(
            profileRepo: ProfileRepoImpl(
              firestoreService: ProfileFirestoreService(),
              storageService: ProfileStorageService(),
            ),
          ),
        ),
        //Users Bloc
        BlocProvider(
          create: (context) =>
              UsersBloc(usersRepo: UsersRepoImpl(userService: UsersService())),
        ),
        //Chat Bloc
        BlocProvider(create: (context) => ChatBloc(chatRepo: chatRepoImpl)),
        //Message Bloc
        BlocProvider(create: (context) => MessageBloc(chatRepo: chatRepoImpl)),
      ],
      child: const MyApp(),
    );
  }
}
