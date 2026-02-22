import 'package:flutter/material.dart';

import 'core/constants/app_constants.dart';
import 'core/theme/app_theme.dart';

import 'features/auth/presentation/screens/logic_screen.dart';
import 'features/auth/presentation/screens/spalsh_screen.dart';
import 'features/chat/presentation/screens/conversations_screen.dart';
import 'features/chat/presentation/screens/chat_screen.dart';
import 'features/profile/presentation/screens/profile_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: AppConstants.appName,
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.system,

      initialRoute: AppConstants.splashRoute,

      routes: {
        AppConstants.splashRoute: (_) =>
        const SplashScreen(),

        AppConstants.loginRoute: (_) =>
        const LoginScreen(),

        AppConstants.conversationsRoute: (_) =>
        const ConversationsScreen(),

        AppConstants.profileRoute: (_) =>
        const ProfileScreen(),
      },

      onGenerateRoute: (settings) {
        if (settings.name == AppConstants.chatRoute) {
          final conversationId =
          settings.arguments as String;

          return MaterialPageRoute(
            builder: (_) =>
                ChatScreen(conversationId: conversationId),
          );
        }

        return null;
      },
    );
  }
}