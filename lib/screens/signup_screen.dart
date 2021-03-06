import 'package:flutter/material.dart';
import 'package:products_app_flutter/providers/login_form_provider.dart';
import 'package:products_app_flutter/screens/screens.dart';
import 'package:products_app_flutter/services/services.dart';
import 'package:provider/provider.dart';

import '../theme/theme.dart';
import '../widgets/widgets.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  static const routeName = 'SignUp';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          child: Column(
            children: [
              const SizedBox(height: 250),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    Text(
                      'Sign Up',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 30),
                    ChangeNotifierProvider(
                      create: (context) => LoginFormProvider(),
                      child: const _LoginForm(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 50),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(
                      context, LoginScreen.routeName);
                },
                child: const Text(
                  'Do you have an account?',
                  style: AppTheme.text18Black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  const _LoginForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(
              hintText: 'Email',
              labelText: 'name@email.com',
              prefixIcon: Icon(Icons.alternate_email),
            ),
            onChanged: (value) {
              loginForm.email = value;
            },
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);
              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'The value entered is not a valid email';
            },
          ),
          TextFormField(
            autocorrect: false,
            obscureText: true,
            keyboardType: TextInputType.text,
            decoration: const InputDecoration(
              hintText: '**********',
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
            ),
            onChanged: (value) {
              loginForm.password = value;
            },
            validator: (value) {
              return (value != null && value.length >= 8)
                  ? null
                  : 'The password must be 8 or more characters';
            },
          ),
          const SizedBox(height: 30),
          MaterialButton(
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    final authService = Provider.of<AuthService>(
                      context,
                      listen: false,
                    );

                    if (!loginForm.isValidForm()) {
                      return;
                    }

                    loginForm.isLoading = true;

                    //
                    final String? errorMessage = await authService.createUser(
                      loginForm.email,
                      loginForm.password,
                    );
                    if (errorMessage == null) {
                      Navigator.pushReplacementNamed(
                          context, HomeScreen.routeName);
                    } else {
                      NotificationsService.showSnackBar(errorMessage);
                      loginForm.isLoading = false;
                    }
                  },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            disabledColor: Colors.grey,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 80,
                vertical: 15,
              ),
              child: Text(
                loginForm.isLoading ? 'Wait' : 'Login',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
