import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Session extends Notifier<bool> {
  @override
  bool build() => false;

  void login() {
    state = true;
  }

  void logout() {
    state = false;
  }
}

final sessionProvider = NotifierProvider<Session, bool>(() => Session());

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isLoggedIn = ref.watch(sessionProvider);
    final sessionNotifier = ref.read(sessionProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isLoggedIn ? "Logged In" : "Logged Out",
              style: const TextStyle(fontSize: 24),
            ),
            ElevatedButton(
                onPressed:
                    isLoggedIn ? sessionNotifier.logout : sessionNotifier.login,
                child: Text(isLoggedIn ? "Logout" : "Login")),
          ],
        ),
      ),
    );
  }
}
