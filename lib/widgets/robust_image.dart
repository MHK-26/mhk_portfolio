import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';
import 'package:mhk_portfolio_flutter/widgets/optimized_image.dart';

class RobustImage extends StatefulWidget {
  final String imagePath;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Widget? placeholder;
  final Widget? errorWidget;
  final bool showRetryButton;
  final String? semanticLabel;

  const RobustImage({
    super.key,
    required this.imagePath,
    this.width,
    this.height,
    this.fit = BoxFit.contain,
    this.placeholder,
    this.errorWidget,
    this.showRetryButton = true,
    this.semanticLabel,
  });

  @override
  State<RobustImage> createState() => _RobustImageState();
}

class _RobustImageState extends State<RobustImage> {
  bool _hasError = false;
  int _retryCount = 0;
  static const int maxRetries = 3;

  @override
  Widget build(BuildContext context) {
    if (_hasError && !widget.showRetryButton) {
      return _buildErrorWidget();
    }

    return Semantics(
      image: true,
      label: widget.semanticLabel ?? 'Image',
      child: _hasError ? _buildErrorWithRetry() : _buildImage(),
    );
  }

  Widget _buildImage() {
    return OptimizedImage(
      assetPath: widget.imagePath,
      width: widget.width,
      height: widget.height,
      fit: widget.fit,
      placeholder: _buildPlaceholder(),
      errorWidget: _buildErrorWidget(),
      fadeInDuration: const Duration(milliseconds: 300),
    );
  }

  Widget _buildPlaceholder() {
    if (widget.placeholder != null) return widget.placeholder!;
    
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withOpacity(0.1),
            AppColors.gold.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: SizedBox(
          width: 24,
          height: 24,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
          ),
        ),
      ),
    );
  }

  Widget _buildErrorWidget() {
    if (widget.errorWidget != null) return widget.errorWidget!;
    
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withOpacity(0.1),
            AppColors.gold.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image_outlined,
            color: AppColors.gold,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Image not found',
            style: GoogleFonts.inter(
              color: AppColors.gold,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWithRetry() {
    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.gold.withOpacity(0.1),
            AppColors.gold.withOpacity(0.05),
          ],
        ),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: AppColors.gold.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.refresh,
            color: AppColors.gold,
            size: 32,
          ),
          const SizedBox(height: 8),
          Text(
            'Failed to load',
            style: GoogleFonts.inter(
              color: AppColors.gold,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          if (_retryCount < maxRetries) ...[
            const SizedBox(height: 8),
            Semantics(
              button: true,
              label: 'Retry loading image',
              child: InkWell(
                onTap: _retryLoad,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.gold.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    'Retry',
                    style: GoogleFonts.inter(
                      color: AppColors.gold,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  void _retryLoad() {
    if (_retryCount < maxRetries) {
      setState(() {
        _hasError = false;
        _retryCount++;
      });
    }
  }
}