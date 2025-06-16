import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class PerformanceOverlay extends StatefulWidget {
  final Widget child;
  final bool showOverlay;

  const PerformanceOverlay({
    super.key,
    required this.child,
    this.showOverlay = kDebugMode,
  });

  @override
  State<PerformanceOverlay> createState() => _PerformanceOverlayState();
}

class _PerformanceOverlayState extends State<PerformanceOverlay> 
    with TickerProviderStateMixin {
  double _fps = 0;
  int _frameCount = 0;
  late Stopwatch _stopwatch;
  late Ticker _ticker;

  @override
  void initState() {
    super.initState();
    _stopwatch = Stopwatch()..start();
    
    if (widget.showOverlay) {
      _ticker = createTicker(_onTick);
      _ticker.start();
    }
  }

  @override
  void dispose() {
    if (widget.showOverlay) {
      _ticker.dispose();
    }
    super.dispose();
  }

  void _onTick(Duration elapsed) {
    _frameCount++;
    
    if (_stopwatch.elapsedMilliseconds >= 1000) {
      setState(() {
        _fps = _frameCount * 1000 / _stopwatch.elapsedMilliseconds;
        _frameCount = 0;
        _stopwatch.reset();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget.child,
        if (widget.showOverlay && kDebugMode)
          Positioned(
            top: 50,
            right: 20,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'FPS: ${_fps.toStringAsFixed(1)}',
                    style: TextStyle(
                      color: _fps >= 55 ? Colors.green : 
                             _fps >= 30 ? Colors.yellow : Colors.red,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Memory: ${_getMemoryUsage()}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  String _getMemoryUsage() {
    // This is a placeholder - actual memory usage tracking 
    // would require platform-specific implementation
    return 'N/A';
  }
}

class PerformanceProfiler {
  static final Map<String, Stopwatch> _timers = {};
  static final List<String> _log = [];

  static void startTimer(String name) {
    if (kDebugMode) {
      _timers[name] = Stopwatch()..start();
    }
  }

  static void endTimer(String name) {
    if (kDebugMode && _timers.containsKey(name)) {
      final timer = _timers[name]!;
      timer.stop();
      final message = '$name: ${timer.elapsedMilliseconds}ms';
      _log.add(message);
      debugPrint('PERF: $message');
      _timers.remove(name);
    }
  }

  static List<String> getLogs() => List.from(_log);

  static void clearLogs() => _log.clear();
}

// Performance-aware builder widget
class PerformanceBuilder extends StatelessWidget {
  final Widget Function(BuildContext context) builder;
  final String? profileName;

  const PerformanceBuilder({
    super.key,
    required this.builder,
    this.profileName,
  });

  @override
  Widget build(BuildContext context) {
    if (kDebugMode && profileName != null) {
      PerformanceProfiler.startTimer(profileName!);
    }

    final widget = Builder(
      builder: (context) {
        final result = builder(context);
        
        if (kDebugMode && profileName != null) {
          SchedulerBinding.instance.addPostFrameCallback((_) {
            PerformanceProfiler.endTimer(profileName!);
          });
        }
        
        return result;
      },
    );

    return widget;
  }
}