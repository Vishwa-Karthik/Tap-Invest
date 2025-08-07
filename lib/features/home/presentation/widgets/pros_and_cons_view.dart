import 'package:flutter/material.dart';
import 'package:tap_invest/core/theme/app_theme.dart';
import 'package:tap_invest/features/home/presentation/bloc/home_bloc.dart';

class ProAndConsView extends StatelessWidget {
  final HomeState? state;

  const ProAndConsView({super.key, required this.state});

  @override
  Widget build(BuildContext context) {
    final pros = state?.companyDetails?.prosAndCons?.pros ?? [];
    final cons = state?.companyDetails?.prosAndCons?.cons ?? [];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppTheme.kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade200),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Pros and Cons",
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 16),

          if (pros.isNotEmpty) ...[
            const Text(
              "Pros",
              style: TextStyle(
                color: Colors.green,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...pros.map((point) => _buildProsItem(point)),
            const SizedBox(height: 16),
          ],

          if (cons.isNotEmpty) ...[
            const Text(
              "Cons",
              style: TextStyle(
                color: Colors.brown,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...cons.map((point) => _buildConsItem(point)),
          ],
        ],
      ),
    );
  }

  Widget _buildProsItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xFFE3F4E9),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 20,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF1F2937), // dark grey
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildConsItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2.0),
            child: Icon(
              Icons.error_outline,
              color: Colors.deepOrange,
              size: 20,
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF4B5563), // grey
                fontSize: 14,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
