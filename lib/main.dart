import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'invitation_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(statusBarColor: Colors.transparent),
  );
  runApp(const KerolosApp());
}

class KerolosApp extends StatelessWidget {
  const KerolosApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'سبوع جان',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF3A6A8C),
          background: const Color(0xFFFAF3E6),
        ),
        scaffoldBackgroundColor: const Color(0xFFFAF3E6),
        fontFamily: 'Tajawal',
      ),
      home: const InvitationPage(),
    );
  }
}
