import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OptimizedImage extends StatelessWidget {
  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;
  final bool enableMemoryCache;
  final Duration? fadeInDuration;

  const OptimizedImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
    this.enableMemoryCache = true,
    this.fadeInDuration,
  }) : assert(imageUrl != null || assetPath != null, 'Either imageUrl or assetPath must be provided');

  @override
  Widget build(BuildContext context) {
    Widget imageWidget;

    if (imageUrl != null) {
      // Network image with caching
      imageWidget = CachedNetworkImage(
        imageUrl: imageUrl!,
        width: width,
        height: height,
        fit: fit,
        memCacheWidth: width?.toInt(),
        memCacheHeight: height?.toInt(),
        maxWidthDiskCache: (width != null) ? (width! * 2).toInt() : null,
        maxHeightDiskCache: (height != null) ? (height! * 2).toInt() : null,
        fadeInDuration: fadeInDuration ?? const Duration(milliseconds: 300),
        placeholder: (context, url) => placeholder ?? _buildDefaultPlaceholder(),
        errorWidget: (context, url, error) => errorWidget ?? _buildDefaultErrorWidget(),
        useOldImageOnUrlChange: true,
      );
    } else {
      // Asset image with memory optimization
      imageWidget = Image.asset(
        assetPath!,
        width: width,
        height: height,
        fit: fit,
        cacheWidth: width?.toInt(),
        cacheHeight: height?.toInt(),
        errorBuilder: (context, error, stackTrace) => errorWidget ?? _buildDefaultErrorWidget(),
      );
    }

    if (borderRadius != null) {
      imageWidget = ClipRRect(
        borderRadius: borderRadius!,
        child: imageWidget,
      );
    }

    return imageWidget;
  }

  Widget _buildDefaultPlaceholder() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: borderRadius,
      ),
      child: const Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
          ),
        ),
      ),
    );
  }

  Widget _buildDefaultErrorWidget() {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: borderRadius,
      ),
      child: const Center(
        child: Icon(
          Icons.error_outline,
          color: Colors.grey,
          size: 32,
        ),
      ),
    );
  }
}

class LazyLoadingImage extends StatefulWidget {
  final String? imageUrl;
  final String? assetPath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final BorderRadius? borderRadius;

  const LazyLoadingImage({
    super.key,
    this.imageUrl,
    this.assetPath,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.placeholder,
    this.errorWidget,
    this.borderRadius,
  });

  @override
  State<LazyLoadingImage> createState() => _LazyLoadingImageState();
}

class _LazyLoadingImageState extends State<LazyLoadingImage> {
  bool _isVisible = false;

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key(widget.imageUrl ?? widget.assetPath ?? ''),
      onVisibilityChanged: (info) {
        if (info.visibleFraction > 0.1 && !_isVisible) {
          setState(() {
            _isVisible = true;
          });
        }
      },
      child: _isVisible
          ? OptimizedImage(
              imageUrl: widget.imageUrl,
              assetPath: widget.assetPath,
              width: widget.width,
              height: widget.height,
              fit: widget.fit,
              placeholder: widget.placeholder,
              errorWidget: widget.errorWidget,
              borderRadius: widget.borderRadius,
            )
          : Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: widget.borderRadius,
              ),
            ),
    );
  }
}

// Simple visibility detector
class VisibilityDetector extends StatefulWidget {
  final Widget child;
  final Key key;
  final Function(VisibilityInfo) onVisibilityChanged;

  const VisibilityDetector({
    required this.key,
    required this.child,
    required this.onVisibilityChanged,
  }) : super(key: key);

  @override
  State<VisibilityDetector> createState() => _VisibilityDetectorState();
}

class _VisibilityDetectorState extends State<VisibilityDetector> {
  @override
  Widget build(BuildContext context) {
    return widget.child;
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkVisibility();
    });
  }

  void _checkVisibility() {
    final RenderBox? renderBox = context.findRenderObject() as RenderBox?;
    if (renderBox != null && renderBox.hasSize) {
      final offset = renderBox.localToGlobal(Offset.zero);
      final size = renderBox.size;
      final screenSize = MediaQuery.of(context).size;
      
      final isVisible = offset.dy < screenSize.height && 
                       offset.dy + size.height > 0 &&
                       offset.dx < screenSize.width && 
                       offset.dx + size.width > 0;
      
      if (isVisible) {
        widget.onVisibilityChanged(VisibilityInfo(visibleFraction: 1.0));
      }
    }
  }
}

class VisibilityInfo {
  final double visibleFraction;
  
  VisibilityInfo({required this.visibleFraction});
}