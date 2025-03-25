import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr/infrastructure/auth/notifier/auth_notifier.dart';
import 'package:jr/themes/widgets/auth_text_field.dart';

class SignupPage extends ConsumerWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();
    final passwordController = TextEditingController();

    final authState = ref.watch(authNotifierProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Sign Up")),
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
                          .signUp(emailController.text, passwordController.text);
                      Navigator.pop(context);
                    },
                    child: const Text("Create Account"),
                  ),
            if (authState.hasError)
              Text(authState.error.toString(), style: const TextStyle(color: Colors.red)),
          ],
        ),
      ),
    );
  }
}
