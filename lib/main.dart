import 'package:flutter/material.dart';
import '/helpers/user_info.dart';
import '/ui/login_page.dart';
import '/ui/catatan_transaksi_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget page = const CircularProgressIndicator();

  @override
  void initState() {
    super.initState();
    isLogin();
  }

  void isLogin() async {
    var token = await UserInfo().getToken();
    if (token != null) {
      setState(() {
        page = const CatatanTransaksiPage();
      });
    } else {
      setState(() {
        page = const LoginPage();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Catatan Transaksi',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Verdana',
        primaryColor: Colors.red,
        colorScheme:
            ColorScheme.fromSwatch().copyWith(secondary: Colors.orange),
        scaffoldBackgroundColor: Colors.yellow,
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.green),
          bodyMedium: TextStyle(color: Colors.blue),
          headlineLarge: TextStyle(color: Colors.indigo),
          headlineMedium: TextStyle(color: Colors.purple),
        ),
        appBarTheme: const AppBarTheme(
          color: Colors.red,
        ),
        buttonTheme: const ButtonThemeData(
          buttonColor: Colors.green,
          textTheme: ButtonTextTheme.primary,
        ),
      ),
      home: page,
    );
  }
}
