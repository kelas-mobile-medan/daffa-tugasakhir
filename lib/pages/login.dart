import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tugasakhir/cubit/auth_cubit.dart';
import 'package:tugasakhir/pages/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool isShowPassword = true;

  @override
  void initState() {
    super.initState();
    checkSessionLogin();
  }

  checkSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      bool isLogin = prefs.getBool('is_login') ?? false;
      if (isLogin) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => Home(
                      username: _usernameController.text,
                    )));
      }
    });
  }

  saveSessionLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_login', true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title of the Login Page
              Text(
                'Welcome to MyShop',
                style: Theme.of(context).textTheme.headline4?.copyWith(
                      color: Colors.blueAccent,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              const Text(
                'Please enter your username and password to continue',
                style: TextStyle(fontSize: 16),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 25),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Username is required';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 15),
                    TextFormField(
                      controller: _passwordController,
                      obscureText: isShowPassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            isShowPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isShowPassword = !isShowPassword;
                            });
                          },
                        ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Password is required';
                        } else if (value.length < 8) {
                          return 'Password must be at least 8 characters';
                        }
                        return null;
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 25),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // username : eve.holt@reqres.in
                      // password : cityslicka

                      context.read<AuthCubit>().login(
                          _usernameController.text, _passwordController.text);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: BlocConsumer<AuthCubit, AuthState>(
                    listener: (context, state) {
                      if (state is AuthFailed) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      } else if (state is AuthSuccess) {
                        String username = _usernameController.text;

                        saveSessionLogin();

                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Home(username: username),
                          ),
                        );
                      }
                    },
                    builder: (context, state) {
                      if (state is AuthLoading) {
                        return const CircularProgressIndicator(
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.white),
                        );
                      } else {
                        return const Text('Login');
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
