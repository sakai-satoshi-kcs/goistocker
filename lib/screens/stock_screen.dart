import 'package:flutter/material.dart';

class StockScreen extends StatefulWidget {
  final List<Map<String, dynamic>> stockedVocabulary;

  StockScreen({required this.stockedVocabulary});

  @override
  _StockScreenState createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  String _searchTerm = '';
  String? _selectedGenre;

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> filteredVocabulary = widget.stockedVocabulary
        .where((vocab) =>
            (vocab['word'].contains(_searchTerm)) &&
            (_selectedGenre == null || vocab['genre'] == _selectedGenre))
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('ストック'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(labelText: '単語を検索'),
              onChanged: (value) {
                setState(() {
                  _searchTerm = value;
                });
              },
            ),
          ),
          DropdownButton<String>(
            value: _selectedGenre,
            hint: Text('ジャンルを選択'),
            items: <String?>[
              'すべて',
              ...widget.stockedVocabulary.map((e) => e['genre']).toSet()
            ].map((String? value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value!),
              );
            }).toList(),
            onChanged: (String? newValue) {
              setState(() {
                _selectedGenre = newValue == 'すべて' ? null : newValue;
              });
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: filteredVocabulary.length,
              itemBuilder: (context, index) {
                final vocab = filteredVocabulary[index];
                return ListTile(
                  title: Text(vocab['word']),
                  subtitle: Text('ジャンル: ${vocab['genre'] ?? 'なし'}'),
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text(vocab['word']),
                          content: Text('意味: ${vocab['meaning'] ?? 'なし'}'),
                          actions: <Widget>[
                            TextButton(
                              child: Text('閉じる'),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
