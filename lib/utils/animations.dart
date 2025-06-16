import 'package:flutter/material.dart';

class AppAnimations {
  // Custom curves
  static const Curve defaultCurve = Curves.easeOutCubic;
  static const Curve bouncyCurve = Curves.elasticOut;
  static const Curve smoothCurve = Curves.easeInOutQuart;
  
  // Durations
  static const Duration fastDuration = Duration(milliseconds: 200);
  static const Duration normalDuration = Duration(milliseconds: 400);
  static const Duration slowDuration = Duration(milliseconds: 800);
  
  // Page transition animation
  static Widget fadeSlideTransition({
    required Widget child,
    required Animation<double> animation,
    Offset? begin,
  }) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin ?? const Offset(0.0, 0.1),
        end: Offset.zero,
      ).animate(CurvedAnimation(
        parent: animation,
        curve: defaultCurve,
      )),
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }

  // Staggered list animation
  static Widget staggeredListItem({
    required Widget child,
    required int index,
    Duration? delay,
    Duration? duration,
  }) {
    return TweenAnimationBuilder<double>(
      duration: (duration ?? normalDuration) + Duration(milliseconds: index * 100),
      tween: Tween(begin: 0.0, end: 1.0),
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 30 * (1 - value)),
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Scale and fade animation
  static Widget scaleInAnimation({
    required Widget child,
    Duration? duration,
    Curve? curve,
  }) {
    return TweenAnimationBuilder<double>(
      duration: duration ?? normalDuration,
      tween: Tween(begin: 0.0, end: 1.0),
      curve: curve ?? bouncyCurve,
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: child,
          ),
        );
      },
      child: child,
    );
  }

  // Slide from direction animation
  static Widget slideFromDirection({
    required Widget child,
    required SlideDirection direction,
    Duration? duration,
    Curve? curve,
  }) {
    Offset getOffset() {
      switch (direction) {
        case SlideDirection.left:
          return const Offset(-1.0, 0.0);
        case SlideDirection.right:
          return const Offset(1.0, 0.0);
        case SlideDirection.top:
          return const Offset(0.0, -1.0);
        case SlideDirection.bottom:
          return const Offset(0.0, 1.0);
      }
    }

    return TweenAnimationBuilder<Offset>(
      duration: duration ?? normalDuration,
      tween: Tween(begin: getOffset(), end: Offset.zero),
      curve: curve ?? defaultCurve,
      builder: (context, value, child) {
        return Transform.translate(
          offset: value * 100,
          child: child,
        );
      },
      child: child,
    );
  }

  // Hover animation mixin
  static Widget hoverAnimation({
    required Widget child,
    required bool isHovered,
    Duration? duration,
    double scale = 1.05,
    double? elevation,
  }) {
    return AnimatedContainer(
      duration: duration ?? fastDuration,
      curve: defaultCurve,
      transform: Matrix4.identity()..scale(isHovered ? scale : 1.0),
      child: AnimatedContainer(
        duration: duration ?? fastDuration,
        decoration: BoxDecoration(
          boxShadow: isHovered && elevation != null
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: elevation,
                    offset: Offset(0, elevation / 2),
                  ),
                ]
              : null,
        ),
        child: child,
      ),
    );
  }

  // Parallax scrolling effect
  static Widget parallaxWidget({
    required Widget child,
    required ScrollController scrollController,
    double rate = 0.5,
  }) {
    return AnimatedBuilder(
      animation: scrollController,
      builder: (context, child) {
        final offset = scrollController.hasClients ? scrollController.offset : 0.0;
        return Transform.translate(
          offset: Offset(0, offset * rate),
          child: child,
        );
      },
      child: child,
    );
  }

  // Loading animation
  static Widget loadingSpinner({
    Color? color,
    double? size,
  }) {
    return SizedBox(
      width: size ?? 40,
      height: size ?? 40,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          color ?? const Color(0xFFB8860B),
        ),
        strokeWidth: 3,
      ),
    );
  }

  // Typing animation
  static Widget typingAnimation({
    required String text,
    required TextStyle style,
    Duration? duration,
  }) {
    return TweenAnimationBuilder<int>(
      duration: duration ?? Duration(milliseconds: text.length * 50),
      tween: IntTween(begin: 0, end: text.length),
      builder: (context, value, child) {
        return Text(
          text.substring(0, value),
          style: style,
        );
      },
    );
  }

  // Shimmer loading effect
  static Widget shimmerLoading({
    required Widget child,
    bool isLoading = true,
    Color? baseColor,
    Color? highlightColor,
  }) {
    if (!isLoading) return child;
    
    return AnimatedBuilder(
      animation: const AlwaysStoppedAnimation(0.0),
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                baseColor ?? Colors.grey[300]!,
                highlightColor ?? Colors.grey[100]!,
                baseColor ?? Colors.grey[300]!,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
          child: child,
        );
      },
      child: child,
    );
  }
}

enum SlideDirection { left, right, top, bottom }

// Custom animation widget for complex animations
class AnimatedSection extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  final Curve curve;
  final bool animateOnMount;

  const AnimatedSection({
    Key? key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 600),
    this.curve = Curves.easeOutCubic,
    this.animateOnMount = true,
  }) : super(key: key);

  @override
  State<AnimatedSection> createState() => _AnimatedSectionState();
}

class _AnimatedSectionState extends State<AnimatedSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    );

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: widget.curve,
    ));

    if (widget.animateOnMount) {
      Future.delayed(widget.delay, () {
        if (mounted) {
          _controller.forward();
        }
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return SlideTransition(
          position: _slideAnimation,
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: widget.child,
          ),
        );
      },
    );
  }
}