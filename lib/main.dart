import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/home/home.dart';

void main() {
  runApp(MyWebPortfolio());
}

class MyWebPortfolio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: ThemeMode.light,
      home: HomeScreen(),
    );
  }
}
