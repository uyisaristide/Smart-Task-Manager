import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:task_manager/utils/validatots.dart';

import '../../constants/_assets.dart';
import '../../providers/riverpod_providers/tasks_provider.dart';
import '../../utils/input_dec.dart';
import '../../utils/styles.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  var key = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    var userState = ref.watch(userProvider);
    return Scaffold(
      body: Form(
        key: key,
        child: ListView(
          padding: const EdgeInsets.all(20)
              .copyWith(top: MediaQuery.of(context).padding.top),
          children: [
            Image.asset(
              AssetsUtils.logo,
              height: 150,
            ),
            const SizedBox(
              height: 30,
            ),

            const Text(
              "Login",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextFormField(
                controller: emailController,
                validator: validateEmail,
                keyboardType: TextInputType.emailAddress,
                decoration: iDecoration(
                  hint: "Email",
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40),
              child: TextFormField(
                  controller: passwordController,
                  validator: (s) => s?.trim().isNotEmpty == true
                      ? null
                      : 'Password is required',
                  decoration: iDecoration(hint: "Password"),
                  obscureText: true),
            ),
            userState!.isLoading
                ? const Center(child: CircularProgressIndicator())
                : ElevatedButton(
                    style: StyleUtls.buttonStyle,
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        ref.read(userProvider.notifier).signIn(context,
                            emailController.text, passwordController.text);
                      }
                    },
                    child: const Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
            // Align(
            //   alignment: Alignment.centerRight,
            //   child: TextButton(
            //       onPressed: () {
            //         context.go("/forgetPassword");
            //         //   Navigator.push(
            //         //       context,
            //         //       CupertinoPageRoute(
            //         //           builder: (context) => const ForgotPassword()));
            //       },
            //       child: const Text("Forgot Password ?")),
            // ),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "OR",
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
            OutlinedButton(
                style: StyleUtls.textButtonStyle,
                onPressed: () {
                  context.go('/newUser');
                },
                child: const Text("Register")),
          ],
        ),
      ),
    );
  }
}
