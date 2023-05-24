import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  submit() async {
    // Example item
    final item = AnalyticsEventItem(
      itemName: 'Socks',
      itemId: 'xjw73ndnw',
      price: 10.0,
    );

    // List of items
    final items = [item];

    // Default "FirebaseAnalytics event" - WORKS
    await FirebaseAnalytics.instance.logViewItemList(
      items: items,
    );

    // Custome "FirebaseAnalytics event" - NOT WORKS
    await FirebaseAnalytics.instance.logEvent(
      name: 'view_item_list',
      parameters: {
        "items": items.map((AnalyticsEventItem item) => item.asMap()).toList(),
        "customeParameter": "customValue"
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Home"),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: submit,
          child: const Text("Submit"),
        ),
      ),
    );
  }
}
