import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class DashboardMainCard extends StatelessWidget {
  const DashboardMainCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0C000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '현재 진행 상태',
                        style: TextStyle(
                          color: AppColors.textOnPrimary.withOpacity(0.8),
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '실시간 요청',
                        style: TextStyle(
                          color: AppColors.textOnPrimary,
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const Icon(Icons.bolt, color: AppColors.textOnPrimary), // TODO: 에셋 교체
                ],
              ),
              const SizedBox(height: 16),
              Row(
                crossAxisAlignment: CrossAxisAlignment.baseline,
                textBaseline: TextBaseline.alphabetic,
                children: const [
                  Text(
                    '3',
                    style: TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      height: 1,
                    ),
                  ),
                  SizedBox(width: 8),
                  Text(
                    '건',
                    style: TextStyle(
                      color: AppColors.textOnPrimary,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ],
          ),
          // 우측 하단 장식용 원 (디자인 의도 반영)
          Positioned(
            right: -16,
            bottom: -16,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
