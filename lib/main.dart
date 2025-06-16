import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/views/home/home.dart';
import 'package:provider/provider.dart';
import 'package:mhk_portfolio_flutter/provider/theme.dart';
import 'package:mhk_portfolio_flutter/utils/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Performance optimizations
  await _initializePerformanceOptimizations();
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MyWebPortfolio(),
    ),
  );
}

Future<void> _initializePerformanceOptimizations() async {
  // Preload key fonts to reduce initial render time
  try {
    await Future.wait([
      GoogleFonts.pendingFonts([
        GoogleFonts.poppins(),
        GoogleFonts.inter(),
      ]),
    ]);
  } catch (e) {
    // Fonts will be loaded on demand if preloading fails
    debugPrint('Font preloading failed: $e');
  }
  
  // Set system UI overlay style for better performance
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    systemNavigationBarColor: Colors.transparent,
  ));
  
  // Optimize memory usage
  PaintingBinding.instance.imageCache.maximumSize = 100;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 << 20; // 50 MB
}

class MyWebPortfolio extends StatelessWidget {
  const MyWebPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          home: HomeScreen(),
          // Performance optimizations
          builder: (context, child) {
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaleFactor: MediaQuery.of(context).textScaleFactor.clamp(0.8, 1.4),
              ),
              child: child!,
            );
          },
          // Reduce unnecessary rebuilds
          scrollBehavior: const MaterialScrollBehavior().copyWith(
            scrollbars: false,
            overscroll: false,
            physics: const ClampingScrollPhysics(),
          ),
        );
      },
    );
  }
}
