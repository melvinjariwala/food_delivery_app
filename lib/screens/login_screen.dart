// ignore_for_file: deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/cubits/login/login_cubit.dart';
import 'package:food_delivery_app/repositories/authentication_repository.dart';
import 'package:food_delivery_app/screens/home_screen.dart';
import 'package:food_delivery_app/screens/signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});
  static const String routeName = '/login-screen';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const LoginScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login", style: Theme.of(context).textTheme.headline3!),
        automaticallyImplyLeading: false,
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => LoginCubit(context.read<AuthenticationRepository>()),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener<LoginCubit, LoginState>(
            listener: (context, state) {
              if (state.status == LoginStatus.error) {
                // Error Handling
              }
            },
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _EmailInput(),
                  SizedBox(height: 20),
                  _PasswordInput(),
                  SizedBox(height: 20),
                  _LoginButton(),
                  SizedBox(height: 8),
                  _SignUpButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (email) {
            context.read<LoginCubit>().emailChanged(email);
          },
          decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0),
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor))),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != previous.password,
      builder: (context, state) {
        return TextField(
          obscureText: true,
          onChanged: (password) {
            context.read<LoginCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(
              labelText: "Password",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0))),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<LoginCubit, LoginState>(
    //   buildWhen: (previous, current) => previous.status != current.status,
    //   builder: (context, state) {
    //     return state.status == LoginStatus.submitting
    //         ? const CircularProgressIndicator()
    //         : ElevatedButton(
    //             onPressed: () {
    //               context.read<LoginCubit>().logInWithCredentials();
    //               print("LoginStatus : ${state.status}");
    //               //if (state.status == LoginStatus.success) {
    //               Navigator.pushNamed(context, HomeScreen.routeName);
    //               //}
    //             },
    //             child: const Text("Login"),
    //           );
    //   },
    // );
    return BlocConsumer<LoginCubit, LoginState>(builder: ((context, state) {
      return state.status == LoginStatus.submitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context.read<LoginCubit>().logInWithCredentials();
              },
              child: const Text("Login"));
    }), listener: (context, state) {
      print("state.status = ${state.status}");
      if (state.status == LoginStatus.success) {
        Navigator.pushNamed(context, HomeScreen.routeName);
      } else if (state.status == LoginStatus.error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Login failed")));
      }
    });
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => Navigator.pushNamed(context, SignupScreen.routeName),
      child: const Text("Signup"),
    );
  }
}
