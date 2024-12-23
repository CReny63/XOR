import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meta_verse/main.dart';
import 'package:meta_verse/services/theme_provider.dart';
import 'package:provider/provider.dart';
//import 'theme_provider.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Create a ThemeProvider instance
    final themeProvider = ThemeProvider();

    // Build the widget tree with the HomePage wrapped in a ChangeNotifierProvider
    await tester.pumpWidget(
      ChangeNotifierProvider<ThemeProvider>(
        create: (context) => themeProvider,
        child: MaterialApp(
          home: HomePage(
            isDarkMode: themeProvider.isDarkMode,
            toggleTheme: themeProvider.toggleTheme,
          ),
        ),
      ),
    );

    // Verify that our counter starts at 0.
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump();

    // Verify that our counter has incremented.
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}
