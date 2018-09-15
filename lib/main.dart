import 'package:flutter/material.dart';
import 'package:todo_list/all_lists.dart';

void main() => runApp(new TodoApp());

class TodoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Just Do It',
        home: Scaffold(
          appBar: AppBar(
            title: Text(
                'Just Do It!'
            ),
          ),

          body: AllLists(),
        )
    );
  }

}
