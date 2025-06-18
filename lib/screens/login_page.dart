import 'package:flutter/material.dart';
import '../widgets/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _loading = false;

  void _submit() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() => _loading = true);

      // Simula delay da API
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _loading = false);
        // Aqui, salvar local e navegar
        Navigator.of(context).pushReplacementNamed('/home');
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 50),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('UniALFA', style: theme.textTheme.headlineMedium?.copyWith(color: Colors.green)),
                const SizedBox(height: 16),
                Text('Login', style: theme.textTheme.titleLarge),
                const SizedBox(height: 40),
                TextFormField(
                  controller: _userController,
                  decoration: const InputDecoration(labelText: 'Usuário'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Informe o usuário' : null,
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Senha'),
                  validator: (v) => (v == null || v.isEmpty) ? 'Informe a senha' : null,
                ),
                const SizedBox(height: 30),
                CustomButton(label: 'Entrar', onPressed: _submit, isLoading: _loading),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
