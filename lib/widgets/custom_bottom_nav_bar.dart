import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../screens/staff_dashboard_screen.dart';
import '../screens/customer_request_screen.dart';
import '../screens/inventory_screen.dart';
import '../screens/order_screen.dart';
import '../screens/more_screen.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int currentIndex;

  const CustomBottomNavBar({
    super.key,
    this.currentIndex = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFE5E5EA))),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(context, Icons.dashboard_outlined, '대시보드', 0),
              _buildNavItem(context, Icons.assignment_outlined, '요청', 1),
              _buildNavItem(context, Icons.inventory_2_outlined, '재고', 2),
              _buildNavItem(context, Icons.shopping_bag_outlined, '주문', 3),
              _buildNavItem(context, Icons.more_horiz, '더보기', 4),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(BuildContext context, IconData icon, String label, int index) {
    final isSelected = currentIndex == index;
    final color = isSelected
        ? AppColors.bottomNavSelected
        : AppColors.bottomNavUnselected;
    return InkWell(
      onTap: () {
        if (isSelected) return;
        
        Widget nextScreen;
        if (index == 0) {
          nextScreen = const StaffDashboardScreen();
        } else if (index == 1) {
          nextScreen = const CustomerRequestScreen();
        } else if (index == 2) {
          nextScreen = const InventoryScreen();
        } else if (index == 3) {
          nextScreen = const OrderScreen();
        } else if (index == 4) {
          nextScreen = const MoreScreen();
        } else {
          return; // 아직 구현되지 않은 탭
        }

        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation1, animation2) => nextScreen,
            transitionDuration: Duration.zero,
            reverseTransitionDuration: Duration.zero,
          ),
        );
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: color, size: 24),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
