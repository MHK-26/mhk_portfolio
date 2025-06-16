import 'package:flutter/material.dart';
import 'package:mhk_portfolio_flutter/utils/colors.dart';

class FocusBorder extends StatelessWidget {
  final Widget child;
  final bool autofocus;
  final FocusNode? focusNode;
  final VoidCallback? onFocusChange;

  const FocusBorder({
    super.key,
    required this.child,
    this.autofocus = false,
    this.focusNode,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return Focus(
      autofocus: autofocus,
      focusNode: focusNode,
      onFocusChange: (hasFocus) {
        onFocusChange?.call();
      },
      child: Builder(
        builder: (context) {
          final hasFocus = Focus.of(context).hasFocus;
          return AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border: hasFocus
                  ? Border.all(
                      color: AppColors.gold,
                      width: 2,
                    )
                  : null,
              boxShadow: hasFocus
                  ? [
                      BoxShadow(
                        color: AppColors.gold.withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      )
                    ]
                  : null,
            ),
            child: child,
          );
        },
      ),
    );
  }
}