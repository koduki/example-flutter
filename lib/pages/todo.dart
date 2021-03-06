import 'package:example_flutter/pages/draw.dart';
import 'package:flutter/material.dart';
import './myauth.dart';

class TodoListPage extends StatefulWidget {
  @override
  _TodoListPageState createState() => _TodoListPageState();
}

class _TodoListPageState extends State<TodoListPage> {
  List<String> todoList = [];
  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        appBar: AppBar(title: Text('リスト一覧')),
        body: ListView.builder(
          itemCount: todoList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                title: Text(todoList[index]),
              ),
            );
          },
        ),
        floatingActionButton: Column(mainAxisSize: MainAxisSize.min, children: [
          FloatingActionButton(
            onPressed: () async {
              final newListText = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return TodoAddPage();
                }),
              );
              if (newListText != null) {
                setState(() {
                  todoList.add(newListText);
                });
              }
            },
            child: const Icon(Icons.add),
          ),
          FloatingActionButton(
            onPressed: () async {
              final newListText = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return MyAuthPage();
                }),
              );
            },
            child: const Icon(Icons.account_box),
          ),
          FloatingActionButton(
            onPressed: () async {
              final newListText = await Navigator.of(context).push(
                MaterialPageRoute(builder: (context) {
                  return DrawPage();
                }),
              );
            },
            child: const Icon(Icons.palette),
          ),
        ]));
    return scaffold;
  }
}

class TodoAddPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _TodoAddPageState();
  }
}

class _TodoAddPageState extends State<TodoAddPage> {
  String _text = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('リスト追加')),
      body: Container(
        padding: EdgeInsets.all(64),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_text, style: TextStyle(color: Colors.blue)),
            const SizedBox(
              height: 8,
            ),
            TextField(
              onChanged: (String value) {
                setState(() {
                  _text = value;
                });
              },
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                // color: Colors.blue,
                onPressed: () {
                  Navigator.of(context).pop(_text);
                },
                child: Text('リスト追加', style: TextStyle(color: Colors.white)),
              ),
            ),
            const SizedBox(height: 8),
            Container(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('キャンセル'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
