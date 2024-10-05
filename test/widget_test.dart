import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:goistocker/main.dart'; // 実際のアプリファイルをインポート

void main() {
  testWidgets('語彙追加機能のテスト', (WidgetTester tester) async {
    // アプリをテスト環境にセットアップ
    await tester.pumpWidget(MyApp());

    // テキストフィールドに"テスト語彙"を入力
    await tester.enterText(find.byType(TextField), 'テスト語彙');

    // "追加"ボタンをタップ
    await tester.tap(find.text('追加'));

    // ウィジェットツリーを再構築
    await tester.pump();

    // 語彙リストに追加された"テスト語彙"が表示されるか確認
    expect(find.text('テスト語彙'), findsOneWidget);
  });
}
