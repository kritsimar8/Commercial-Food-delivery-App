import 'package:flutter/material.dart';
import 'package:food_ordering_app/components/my_button.dart';
import 'package:food_ordering_app/components/my_textfield.dart';
import 'package:food_ordering_app/pages/home_page.dart';
import 'package:food_ordering_app/services/auth/auth_service.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void login() async {
    final _authService = AuthService();

    try {
      await _authService.signInWithEmailPassword(
          emailController.text, passwordController.text);
    } catch (e) {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text(e.toString()),
              ));
    }

    void forgotPw() {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                backgroundColor: Colors.red,
                title: const Text("user tapped forgot password"),
              ));
    }

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // resizeToAvoidBottomInset: false,
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Icon(
                Icons.lock_open_rounded,
                size: 100,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              Text("Food Delivery App",
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  )),
              const SizedBox(height: 25),

              MyTextField(
                  controller: emailController,
                  hintText: "Email",
                  key: Key('email'),
                  obsecureText: false),

              const SizedBox(height: 10),

              MyTextField(
                key: Key('password'),
                controller: passwordController,
                hintText: "Password",
                obsecureText: true,
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                  onPressed: login,
                  child: Container(
                      padding: EdgeInsets.all(25),
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.secondary,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                          child: Text('Sign In',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                fontSize: 16,
                              ))))),

              // MyButton(
              //   text:"Sign In",
              //    onTap:login),

              const SizedBox(height: 25),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  "Not a member",
                  style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: widget.onTap,
                  child: Text("Register now",
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontWeight: FontWeight.bold,
                      )),
                )
              ]),
            ]),
          ),
        ));
  }
}
