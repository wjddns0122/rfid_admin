import 'package:admin_rfid/screens/store_map_screen.dart';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import '../widgets/request_card.dart';
import '../widgets/daily_stats_card.dart';
import 'request_detail_screen.dart';

class CustomerRequestScreen extends StatefulWidget {
  const CustomerRequestScreen({super.key});

  @override
  State<CustomerRequestScreen> createState() => _CustomerRequestScreenState();
}

class _CustomerRequestScreenState extends State<CustomerRequestScreen> {
  int _selectedIndex = 0;

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
        leading: const Padding(
          padding: EdgeInsets.only(left: 16.0),
          child: Center(
            child: Icon(
              Icons.storefront_outlined,
              color: AppColors.primary,
              size: 24,
            ),
          ),
        ),
        title: const Text(
          '매장 운영',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.notifications_none,
              color: AppColors.primary,
            ),
            onPressed: () {},
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 24, 16, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '고객 요청',
                    style: TextStyle(
                      color: AppColors.textPrimary,
                      fontSize: 34,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.37,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE9E7ED),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        _buildSegmentButton(0, '대기 중 (1)'),
                        _buildSegmentButton(1, '진행 중'),
                        _buildSegmentButton(2, '완료'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  RequestCard(
                    iconData: Icons.straighten,
                    iconColor: const Color(0xFF5E5CE6),
                    iconBgColor: const Color(0x1A5E5CE6),
                    title: '사이즈 문의',
                    userName: '김아린님',
                    time: '10:30',
                    location: 'A구역 아우터 매대',
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RequestDetailScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  RequestCard(
                    iconData: Icons.person_outline,
                    iconColor: const Color(0xFFD072FF),
                    iconBgColor: const Color(0x1AD072FF),
                    title: '직원 호출',
                    userName: '이지헌님',
                    time: '10:28',
                    location: 'B구역 피팅룸 근처',
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RequestDetailScreen(),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 12),
                  RequestCard(
                    iconData: Icons.inventory_2_outlined,
                    iconColor: const Color(0xFFAE5600),
                    iconBgColor: const Color(0x1AAE5600),
                    title: '재고 문의',
                    userName: '박서준님',
                    time: '10:25',
                    location: 'C구역 스포츠존',
                    onAction: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const StoreMapScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: DailyStatsCard(),
            ),
            const SizedBox(height: 96), // 하단 여백
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildSegmentButton(int index, String text) {
    final isSelected = _selectedIndex == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? [
                    const BoxShadow(
                      color: Color(0x0C000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              color: isSelected
                  ? AppColors.textPrimary
                  : AppColors.textSecondary,
              fontSize: 15,
              fontWeight: isSelected ? FontWeight.normal : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}
