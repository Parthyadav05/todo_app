import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/pages/add_page.dart';
import 'package:to_do/pages/completed_todos.dart';
import 'package:to_do/providers/todo_providers.dart';
import '../modals/modal_todo.dart';
 class Homepage extends ConsumerWidget {
   const Homepage({Key? key}) : super(key: key);
 
   @override
   Widget build(BuildContext context ,WidgetRef ref) {
     List<Todo> todos = ref.watch(TodoProvider);
     List<Todo> ActiveTodos = todos.where((todo) => todo.Completed == false).toList();
     List<Todo> CompletedTodos = todos.where((todo) => todo.Completed == true).toList();
     return Scaffold(
       appBar: AppBar(
         centerTitle: true,
         title: ActiveTodos.isEmpty ? Text("Todo App" ,style: TextStyle(color: Colors.black),):Text("पार्थ भाई कुछ करो अभी बहुत काम बाकी है!" ,style: TextStyle(color: Colors.black),),
         backgroundColor: Color.fromRGBO( 210, 180, 140,100),
       ),
       body: Padding(
         padding: EdgeInsets.all(10),
         child: ListView.builder(
             itemCount: ActiveTodos.length + 1 ,
             itemBuilder: (context ,index){
               if(ActiveTodos.isEmpty && CompletedTodos.isEmpty){
                 return Padding(
                   padding: const EdgeInsets.only(top:300.0),
                   child: const Center(
                     child: Text("कार्य जोड़ने के लिए नीचे दिए गए बटन का उपयोग करें" ,style: TextStyle(fontWeight:FontWeight.bold,fontSize: 15),),
                   ),
                 );
               }
              else if(ActiveTodos.length == index){
                 if(CompletedTodos.isEmpty){
                   return Container();
                 }
                 else{
                   return Center(
                     child: TextButton(onPressed: (){
                       Navigator.push(context, MaterialPageRoute(
                       builder:
                        (context)=> Completed()));}, child: Text("Completed Task")),
                   );
                 }
               }
               else{
             return Slidable(
              startActionPane: ActionPane(motion: ScrollMotion(), children: [
                 SlidableAction(
                   onPressed: (context)=>
                     ref.watch(TodoProvider.notifier).DeleteTodo(ActiveTodos[index].todoId),
                     backgroundColor: Colors.red,
                   icon: Icons.delete_forever_rounded,
                   padding: EdgeInsets.all(10),
                   borderRadius: BorderRadius.circular(6),
               ),
             ]),
             endActionPane: ActionPane(motion: ScrollMotion(), children: [
               SlidableAction(
                 onPressed: (context)=>
                     ref.watch(TodoProvider.notifier).CompletedTodo(ActiveTodos[index].todoId),
                 backgroundColor: Colors.greenAccent,
                 icon: Icons.check,
                 padding: EdgeInsets.all(10),
                 borderRadius: BorderRadius.circular(6),
               ),
             ]),
             child: Padding(
               padding: const EdgeInsets.all(8.0),
               child: Container(
                 decoration: BoxDecoration(
                   color: Color.fromRGBO(209, 190, 168,100),
                   borderRadius: BorderRadius.circular(12),
                 ),
                 child: ListTile(
                   title: Text(ActiveTodos[index].content),
                 ),
               ),
             ),
           );

         }}),
       ),
       floatingActionButton: FloatingActionButton(
         onPressed: (){
           Navigator.push(context, MaterialPageRoute(builder: (context) => Add()));
         },
         child: Icon(Icons.add),

         shape: BeveledRectangleBorder(
             borderRadius: BorderRadius.circular(4)
         ),
         elevation: 40,
         tooltip: "Add Task",
         backgroundColor:Color.fromRGBO(159, 129, 112, 100) ,
         hoverColor: Color.fromRGBO(239, 222, 205, 4),
       ),
     );
   }
 }
 