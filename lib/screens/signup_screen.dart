// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery_app/repositories/authentication_repository.dart';

import '../cubits/signup/signup_cubit.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});
  static const String routeName = '/signup-screen';

  static Route route() {
    return MaterialPageRoute(
        builder: (_) => const SignupScreen(),
        settings: const RouteSettings(name: routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Sign Up",
          style: Theme.of(context).textTheme.headline3,
        ),
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (_) => SignupCubit(context.read<AuthenticationRepository>()),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: BlocListener<SignupCubit, SignupState>(
            listener: (context, state) {
              if (state.status == SignupStatus.error) {
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
                  SizedBox(height: 8),
                  _SignupButton()
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
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return TextFormField(
          onChanged: (email) {
            context.read<SignupCubit>().emailChanged(email);
          },
          decoration: InputDecoration(
              labelText: "Email",
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0))),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      buildWhen: (previous, current) => previous.password != previous.password,
      builder: (context, state) {
        return TextFormField(
          obscureText: true,
          onChanged: (password) {
            context.read<SignupCubit>().passwordChanged(password);
          },
          decoration: InputDecoration(
              labelText: "Password",
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
        );
      },
    );
  }
}

class _SignupButton extends StatelessWidget {
  const _SignupButton();

  @override
  Widget build(BuildContext context) {
    // return BlocBuilder<SignupCubit, SignupState>(
    //   buildWhen: (previous, current) => previous.status != current.status,
    //   builder: (context, state) {
    //     return state.status == SignupStatus.submitting
    //         ? const CircularProgressIndicator()
    //         : ElevatedButton(
    //             onPressed: () {
    //               context.read<SignupCubit>().signupFormSubmitted();
    //               if (state.status == SignupStatus.success) {
    //                 Navigator.of(context).pop();
    //               }
    //             },
    //             child: const Text("Signup"),
    //           );
    //   },
    // );
    return BlocConsumer<SignupCubit, SignupState>(builder: (context, state) {
      return state.status == SignupStatus.submitting
          ? const CircularProgressIndicator()
          : ElevatedButton(
              onPressed: () {
                context.read<SignupCubit>().signupFormSubmitted();
              },
              child: const Text("Signup"));
    }, listener: (context, state) {
      if (state.status == SignupStatus.success) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Signup successful")));
        Navigator.of(context).pop();
      } else if (state.status == SignupStatus.error) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Signup failed")));
      }
    });
  }
}
