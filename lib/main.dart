////Building a Register App with Flutter and Django

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Register App',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: const MyRegisterApp(title: 'Register App'),
    );
  }
}

class MyRegisterApp extends StatefulWidget {
  const MyRegisterApp({Key? key, required String title}) : super(key: key);

  @override
  State<MyRegisterApp> createState() => _MyRegisterAppState();
}

class _MyRegisterAppState extends State<MyRegisterApp> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          children: <Widget>[
            const SizedBox(height: 80.0),
            TextFormField(
              controller: _usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
              obscureText: true,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please enter some text';
                }
                return null;
              },
            ),
            const SizedBox(height: 12.0),
            SizedBox(
              height: 44.0,
              child: ElevatedButton(
                  child: const Text('login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await http.post(Uri.parse('http://10.0.2.2:8000/login/'),
                          body: {
                            'username': _usernameController.text,
                            'email': _emailController.text,
                            'password': _passwordController.text,
                          }).then((response) {
                        if (response.statusCode == 200) {
                          //msg pop up
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Success')));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Login Failed')));
                        }
                      });
                    }
                  }),
            ),
          ],
        ),
      ),
    );
  }
}
