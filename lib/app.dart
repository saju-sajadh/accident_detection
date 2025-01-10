import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'screens/authenticate_screen.dart';
import 'screens/chat_bot.dart';
import 'screens/data_center_screen.dart';
import 'screens/em_contact_screen.dart';
import 'screens/help_center_screen.dart';
import 'screens/notification_screen.dart';
import 'screens/settings_screen.dart';
import 'widget/bottom_navbar.dart';
import './screens/landing_screen.dart';
import 'widget/error_page.dart';
import 'widget/loading_page.dart';

class MainApp extends ConsumerWidget {
  const MainApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    return MaterialApp(
      theme: ThemeData.light(),
      home: LandingScreen(),
      // home: ref.watch(currentUserAccountProvider).when(
      //     data: (user) {
      //       if (user != null) {
      //         return BottomNavBar();
      //       }
      //       return const LandingScreen();
      //     },
      //     error: (error, st) {
      //       print(error);
      //       return ServerDownPage();
      //     },
      //     loading: () => const LoadingPage()),
      debugShowCheckedModeBanner: false,
      routes: {
        '/landing': (context) => LandingScreen(),
        '/home': (context) => BottomNavBar(),
        '/signin': (context) => Authenticate(),
        '/settings': (context) => SettingsScreen(),
        '/notify': (context) => NotificationsScreen(),
        '/panel1': (context) => DataCenterScreen(),
        '/panel2': (context) => EmergencyContactScreen(),
        '/panel3': (context) => Chatbot(),
        '/panel4': (context) => SettingsScreen(),
        '/panel5': (context) => HelpCenterScreen(),
      },
    );
  }
}
