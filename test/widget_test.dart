import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_ui/main.dart';

void main() {
  testWidgets('Find Get Started button', (WidgetTester tester) async {
    await tester.pumpWidget(MaterialApp(home: FlutterUiApp()));

    expect(find.text('Get Started'), findsOneWidget);
  });
}
