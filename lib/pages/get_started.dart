import 'package:flutter/material.dart';
import 'package:todo/components/todo_button.dart';

import 'account/signin.dart';

class GetStarted extends StatelessWidget {
  const GetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/signin': (context) => SignIn(),
      },
      home: Builder(
        builder: (context) {
          return Scaffold(
            body: Stack(
              children: [
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
                  margin: const EdgeInsets.only(top: 100),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 300,
                        child: Image.asset('assets/images/1.png'),
                      ),
                      const Center(
                        child: Text(
                          'Get things done with TODO',
                          style:
                              TextStyle(fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                      ),
                      Center(
                          child: Container(
                        width: 300,
                        margin: const EdgeInsets.only(top: 50),
                        child: Column(
                          children: [
                            const Text(
                                'A Todo app is a simple application that helps users manage their tasks and to-do items. It allows users to create, view, update, and delete tasks, providing a convenient way to keep track of their daily responsibilities and stay organized'),
                            Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: Flex(direction: Axis.horizontal, children: [
                                Expanded(
                                  child: todoButton((){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));
                                  }, 'Get Started')
                                ),
                              ]),
                              
                            ),
                          ],
                        ),
                      ))
                    ],
                  ),
                ),
              ],
            ),
          );
        }
      ),
    );
  }
}
