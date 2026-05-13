import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/locker_status_screen.dart';

class DashboardOperationList extends StatelessWidget {
  const DashboardOperationList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 4, bottom: 12),
          child: Text(
            '운영 관리',
            style: TextStyle(
              color: AppColors.textSecondary,
              fontSize: 14,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: AppColors.cardBackground,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.cardBorder),
          ),
          child: Column(
            children: [
              _buildListTile(
                iconData: Icons.inventory_2_outlined,
                iconBgColor: const Color(0x1A894200), // rgba(137,66,0,0.1)
                iconColor: const Color(0xFF894200),
                title: '재고 관리',
                subtitle: '2개 품목 부족',
                showDivider: true,
              ),
              _buildListTile(
                iconData: Icons.lock_outline,
                iconBgColor: const Color(0x1A4441CC), // rgba(68,65,204,0.1)
                iconColor: const Color(0xFF4441CC),
                title: '사물함 현황',
                subtitleWidget: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(999),
                        child: const LinearProgressIndicator(
                          value: 12 / 20,
                          backgroundColor: Color(0x4DC7C4D7),
                          valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4441CC)),
                          minHeight: 6,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Text(
                      '12/20 사용 중',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 14,
                      ),
                    ),
                  ],
                ),
                showDivider: false,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => const LockerStatusScreen(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildListTile({
    required IconData iconData,
    required Color iconBgColor,
    required Color iconColor,
    required String title,
    String? subtitle,
    Widget? subtitleWidget,
    required bool showDivider,
    VoidCallback? onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBgColor,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(iconData, color: iconColor),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        subtitle,
                        style: const TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ] else if (subtitleWidget != null) ...[
                      const SizedBox(height: 4),
                      subtitleWidget,
                    ],
                  ],
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.grey, size: 20),
            ],
          ),
        ),
      ),
        if (showDivider)
          const Divider(height: 1, color: Color(0x33C7C4D7), indent: 16, endIndent: 16),
      ],
    );
  }
}
