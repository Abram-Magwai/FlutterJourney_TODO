// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo/components/text_with_link.dart';
import 'package:todo/components/todo_button.dart';
import '../../components/text_form_field_decoration.dart';
import '../../components/text_form_field_validator.dart';
import 'signin.dart';

// ignore: must_be_immutable
class SignUp extends StatelessWidget {
  SignUp({super.key});
  final _formKey = GlobalKey<FormState>();

  late String _fullName;
  late String _emailAddress;
  late String _password;
  late String _confirmPassword;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signin': (context) => SignIn(),
      },
        home: Builder(
          builder: (context) {
            return Scaffold(
                backgroundColor: const Color.fromARGB(255, 236, 236, 236),
                body: Stack(children: [
                  Positioned(
                    left: -100,
                    top: -100,
                    child: Container(
                      width: 200.0,
                      height: 200.0,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color.fromARGB(99, 83, 116, 95),
                      ),
                    ),
                  ),
                  Positioned(
                      top: 30,
                      child: IconButton(
                        icon: const Icon(
                          Icons.arrow_circle_left_outlined,
                          size: 35,
                        ),
                        onPressed: () {
                          Navigator.popAndPushNamed(context, '/signin');
                        },
                      )),
                  Positioned(
                      left: -20,
                      top: -150,
                      child: Container(
                        width: 200.0,
                        height: 200.0,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color.fromARGB(99, 83, 116, 95),
                        ),
                      )),
                  Container(
                      margin: const EdgeInsets.only(top: 150),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Center(
                        child: ListView(children: [
                          const Center(
                            child: Text('Welcome Onboard!',
                                style: TextStyle(
                                    fontWeight: FontWeight.w500, fontSize: 20)),
                          ),
                          Center(
                            child: Container(
                                margin: const EdgeInsets.only(top: 20),
                                child: const Text(
                                  'Let\'s help you meet up your task',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: Color.fromARGB(255, 83, 116, 95)),
                                )),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Form(
                                key: _formKey,
                                child: Column(
                                  children: [
                                    TextFormField(
                                      decoration: textFormFieldDecoration(
                                          'Enter your Full Name'),
                                      validator: textFormFieldValidator(
                                          'Please enter your full name'),
                                      onSaved: (value) {
                                        _fullName = value!;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textFormFieldDecoration(
                                          'Enter your Email Address'),
                                      validator: textFormFieldValidator(
                                          'Please enter your email address'),
                                      onSaved: (value) {
                                        _emailAddress = value!;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      decoration: textFormFieldDecoration(
                                          'Create a Password'),
                                      validator: textFormFieldValidator(
                                          'Please create your password'),
                                      onSaved: (value) {
                                        _password = value!;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    TextFormField(
                                      obscureText: true,
                                      decoration: textFormFieldDecoration(
                                          'Confirm your Password'),
                                      validator: textFormFieldValidator(
                                          'Passwords don\'t match'),
                                      onSaved: (value) {
                                        _confirmPassword = value!;
                                      },
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    Flex(direction: Axis.horizontal, children: [
                                      Expanded(
                                          child: todoButton(() {
                                        if (_formKey.currentState!.validate()) {
                                          _formKey.currentState!.save();
                                          // Do something with the form data
                                          print(_fullName);
                                          print(_emailAddress);
                                          print(_password);
                                          print(_confirmPassword);
                                          Navigator.pushNamed(context, '/signin');
                                        }
                                      }, 'Sign Up'))
                                    ]),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    textWithLink(context, 'Already have an accont?',
                                        'Sign In', SignIn())
                                  ],
                                )),
                          )
                        ]),
                      ))
                ]));
          }
        ));
  }
}
