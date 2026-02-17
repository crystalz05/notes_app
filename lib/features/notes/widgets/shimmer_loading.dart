import 'package:flutter/material.dart';

/// Shimmer loading effect widget
class ShimmerLoading extends StatefulWidget {
  const ShimmerLoading({super.key});

  @override
  State<ShimmerLoading> createState() => _ShimmerLoadingState();
}

class _ShimmerLoadingState extends State<ShimmerLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat();

    _animation = Tween<double>(begin: -2, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    return ListView.separated(
      padding: const EdgeInsets.all(16),
      itemCount: 5,
      separatorBuilder: (context, index) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        return AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Container(
              height: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: isDark
                      ? [
                          Colors.grey[900]!,
                          Colors.grey[800]!,
                          Colors.grey[900]!,
                        ]
                      : [
                          Colors.grey[300]!,
                          Colors.grey[200]!,
                          Colors.grey[300]!,
                        ],
                  stops: [
                    (_animation.value - 1).clamp(0.0, 1.0),
                    _animation.value.clamp(0.0, 1.0),
                    (_animation.value + 1).clamp(0.0, 1.0),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
