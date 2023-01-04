import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your email';
                }
                return null;
              },
              onSaved: (value) => _email = value!,
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              validator: (value) {
                if (value?.isEmpty ?? true) {
                  return 'Please enter your password';
                }
                return null;
              },
              onSaved: (value) => _password = value!,
              obscureText: true,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? true) {
                  _formKey.currentState?.save();
                  login(
                    context,
                    email: _email,
                    password: _password,
                  );
                }
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                print('register');
              },
              child: const Text('S\'inscrire'),
            ),
          ],
        ),
      ),
    );
  }
}

login(BuildContext context,
    {required String email, required String password}) async {
  final pb = PocketBase('http://127.0.0.1:8090');

  final authData = await pb.collection('users').authWithPassword(
        email,
        password,
      );
  print(authData.record!.id);
// after the above you can also access the auth data from the authStore
  print(pb.authStore.isValid);
  print(pb.authStore.token);
  print(pb.authStore.model.id);

// "logout" the last authenticated account
  pb.authStore.clear();
  if (authData.record?.id != null) {
    Navigator.of(context).pushReplacementNamed('/home');
  }
}
