import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/dashboard_main_card.dart';
import '../widgets/dashboard_metric_card.dart';
import '../widgets/dashboard_operation_list.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class StaffDashboardScreen extends StatelessWidget {
  const StaffDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE5E5EA))),
          ),
        ),
        leadingWidth: 48,
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Center(
            child: Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: const Color(0xFFE9E7ED),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFFC7C4D7)),
              ),
              // TODO: 실제 프로필 이미지 연결
              child: const Icon(Icons.person, size: 20, color: Colors.grey),
            ),
          ),
        ),
        title: const Text(
          '직원 대시보드',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.primary),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const DashboardMainCard(),
            const SizedBox(height: 24),
            Row(
              children: const [
                Expanded(
                  child: DashboardMetricCard(
                    status: '대기',
                    statusBgColor: AppColors.statusWaitBg,
                    statusTextColor: AppColors.statusWaitText,
                    title: '픽업 대기 주문',
                    count: '5건',
                    // TODO: placeholder icon
                    iconData: Icons.shopping_basket_outlined,
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: DashboardMetricCard(
                    status: '처리중',
                    statusBgColor: AppColors.statusProcessBg,
                    statusTextColor: AppColors.statusProcessText,
                    title: '배송 대기 주문',
                    count: '8건',
                    // TODO: placeholder icon
                    iconData: Icons.local_shipping_outlined,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            const DashboardOperationList(),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.add_circle_outline, color: AppColors.primary),
                label: const Text(
                  '새 요청 수동 등록',
                  style: TextStyle(color: AppColors.primary, fontSize: 16, fontWeight: FontWeight.w500),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.cardBackground,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: const BorderSide(color: AppColors.cardBorder),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }
}
