import 'package:flutter/material.dart';

class TempStockScreen extends StatefulWidget {
  final List<Map<String, dynamic>> vocabulary;
  final List<String> genres;

  TempStockScreen({required this.vocabulary, required this.genres});

  @override
  _TempStockScreenState createState() => _TempStockScreenState();
}

class _TempStockScreenState extends State<TempStockScreen> {
  final TextEditingController _meaningController = TextEditingController();
  String? _selectedGenre; // 選択されたジャンル

  @override
  void initState() {
    super.initState();
    // デフォルトで最初のジャンルを選択（未指定が存在する場合は未指定）
    _selectedGenre = widget.genres.isNotEmpty ? widget.genres[0] : '未指定';
  }

  void _showPopup(Map<String, dynamic> vocab) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('単語: ${vocab['word']}'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: _meaningController,
                decoration: InputDecoration(labelText: '意味を入力'),
              ),
              SizedBox(height: 20),
              DropdownButton<String>(
                value: _selectedGenre, // 選択されたジャンルを反映
                hint: Text('ジャンルを選択'),
                items:
                    widget.genres.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedGenre = newValue; // 選択されたジャンルを更新
                  });
                },
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              child: Text('キャンセル'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('ストックする'),
              onPressed: () {
                // ストック処理
                Navigator.of(context).pop();
                _showStockConfirmation();
              },
            ),
          ],
        );
      },
    );
  }

  void _showStockConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('ストックしました'),
          actions: <Widget>[
            TextButton(
              child: Text('確定'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              child: Text('ストック画面へ'),
              onPressed: () {
                Navigator.of(context).pop(); // 現在のダイアログを閉じる
                Navigator.of(context).pushNamed('/stock'); // ストック画面へ
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('仮ストック'),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              itemCount: widget.vocabulary.length,
              itemBuilder: (context, index) {
                final vocab = widget.vocabulary[index];
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: InkWell(
                    onTap: () {
                      _showPopup(vocab);
                    },
                    child: Container(
                      padding: EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Center(
                        child: Text(
                          vocab['word'],
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
