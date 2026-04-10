import 'package:chat_app/app/providers.dart';
import 'package:chat_app/core/config/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  runApp(AppProviders());
}
