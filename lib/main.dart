import 'package:flutter/material.dart';
import 'screens/main_screen.dart';
import 'screens/temp_stock_screen.dart';
import 'screens/stock_screen.dart';
import 'screens/settings_screen.dart'; // 設定画面をインポート

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '語彙 Stocker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor:
              const Color.fromARGB(255, 225, 226, 140), // ナビゲーションバーの背景色
          selectedItemColor:
              const Color.fromARGB(255, 31, 153, 92), // 選択されたアイテムの色
          unselectedItemColor:
              const Color.fromARGB(179, 125, 127, 228), // 未選択アイテムの色
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 1; // メイン画面をデフォルトに設定

  // 初期状態で「未指定」をジャンルに追加
  List<String> _genres = ['未指定'];

  // 単語データを共有するためのリスト
  List<Map<String, dynamic>> vocabularyList = [];

  @override
  void initState() {
    super.initState();
    // 設定画面に遷移しなくても、必ず「未指定」があるように初期化時にセット
    if (_genres.isEmpty) {
      _genres.add('未指定');
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // 各ページにデータを渡して、ページを管理
    final List<Widget> _pages = [
      TempStockScreen(vocabulary: vocabularyList, genres: _genres), // 仮ストック画面
      MainScreen(vocabulary: vocabularyList), // メイン画面
      StockScreen(stockedVocabulary: vocabularyList), // ストック画面
      SettingsScreen(genres: _genres), // 設定画面 (ジャンル管理)
    ];

    return Scaffold(
      body: _pages[_selectedIndex], // 選択されたページを表示
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.storage), label: '仮ストック'),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'メイン'),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: 'ストック'),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: '設定'),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // タップしたときにページを切り替える
      ),
    );
  }
}
