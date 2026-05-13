import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';

class StoreMapScreen extends StatelessWidget {
  const StoreMapScreen({super.key});

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: AppColors.primary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          '매장 지도',
          style: TextStyle(
            color: Color(0xFF0F172A),
            fontSize: 17,
            fontWeight: FontWeight.w500,
          ),
        ),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: AppColors.primary),
            onPressed: () {},
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0, left: 4.0),
            child: CircleAvatar(
              radius: 14,
              backgroundColor: const Color(0xFFE2E8F0),
              child: ClipOval(
                // TODO: 실제 유저 이미지로 교체
                child: Container(color: Colors.grey[300]),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              // Search & Filter
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 44,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: const Color(0xFFC7C4D7)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x0D000000),
                            blurRadius: 1,
                            offset: Offset(0, 1),
                          )
                        ],
                      ),
                      child: Row(
                        children: const [
                          SizedBox(width: 12),
                          Icon(Icons.search, color: Color(0xFF6B7280), size: 20),
                          SizedBox(width: 8),
                          Text(
                            '상품명 또는 구역 검색',
                            style: TextStyle(
                              color: Color(0xFF6B7280),
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(Icons.tune, color: Colors.white, size: 20),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              
              // Map Container
              Container(
                height: 558,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFC7C4D7)),
                  color: const Color(0xFFEEEDF3), // Background map color
                ),
                child: Stack(
                  children: [
                    // Zone C
                    Positioned(
                      top: 40,
                      left: 40,
                      child: _buildZoneBlock(
                        title: 'ZONE C',
                        subtitle: '스포츠존',
                        color: const Color(0xFF4441CC),
                        width: 142,
                        height: 166,
                      ),
                    ),
                    
                    // Zone B
                    Positioned(
                      top: 40,
                      right: 40,
                      child: _buildZoneBlock(
                        title: 'ZONE B',
                        subtitle: '피팅룸 근처',
                        color: const Color(0xFF8D2EBC),
                        width: 124,
                        height: 250,
                        showIcons: true,
                      ),
                    ),

                    // Zone A (Active)
                    Positioned(
                      bottom: 128,
                      left: 40,
                      child: _buildActiveZoneBlock(
                        title: 'ZONE A',
                        subtitle: '아우터 매대',
                      ),
                    ),

                    // Entrance Indicator
                    Positioned(
                      bottom: 16,
                      right: 90,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 80,
                            height: 6,
                            decoration: BoxDecoration(
                              color: const Color(0xFFCBD5E1),
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            '출입구',
                            style: TextStyle(
                              color: Color(0xFF64748B),
                              fontSize: 10,
                              fontWeight: FontWeight.w500,
                              letterSpacing: 1,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Floor indicator
                    Positioned(
                      top: 16,
                      right: 16,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: const Color(0xFFC7C4D7)),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              blurRadius: 1,
                              offset: Offset(0, 1),
                            )
                          ],
                        ),
                        child: Row(
                          children: const [
                            Icon(Icons.layers_outlined, size: 14, color: AppColors.textPrimary),
                            SizedBox(width: 6),
                            Text(
                              '2층',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Zoom Controls
                    Positioned(
                      bottom: 16,
                      right: 16,
                      child: Column(
                        children: [
                          _buildMapControlButton(Icons.add),
                          const SizedBox(height: 8),
                          _buildMapControlButton(Icons.remove),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              
              // Bottom Detail Card
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFC7C4D7)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x0D000000),
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    )
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 52,
                      height: 56,
                      decoration: BoxDecoration(
                        color: const Color(0xFFEEEDF3),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      // TODO: Asset image
                      child: const Icon(Icons.image, color: Colors.grey),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text(
                            '아우터 매대 (ZONE A)',
                            style: TextStyle(
                              color: AppColors.textPrimary,
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '재고 확인 요청 · 2분 전',
                            style: TextStyle(
                              color: Color(0xFF777586),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4441CC),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                      ),
                      child: const Text(
                        '경로 안\n내',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }

  Widget _buildZoneBlock({
    required String title,
    required String subtitle,
    required Color color,
    required double width,
    required double height,
    bool showIcons = false,
  }) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.2)),
        boxShadow: const [
          BoxShadow(color: Color(0x0D000000), blurRadius: 1, offset: Offset(0, 1)),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
          ),
          if (showIcons) ...[
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.checkroom, size: 16, color: color),
                const SizedBox(width: 8),
                Icon(Icons.checkroom, size: 16, color: color),
              ],
            )
          ]
        ],
      ),
    );
  }

  Widget _buildActiveZoneBlock({
    required String title,
    required String subtitle,
  }) {
    return Container(
      width: 178,
      height: 194,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFF4441CC), width: 2),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 15, offset: Offset(0, 10)),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        alignment: Alignment.topCenter,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(color: Color(0xFF4441CC), fontSize: 11, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 16, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0x1A5E5CE6),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: const Text(
                  '요청 위치',
                  style: TextStyle(color: Color(0xFF4441CC), fontSize: 12, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Positioned(
            top: -16,
            child: Icon(Icons.location_on, color: const Color(0xFF5E5CE6), size: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildMapControlButton(IconData icon) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        border: Border.all(color: const Color(0xFFC7C4D7)),
        boxShadow: const [
          BoxShadow(color: Color(0x1A000000), blurRadius: 6, offset: Offset(0, 4)),
        ],
      ),
      child: Icon(icon, size: 20, color: AppColors.textPrimary),
    );
  }
}
