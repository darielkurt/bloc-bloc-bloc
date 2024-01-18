import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Task {
  final String? name;
  final bool? isDone;
  const Task({this.name, this.isDone});

  Task copyWith({String? name, bool? isDone}) {
    return Task(
      name: name ?? this.name,
      isDone: isDone ?? this.isDone,
    );
  }
}

class CrudApp extends StatelessWidget {
  const CrudApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CrudCubit(),
      child: const TodoPage(),
    );
  }
}

class CrudCubit extends Cubit<List<Task>> {
  CrudCubit() : super([]);

  void add(Task task) => emit([...state, task]);
  void remove(int index) {
    final newList = [...state];
    newList.removeAt(index);
    emit(newList);
  }

  void update({required Task task, required int index}) {
    state[index] = task;
    emit([...state]);
  }
}

class TodoPage extends StatelessWidget {
  const TodoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CrudCubit, List<Task>>(
      builder: (context, taskList) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Todo App'),
          ),
          body: TodoList(taskList: taskList),
          floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.add),
            onPressed: () {
              const task = Task(name: 'Kumain', isDone: false);
              context.read<CrudCubit>().add(task);
            },
          ),
        );
      },
    );
  }
}

class TodoList extends StatelessWidget {
  final List<Task> taskList;
  const TodoList({
    required this.taskList,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) {
        final task = taskList[index];
        return ListTile(
          title: Text(task.name ?? 'ewan ko ba'),
          leading: Icon(
            task.isDone == true
                ? Icons.check_box_rounded
                : Icons.check_box_outline_blank_rounded,
          ),
          trailing: IconButton(
              icon: const Icon(Icons.clear),
              onPressed: () {
                context.read<CrudCubit>().remove(index);
              }),
          onTap: () {
            final isDone = task.isDone == true;
            final newTask = task.copyWith(isDone: !isDone);
            context.read<CrudCubit>().update(task: newTask, index: index);
          },
        );
      },
      separatorBuilder: (_, __) => const Divider(),
      itemCount: taskList.length,
    );
  }
}
