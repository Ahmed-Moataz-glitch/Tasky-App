import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:tasky/firebase_options.dart';
import 'package:tasky/views/pages/edit_task_page.dart';
import 'package:tasky/views/pages/home_page.dart';
import 'package:tasky/views/pages/login_page.dart';
import 'package:tasky/views/pages/onboarding_page.dart';
import 'package:tasky/views/pages/register_page.dart';
import 'package:tasky/views/widgets/app_routes.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:tasky/views/pages/splash_screen.dart';

final navigatorKey = GlobalKey<NavigatorState>();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseCrashlytics.instance.crash();
  await handleNotification();
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  debugPrint("Handling a background message: ${message.messageId}");
}

Future<void> handleNotification() async {
  // Handling background messages
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Taking permission
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    announcement: false,
    badge: true,
    carPlay: false,
    criticalAlert: false,
    provisional: false,
    sound: true,
  );

  debugPrint('User granted permission: ${settings.authorizationStatus}');
  // Handling foreground messages
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    debugPrint('Got a message whilst in the foreground!');
    debugPrint('Message data: ${message.data}');

    if (message.notification != null) {
      String title = message.notification!.title ?? '';
      String body = message.notification!.body ?? '';
      debugPrint('Message also contained a notification: Title: $title');
      debugPrint('Message also contained a notification: Body: $body');

      showDialog(
        context: navigatorKey.currentContext!,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: Text(body),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(navigatorKey.currentContext!).pop();
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    debugPrint('A new onMessageOpenedApp event was published!');
    debugPrint('Message data: ${message.data}');
    // final messageData = message.data;
    // if (messageData['task_title'] != null) {
      // Navigator.of(navigatorKey.currentContext!).pushNamed(
      //   AppRoutes.homePage,
      // );
    // }
    Navigator.of(navigatorKey.currentContext!).pushNamed(
      AppRoutes.homePage,
    );
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      routes: {
        AppRoutes.onboardingPage: (context) => const OnboardingPage(),
        AppRoutes.loginPage: (context) => const LoginPage(),
        AppRoutes.registerPage: (context) => const RegisterPage(),
        AppRoutes.homePage: (context) => const HomePage(),
        AppRoutes.editTaskPage: (context) => const EditTaskPage(),
      },
      initialRoute: FirebaseAuth.instance.currentUser == null ? AppRoutes.onboardingPage : AppRoutes.homePage,
    );
  }
}
