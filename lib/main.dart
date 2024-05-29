import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/views/splash.dart';
import 'package:provider/provider.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyWebPortfolio(),
    ),
  );
}

class MyWebPortfolio extends StatelessWidget {
  const MyWebPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode:
              themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: SplashScreen(),
        );
      },
    );
  }
}
