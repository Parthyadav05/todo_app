import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../modals/modal_todo.dart';

final TodoProvider = StateNotifierProvider<TodoNotifier, List<Todo>>((ref) {
     return TodoNotifier();
});

class TodoNotifier extends StateNotifier<List<Todo>> {
  TodoNotifier() : super([]);
  void AddTodo(String content){
    state = [
      ...state,
        Todo(content: content, todoId: state.isEmpty ? 0 : state[state.length - 1].todoId! + 1, Completed: false)
    ];
  }
  void CompletedTodo(int id){
      state =[
        for(final todo in state)
          if(todo.todoId == id)
            Todo(content: todo.content, todoId: todo.todoId, Completed: true)
          else
            todo
      ];
  }
  void DeleteTodo(int id){
   state = state.where((todo) => todo.todoId != id).toList();
  }

}
