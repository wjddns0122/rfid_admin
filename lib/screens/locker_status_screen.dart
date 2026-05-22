import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class LockerStatusScreen extends StatefulWidget {
  const LockerStatusScreen({super.key});

  @override
  State<LockerStatusScreen> createState() => _LockerStatusScreenState();
}

class _LockerStatusScreenState extends State<LockerStatusScreen> {
  int _selectedSegment = 0; // 0: 전체, 1: A구역, 2: B구역

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FE),
      appBar: AppBar(
        backgroundColor: Colors.white.withOpacity(0.8),
        elevation: 0,
        scrolledUnderElevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            border: Border(bottom: BorderSide(color: Color(0xFFE5E5EA))),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '매장 운영',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 17,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.4,
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
        padding: const EdgeInsets.only(left: 16.0, right: 16.0, top: 24.0, bottom: 96.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title & Segment Control
            const Text(
              '사물함 현황',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 28,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: const Color(0xFFEEEDF3),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  _buildSegmentButton(0, '전체 사물함'),
                  _buildSegmentButton(1, 'A 구역'),
                  _buildSegmentButton(2, 'B 구역'),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Status Overview
            Row(
              children: [
                Expanded(
                  child: _buildStatusCard(
                    title: '사용 중',
                    count: '42',
                    suffix: '/ 60',
                    countColor: const Color(0xFF3F3BBD),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatusCard(
                    title: '비어있음',
                    count: '15',
                    suffix: '여유',
                    countColor: const Color(0xFF0058BC),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildStatusCard(
                    title: '시간 초과',
                    count: '3',
                    suffix: '알림',
                    countColor: const Color(0xFFBA1A1A),
                    suffixColor: const Color(0xB2BA1A1A),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Locker Grid Layout
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x33C7C4D6)),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0A000000),
                    blurRadius: 4,
                    offset: Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'A 구역 - 1 섹션',
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -0.1,
                        ),
                      ),
                      Row(
                        children: [
                          _buildLegendDot(const Color(0xFF5856D6), '사용중'),
                          const SizedBox(width: 8),
                          _buildLegendDot(const Color(0xFFE9E7ED), '공석'),
                          const SizedBox(width: 8),
                          _buildLegendDot(const Color(0xFFBA1A1A), '초과'),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 1.0,
                    ),
                    itemCount: 30,
                    itemBuilder: (context, index) {
                      final lockerNumber = index + 1;
                      String status = 'used'; // 'used', 'empty', 'timeout'
                      
                      // Mocking the statuses from Figma
                      if ([2, 8, 9, 11, 12, 16, 18, 25, 27, 30].contains(lockerNumber)) {
                        status = 'empty';
                      } else if (lockerNumber == 4) {
                        status = 'timeout';
                      }

                      return _buildLockerItem(lockerNumber, status, isSelected: lockerNumber == 1);
                    },
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Activity Feed
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  '최근 활동',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    letterSpacing: -0.1,
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: const Text(
                    '전체 보기',
                    style: TextStyle(
                      color: Color(0xFF3F3BBD),
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0x33C7C4D6)),
              ),
              child: Column(
                children: [
                  _buildActivityItem(
                    icon: Icons.person_add_alt_1_outlined,
                    iconColor: const Color(0xFF0070EB),
                    iconBgColor: const Color(0x1A0070EB),
                    title: '08번 사물함 배정',
                    subtitle: '회원: 김태영 • 2분 전',
                  ),
                  const Divider(height: 1, color: Color(0xFFE9E7ED), indent: 68),
                  _buildActivityItem(
                    icon: Icons.timer_off_outlined,
                    iconColor: const Color(0xFFBA1A1A),
                    iconBgColor: const Color(0x1ABA1A1A),
                    title: '04번 사물함 시간 초과',
                    subtitle: '이용 시간 2시간 초과 • 15분 전',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),

            // System Notice Card
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF464554),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0D000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        'https://images.unsplash.com/photo-1518770660439-4636190af475?w=1000&auto=format&fit=crop&q=60',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(color: const Color(0xFF464554)),
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Container(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.transparent,
                              Color(0xCC0F172A),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 24,
                    left: 24,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '시스템 점검 안내',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.w600,
                            letterSpacing: -0.1,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'B 구역 소프트웨어 업데이트 예정: 오후 10:00',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 0),
    );
  }

  Widget _buildSegmentButton(int index, String title) {
    final isSelected = _selectedSegment == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          setState(() {
            _selectedSegment = index;
          });
        },
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8),
            boxShadow: isSelected
                ? const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    )
                  ]
                : null,
          ),
          alignment: Alignment.center,
          child: Text(
            title,
            style: TextStyle(
              color: isSelected ? const Color(0xFF3F3BBD) : const Color(0xFF464554),
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatusCard({
    required String title,
    required String count,
    required String suffix,
    required Color countColor,
    Color suffixColor = const Color(0xFF464554),
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0x4DC7C4D6)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0A000000),
            blurRadius: 4,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF464554),
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                count,
                style: TextStyle(
                  color: countColor,
                  fontSize: 28,
                  fontWeight: FontWeight.w700,
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(width: 4),
              Text(
                suffix,
                style: TextStyle(
                  color: suffixColor,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLegendDot(Color color, String label) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontSize: 11,
          ),
        ),
      ],
    );
  }

  Widget _buildLockerItem(int number, String status, {bool isSelected = false}) {
    Color bgColor;
    Color textColor;
    Border? border;

    switch (status) {
      case 'empty':
        bgColor = const Color(0xFFE9E7ED);
        textColor = const Color(0xFF464554);
        break;
      case 'timeout':
        bgColor = const Color(0x1ABA1A1A);
        textColor = const Color(0xFFBA1A1A);
        border = Border.all(color: const Color(0x33BA1A1A));
        break;
      case 'used':
      default:
        bgColor = const Color(0xFF5856D6);
        textColor = const Color(0xFFE7E4FF);
        break;
    }

    if (isSelected) {
      border = Border.all(color: Colors.white, width: 2);
    }

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(12),
        border: border,
        boxShadow: isSelected
            ? const [
                BoxShadow(
                  color: Color(0xFF5856D6),
                  spreadRadius: 2,
                )
              ]
            : null,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            number.toString().padLeft(2, '0'),
            style: TextStyle(
              color: textColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Icon(
            status == 'empty' ? Icons.lock_open : Icons.lock,
            color: textColor,
            size: 14,
          ),
        ],
      ),
    );
  }

  Widget _buildActivityItem({
    required IconData icon,
    required Color iconColor,
    required Color iconBgColor,
    required String title,
    required String subtitle,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: iconBgColor,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 20),
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
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Color(0xFF464554),
                    fontSize: 11,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right, color: Color(0xFFC7C4D6), size: 20),
        ],
      ),
    );
  }
}
