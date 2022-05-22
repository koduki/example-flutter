import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

class MyAuthPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAuthPageState();
  }
}

class _MyAuthPageState extends State<MyAuthPage> {
  String newUserEmail = "";
  String newUserPassword = "";
  String infoText = "";

  // 入力されたメールアドレス（ログイン）
  String loginUserEmail = "";
  // 入力されたパスワード（ログイン）
  String loginUserPassword = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Container(
      padding: EdgeInsets.all(32),
      child: Column(
        children: <Widget>[
          TextFormField(
            // テキスト入力のラベルを設定
            decoration: InputDecoration(labelText: "メールアドレス"),
            onChanged: (String value) {
              setState(() {
                newUserEmail = value;
              });
            },
          ),
          const SizedBox(height: 8),
          TextFormField(
            decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
            // パスワードが見えないようにする
            obscureText: true,
            onChanged: (String value) {
              setState(() {
                newUserPassword = value;
              });
            },
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () async {
              try {
                // メール/パスワードでユーザー登録
                final FirebaseAuth auth = FirebaseAuth.instance;
                final UserCredential result =
                    await auth.createUserWithEmailAndPassword(
                  email: newUserEmail,
                  password: newUserPassword,
                );

                // 登録したユーザー情報
                final User user = result.user!;
                setState(() {
                  infoText = "登録OK：${user.email}";
                });
              } catch (e) {
                // 登録に失敗した場合
                setState(() {
                  infoText = "登録NG：${e.toString()}";
                });
              }
            },
            child: Text("ユーザー登録"),
          ),
          const SizedBox(height: 8),
          Text(infoText),
          TextFormField(
            decoration: InputDecoration(labelText: "メールアドレス"),
            onChanged: (String value) {
              setState(() {
                loginUserEmail = value;
              });
            },
          ),
          TextFormField(
            decoration: InputDecoration(labelText: "パスワード"),
            obscureText: true,
            onChanged: (String value) {
              setState(() {
                loginUserPassword = value;
              });
            },
          ),
          const SizedBox(
            height: 8,
          ),
          ElevatedButton(
            onPressed: () async {
              try {
                final FirebaseAuth auth = FirebaseAuth.instance;
                final UserCredential result =
                    await auth.signInWithEmailAndPassword(
                        email: loginUserEmail, password: loginUserPassword);
                final User user = result.user!;
                setState(() {
                  infoText = "ログインOK: ${user.email}";
                });
              } catch (e) {
                setState(() {
                  infoText = "ログインNG: ${e.toString()}";
                });
              }
            },
            child: Text("ログイン"),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(infoText),
        ],
      ),
    )));
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
