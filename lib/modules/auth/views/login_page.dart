// import same as before...

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr/infrastructure/auth/notifier/auth_notifier.dart';
import 'package:jr/modules/auth/views/forgot_password_page.dart';
import 'package:jr/modules/auth/views/signup_page.dart';
import 'package:jr/themes/widgets/auth_text_field.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AuthTextField(controller: emailController, hintText: "Email"),
            const SizedBox(height: 10),
            AuthTextField(controller: passwordController, hintText: "Password", obscure: true),
            const SizedBox(height: 10),
            authState.isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                  onPressed: () async {
                    await ref
                        .read(authNotifierProvider.notifier)
                        .login(emailController.text, passwordController.text)
                        .then((value) => {print("Sucesssssssss")});
                  },
                  child: const Text("Login"),
                ),
            if (authState.hasError) Text(authState.error.toString(), style: const TextStyle(color: Colors.red)),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const ForgotPasswordPage()));
              },
              child: const Text("Forgot Password?"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (_) => const SignupPage()));
              },
              child: const Text("Don't have an account? Sign Up"),
            ),
          ],
        ),
      ),
    );
  }
}
