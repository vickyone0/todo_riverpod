import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_riverpod/providers/todo_provider.dart';

import '../models/todo.dart';

class CompleteTodo extends ConsumerWidget {
  const CompleteTodo({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    
    List<Todo> completeTodos = todos.where((todo) => todo.completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
      ),
      body: ListView.builder(
        itemCount: completeTodos.length,
        itemBuilder: (context, index) {
          
          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) =>
                      ref.watch(todoProvider.notifier).deleteTodo(completeTodos[index].todoId),
                  backgroundColor: Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  icon: Icons.delete,
                )
              ],
            ),
            
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.all(Radius.circular(20))),
              child:ListTile(
              title: Text(
                completeTodos[index].content,
              ),
            ),
            )
          );
          }
        
      ),
      
    );
  }
}
