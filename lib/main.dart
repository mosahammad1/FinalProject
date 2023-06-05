import 'package:final_project/screens/login.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(home: Splash(),) );
}

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  goLogin() async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) {
      return const Login();
    }));
  }

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3));
    goLogin();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          
          // child: Text(
          //   "Welcome In my Project",
          //   style: TextStyle(
          //       color: Colors.black, fontWeight: FontWeight.bold, fontSize: 20),
          // ),
        ),
      ),
    );
  }
}
