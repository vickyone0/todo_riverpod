import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_riverpod/pages/add.dart';
import 'package:todo_riverpod/pages/completed.dart';
import 'package:todo_riverpod/providers/todo_provider.dart';

import '../models/todo.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todos = ref.watch(todoProvider);
    List<Todo> activeTodos = todos.where((todo) => todo.completed == false).toList();
    List<Todo> completeTodos = todos.where((todo) => todo.completed == true).toList();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo App"),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: activeTodos.length+1,
        itemBuilder: (context, index) {
          if(activeTodos.isEmpty){
            return const Padding(
              padding:  EdgeInsets.only(top: 300),
              child: Center(
                child: Text('Add a todo using the button below'),
            
              ),
            );

          }
          else if(index == activeTodos.length){
            if(completeTodos.isEmpty){
              return Container();
            }else{
              return Center(
                child: TextButton(child: const Text('Completed Todo'),
                onPressed: (){
                  Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const CompleteTodo()),
          );
                },)
              );
            }

          }else{
          return Slidable(
            startActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) =>
                      ref.watch(todoProvider.notifier).deleteTodo(activeTodos[index].todoId),
                  backgroundColor: Colors.red,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  icon: Icons.delete,
                )
              ],
            ),
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              children: [
                SlidableAction(
                  onPressed: (context) =>
                      ref.watch(todoProvider.notifier).completeTodo(activeTodos[index].todoId),
                  backgroundColor: Colors.green,
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  icon: Icons.check,
                )
              ],
            ),
            child: Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.grey[300],borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListTile(
                title: Text(
                  activeTodos[index].content,
                ),
              ),
            ),
          );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddTodo()),
          );
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        backgroundColor: Colors.black,
      ),
    );
  }
}
