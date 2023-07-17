// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:todo/pages/account/signup.dart';
import 'package:todo/pages/get_started.dart';

import '../../components/text_form_field_decoration.dart';
import '../../components/text_form_field_validator.dart';
import '../../components/text_with_link.dart';
import '../../components/todo_button.dart';
import '../tasks.dart';

// ignore: must_be_immutable
class SignIn extends StatelessWidget {
  SignIn({super.key});
  final _formKey = GlobalKey<FormState>();

  late String _emailAddress;
  late String _password;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/tasks': (context) => const Tasks(),
        '/start':(context) => const GetStarted()
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
                          Navigator.popAndPushNamed(context, '/start');
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
                          child: Text('Welcome, Sign In',
                              style: TextStyle(
                                  fontWeight: FontWeight.w500, fontSize: 20)),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 120,
                          child: Image.asset('assets/images/2.png'),
                        ),
                        Container(
                            margin: const EdgeInsets.only(top: 50),
                            child: Form(
                                key: _formKey,
                                child: Column(children: [
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
                                    obscureText: true,
                                    decoration: textFormFieldDecoration(
                                        'Enter your Password'),
                                    validator: textFormFieldValidator(
                                        'Please enter your password'),
                                    onSaved: (value) {
                                      _password = value!;
                                    },
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  const SizedBox(
                                      child: Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: Color.fromARGB(255, 83, 116, 95)),
                                  )),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Flex(direction: Axis.horizontal, children: [
                                    Expanded(
                                        child: todoButton(() {
                                      if (_formKey.currentState!.validate()) {
                                        _formKey.currentState!.save();
                                        print(_emailAddress);
                                        print(_password);
                                        Navigator.pushNamed(context, '/tasks');
                                      }
                                    }, 'Sign In'))
                                  ]),
                                  const SizedBox(
                                    height: 40,
                                  ),
                                  textWithLink(context, 'Dont have an account?',
                                      'Sign Up', SignUp())
                                ])))
                      ])))
                ]));
          }
        ));
  }
}
