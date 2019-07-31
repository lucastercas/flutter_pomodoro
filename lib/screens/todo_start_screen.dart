import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pomodoro_flutter/components/dialog_action_button.dart';

import 'package:pomodoro_flutter/constants.dart';
import 'package:pomodoro_flutter/components/todo_item.dart';

class TodoScreen extends StatefulWidget {
  TodoScreen({Key key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final _firestore = Firestore.instance;
  String _newTodoText = '';

  void _addTodo() {
    _firestore.collection('todos').add({
      'activity': _newTodoText,
      'done': false,
    });
  }

  void _showAddDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add To Do"),
          content: TextField(
            onChanged: (text) {
              setState(() {
                _newTodoText = text;
              });
              print(_newTodoText);
            },
          ),
          actions: <Widget>[
            DialogActionButton(
              onPressed: () {
                _addTodo();
                Navigator.of(context).pop();
                _newTodoText = '';
              },
              text: 'Add',
            )
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pomodoro'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            new TodosStream(firestore: _firestore),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddDialog,
        child: Icon(FontAwesomeIcons.plus),
      ),
    );
  }
}

class TodosStream extends StatelessWidget {
  const TodosStream({
    Key key,
    @required Firestore firestore,
  })  : _firestore = firestore,
        super(key: key);

  final Firestore _firestore;

  @override
  Widget build(BuildContext context) {
    List<TodoItem> todosWidgets = [];

    return StreamBuilder<QuerySnapshot>(
      stream: _firestore.collection('todos').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Text('No Data');
        }
        final List<DocumentSnapshot> todos = snapshot.data.documents;
        for (DocumentSnapshot todo in todos) {
          final String activity = todo.data['activity'];
          final bool done = todo.data['done'];
          TodoItem newItem = TodoItem(
            activity: activity,
            done: done,
            docSnapshot: todo,
            key: UniqueKey(),
          );
          todosWidgets.add(newItem);
        }
        return Expanded(
          child: ListView.builder(
            itemCount: todosWidgets.length,
            itemBuilder: (context, index) {
              TodoItem item = todosWidgets[index];
              return Dismissible(
                key: UniqueKey(),
                onDismissed: (direction) async {
                  todosWidgets.removeAt(index);
                  if (item.docSnapshot.exists) {
                    await item.docSnapshot.reference.delete();
                  }
                },
                child: todosWidgets[index],
              );
            },
            //children: todosWidgets,
          ),
        );
      },
    );
  }
}
