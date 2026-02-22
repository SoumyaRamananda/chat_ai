import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_core/firebase_core.dart';

import 'app.dart';
import 'firebase_options.dart';

import 'features/auth/auth_injection.dart';
import 'features/chat/chat_injection.dart';
import 'features/chat/domain/repositories/chat_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const Bootstrap());
}

class Bootstrap extends StatelessWidget {
  const Bootstrap({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ChatRepository>(
          create: (_) => ChatInjection.repository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => AuthInjection.authBloc(),
          ),
          BlocProvider(
            create: (context) => ChatInjection.chatBloc(
              context.read<ChatRepository>(),
            ),
          ),
        ],
        child: const MyApp(),
      ),
    );
  }
}