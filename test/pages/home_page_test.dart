//create test para HomePage
//

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:cep_app/pages/home_page.dart';

void main() {
  testWidgets('HomePage has title', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomePage()));

    // Verify that our counter starts at 0.
    expect(find.text('CEP'), findsOneWidget);
    expect(find.text('0'), findsNothing);
  });
}


