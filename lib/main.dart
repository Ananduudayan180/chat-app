import 'package:chat_app/core/config/firebase_options.dart';
import 'package:chat_app/core/theme/light_mode.dart';
import 'package:chat_app/features/auth/data/repo/auth_repo_impl.dart';
import 'package:chat_app/features/auth/data/service/auth_service.dart';
import 'package:chat_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:chat_app/features/auth/presentation/pages/auth_switcher.dart';
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
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  //supabase
  await Supabase.initialize(
    url: 'https://ulwvmxsnfnaddbwnssvf.supabase.co',
    anonKey:
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InVsd3ZteHNuZm5hZGRid25zc3ZmIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NzQzNDQ2MTgsImV4cCI6MjA4OTkyMDYxOH0.XVpRoCotHVazq82qMLsW_0KZtdZcKnmPbiYTMiiwjok',
  );
  //instance
  final chatRepoImpl = ChatRepoImpl(
    chatService: ChatService(),
    messageService: MessageService(),
  );
  runApp(
    MultiBlocProvider(
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
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      home: AuthSwitcher(),
    );
  }
}
