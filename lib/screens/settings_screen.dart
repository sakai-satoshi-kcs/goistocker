import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  final List<String> genres; // genresリストを定義

  SettingsScreen({required this.genres}); // コンストラクタで受け取る

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _genreController = TextEditingController();
  List<String> _genres = [];

  @override
  void initState() {
    super.initState();
    _genres = widget.genres; // genresをwidgetから取得してセット
  }

  // ジャンルを追加するメソッド
  void _addGenre() {
    if (_genreController.text.isNotEmpty) {
      setState(() {
        _genres.add(_genreController.text); // 新しいジャンルを追加
        _genreController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('設定 - ジャンルを管理'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _genreController,
              decoration: InputDecoration(labelText: '新しいジャンルを入力'),
            ),
          ),
          ElevatedButton(
            onPressed: _addGenre,
            child: Text('ジャンルを追加'),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _genres.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_genres[index]),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
