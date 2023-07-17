import 'package:flutter/material.dart';
import 'package:todo/pages/account/signin.dart';
import 'package:todo/pages/create_task.dart';

class Tasks extends StatelessWidget {
  const Tasks({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        routes: {
          '/tasks': (context) => const Tasks(),
          '/create':(context) => const CreateTask(),
          '/signin':(context) => SignIn()
        },
        home: Builder(builder: (context) {
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
                      child: Text('Available Tasks!',
                          style: TextStyle(
                              fontWeight: FontWeight.w500, fontSize: 20)),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        'assets/images/4.png',
                        width: 20,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 50),
                      height: 300,
                      child: ListView(
                        children: const [
                          TodoCard(
                            taskName: 'Task 1',
                            description: 'Description 1',
                            startTime: '10:00 AM',
                            endTime: '12:00 PM',
                            priority: TodoPriority.high,
                          ),
                          TodoCard(
                            taskName: 'Task 2',
                            description: 'Description 2',
                            startTime: '1:00 PM',
                            endTime: '3:00 PM',
                            priority: TodoPriority.medium,
                          ),
                          TodoCard(
                            taskName: 'Task 3',
                            description: 'Description 3',
                            startTime: '4:00 PM',
                            endTime: '6:00 PM',
                            priority: TodoPriority.low,
                          ),
                          TodoCard(
                            taskName: 'Task 3',
                            description: 'Description 3',
                            startTime: '4:00 PM',
                            endTime: '6:00 PM',
                            priority: TodoPriority.low,
                          )
                        ],
                      ),
                    )
                  ])))
            ]),
            floatingActionButton: FloatingActionButton(
              backgroundColor: const Color.fromARGB(99, 83, 116, 95),
              onPressed: () {
                Navigator.pushNamed(context, '/create');
              },
              child: const Icon(Icons.add),
            ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          );
        }));
  }
}

enum TodoPriority { low, medium, high }

class TodoCard extends StatelessWidget {
  final String taskName;
  final String description;
  final String startTime;
  final String endTime;
  final TodoPriority priority;

  const TodoCard({
    Key? key,
    required this.taskName,
    required this.description,
    required this.startTime,
    required this.endTime,
    required this.priority,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color priorityColor;
    switch (priority) {
      case TodoPriority.high:
        priorityColor = Colors.red;
        break;
      case TodoPriority.medium:
        priorityColor = Colors.blue;
        break;
      case TodoPriority.low:
        priorityColor = Colors.green;
        break;
    }

    return Card(
      elevation: 4,
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: priorityColor,
        ),
        title: Text(taskName),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(description),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.timer),
                const SizedBox(width: 4),
                Text('$startTime - $endTime'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
