import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jr/infrastructure/auth/notifier/auth_notifier.dart';
import 'package:jr/themes/widgets/auth_text_field.dart';

class ForgotPasswordPage extends ConsumerWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final emailController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Reset Password")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            AuthTextField(controller: emailController, hintText: "Enter your email"),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () async {
                await ref.read(authNotifierProvider.notifier).resetPassword(emailController.text);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Password reset email sent')),
                );
              },
              child: const Text("Send Reset Email"),
            ),
          ],
        ),
      ),
    );
  }
}
