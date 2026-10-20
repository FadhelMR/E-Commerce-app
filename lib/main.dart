import 'package:ecommerceapp/page/detail_chat.dart';
import 'package:ecommerceapp/page/list_chat.dart';
import 'package:flutter/material.dart';
import 'package:ecommerceapp/page/login_page.dart';
import 'package:ecommerceapp/page/register_page.dart';
import 'package:ecommerceapp/page/account_page.dart';
import 'package:ecommerceapp/page/change_password_page.dart';
import 'package:ecommerceapp/page/cart_page.dart';
import 'package:ecommerceapp/page/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(),
      routes: {
        '/login_page': (context) => const LoginPage(),
        '/register_page': (context) => const RegisterPage(),
        '/account_page': (context) => const AccountPage(),
        '/change_password_page': (context) => const ChangePasswordPage(),
        '/cart_page': (context) => const CartPage(),
        '/home_page': (context) => const HomePage(),
        '/list_chat': (context) => const ChatListPage(),
        '/detail_chat': (context) {
          final arguments = ModalRoute.of(context)?.settings.arguments;

          final contactName =
              arguments is Map && arguments['contactName'] is String
                  ? arguments['contactName'] as String
                  : 'Anonim';

          return ChatScreen(contactName: contactName);
        },
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center, children: [])),
    );
  }
}
