import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'test_riverpod.g.dart';

@riverpod
class PageIndex extends _$PageIndex {
  @override
  int build() {
    return 0;
  }
  void goToPreviousPage() {
    state = state - 1;
  }
}

@riverpod
class AsyncTodos extends _$AsyncTodos {
  Future<List<String>> _fetchTodo() async {
    return [];
  }

  @override
  FutureOr<List<String>> build() async {
    return _fetchTodo();
  }

  Future<void> addTodo(String todo) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      ///调用add接口
      await Future.delayed(Duration(seconds: 3));
      return _fetchTodo();
    });
  }

  // Let's allow removing todos
  Future<void> removeTodo(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      ///调用remove接口
      await Future.delayed(Duration(seconds: 3));
      return _fetchTodo();
    });
  }

  // Let's mark a todo as completed
  Future<void> toggle(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      ///调用toggle接口
      await Future.delayed(Duration(seconds: 3));
      return _fetchTodo();
    });
  }
}