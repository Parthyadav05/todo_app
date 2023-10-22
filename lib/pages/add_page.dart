import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:to_do/pages/home_page.dart';
import 'package:to_do/providers/todo_providers.dart';
class Add extends ConsumerWidget {
  const Add({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    TextEditingController taskController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(245, 222, 179, 100),
        title: Text("आज कुछ करते हे पार्थ" ,style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(15),
            child: TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
              controller: taskController,
            ),
          ),
          ElevatedButton(onPressed: (){
             ref.read(TodoProvider.notifier).AddTodo(taskController.text);
             Navigator.push(context, MaterialPageRoute(builder: (context) => Homepage()));
          },style: ButtonStyle(
            elevation: MaterialStatePropertyAll(30),
            backgroundColor: MaterialStatePropertyAll<Color>(Color.fromRGBO(159, 129, 112, 100)),
          ), child: Text("Add Task"))
        ],
      ),
    );
  }
}
