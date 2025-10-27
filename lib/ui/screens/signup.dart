import 'package:flutter/material.dart';
import '../widgets/gradient_button.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _fullName = TextEditingController();
  final _username = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  bool _showPassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text('snapNshare',
                  style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold)),
              const SizedBox(height: 12),
              CircleAvatar(
                  radius: 48,
                  backgroundColor: Colors.grey[300],
                  child: const Icon(Icons.person, size: 40)),
              const SizedBox(height: 12),
              TextField(
                  controller: _fullName,
                  decoration: const InputDecoration(labelText: 'Full Name')),
              const SizedBox(height: 8),
              TextField(
                  controller: _username,
                  decoration: const InputDecoration(labelText: 'Username')),
              const SizedBox(height: 8),
              TextField(
                  controller: _email,
                  decoration: const InputDecoration(labelText: 'Email')),
              const SizedBox(height: 8),
              TextField(
                controller: _password,
                obscureText: !_showPassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  suffixIcon: IconButton(
                      icon: Icon(_showPassword
                          ? Icons.visibility_off
                          : Icons.visibility),
                      onPressed: () =>
                          setState(() => _showPassword = !_showPassword)),
                ),
              ),
              const SizedBox(height: 12),
              GradientButton(
                  onPressed: () =>
                      Navigator.of(context).pushReplacementNamed('/home'),
                  child: const Text('Sign Up')),
              const SizedBox(height: 12),
              TextButton(
                  onPressed: () => Navigator.of(context).pushNamed('/login'),
                  child: const Text('Already have an account? Log In'))
            ],
          ),
        ),
      ),
    );
  }
}
