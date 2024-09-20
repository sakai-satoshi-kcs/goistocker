import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  final List<Map<String, dynamic>> vocabulary; // vocabularyリストを追加

  MainScreen({required this.vocabulary}); // コンストラクタで受け取る

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final TextEditingController _controller = TextEditingController();

  // 追加した単語リストを表示するためのリスト
  List<Map<String, dynamic>> _vocabulary = [];

  @override
  void initState() {
    super.initState();
    _vocabulary = widget.vocabulary; // widgetから受け取ったvocabularyを使用
  }

  void _addVocabulary() {
    if (_controller.text.isNotEmpty) {
      setState(() {
        _vocabulary.add({
          'word': _controller.text,
          'meaning': '',
          'genre': '未指定',
        });
        _controller.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('語彙 Stocker - メイン'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: '語彙を入力'),
            ),
          ),
          ElevatedButton(
            onPressed: _addVocabulary,
            child: Text('追加'),
          ),
          // 追加した単語リストを表示
          Expanded(
            child: ListView.builder(
              itemCount: _vocabulary.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_vocabulary[index]['word']),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
