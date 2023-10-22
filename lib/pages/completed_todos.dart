import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/pages/add_page.dart';
import 'package:to_do/providers/todo_providers.dart';
import '../modals/modal_todo.dart';
class Completed extends ConsumerWidget {
  const Completed({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context ,WidgetRef ref) {
    List<Todo> todos = ref.watch(TodoProvider);

    List<Todo> CompletedTodos = todos.where((todo) => todo.Completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text("आज बहुत काम हो गया पार्थ भाई"),
        backgroundColor: Color.fromRGBO( 210, 180, 140,100),
      ),
      body: Padding(
        padding: EdgeInsets.all(10),
        child: ListView.builder(
            itemCount: CompletedTodos.length ,
            itemBuilder: (context ,index){
                if(CompletedTodos.length == 0){
                  return Center(
                    child: TextButton(onPressed: (){
                      Navigator.push(context, MaterialPageRoute(
                          builder:
                              (context)=> Add()));}, child: Text("Next Task")),
                  );
              }
              else{
                return Slidable(
                  startActionPane: ActionPane(
                      motion: ScrollMotion(), children: [
                    SlidableAction(
                      onPressed: (context)=>
                          ref.watch(TodoProvider.notifier).DeleteTodo(CompletedTodos[index].todoId),
                      backgroundColor: Colors.red,
                      icon: Icons.delete_forever_rounded,
                      padding: EdgeInsets.all(10),
                      borderRadius: BorderRadius.circular(6),
                    ),
                  ]),

                  child:  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color.fromRGBO(209, 190, 168,100),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: ListTile(
                        title: Text(CompletedTodos[index].content),
                      ),
                    ),
                  ),
                );

              }}),
      ),

    );
  }
}
