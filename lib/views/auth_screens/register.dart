import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../constants/_assets.dart';
import '../../providers/riverpod_providers/tasks_provider.dart';
import '../../utils/input_dec.dart';
import '../../utils/styles.dart';
import '../../utils/validatots.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  var key = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  bool loading = false;

  final List<String> _categories = ["Customer", "Farmer"];

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
            const SizedBox(height: 80,),
            Image.asset(
              AssetsUtils.logo,
              height: 80,
            ),
            // Padding(
            //   padding: const EdgeInsets.all(0.0),
            //   child: Image.asset(AssetsUtils.logo),
            // ),
            const Text(
              "Register",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: TextFormField(
                controller: emailController,
                validator: validateEmail,
                decoration: iDecoration(hint: "Email address"),
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
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ElevatedButton(
                    style: StyleUtls.buttonStyle,
                    onPressed: () {
                      if (key.currentState!.validate()) {
                        ref.read(userProvider.notifier).signUp(context,
                            emailController.text, passwordController.text);
                      }
                    },
                    child: const Text(
                      "Register",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
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
                onPressed: () => context.go('/login'),
                child: const Text("Login"))
          ],
        ),
      ),
    );
  }
}
