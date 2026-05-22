import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav_bar.dart';
import 'customer_request_screen.dart'; // OrderData 타입 참조
import 'request_success_screen.dart';

/// Figma 112:1605 디자인에 완벽히 부합하는 요청 상세 화면
/// 100줄 이상 코드를 방지하기 위해 각 파트를 서브 위젯으로 정교히 분할하였습니다.
class RequestDetailScreen extends StatelessWidget {
  final OrderData order;
  final VoidCallback? onComplete;

  const RequestDetailScreen({
    super.key,
    required this.order,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: _DetailAppBar(isCompleted: order.isCompleted),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: 16.0,
              right: 16.0,
              top: 24.0,
              bottom: 140.0, // 하단 플로팅 버튼 영역 확보를 위한 마진
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _CustomerCard(order: order),
                const SizedBox(height: 24),
                _ProductCard(order: order),
                const SizedBox(height: 24),
                _MessageCard(order: order),
                const SizedBox(height: 24),
                _AdminMemoCard(order: order),
              ],
            ),
          ),
          _BottomActionArea(
            order: order,
            onComplete: onComplete,
          ),
        ],
      ),
      bottomNavigationBar: const CustomBottomNavBar(currentIndex: 1),
    );
  }
}

/// 1. 요청 상세 앱 바 (좌측 뒤로가기, 타이틀, 진행 중/완료 뱃지, 알림 아이콘)
class _DetailAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isCompleted;

  const _DetailAppBar({required this.isCompleted});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
          ),
        ),
      ),
      leadingWidth: 48,
      leading: IconButton(
        icon: const Icon(
          Icons.arrow_back_ios_new,
          color: Color(0xFF5E5CE6),
          size: 20,
        ),
        onPressed: () => Navigator.pop(context),
      ),
      titleSpacing: 0,
      title: const Text(
        '요청 상세',
        style: TextStyle(
          color: Color(0xFF0F172A),
          fontSize: 18,
          fontWeight: FontWeight.normal,
          letterSpacing: -0.45,
        ),
      ),
      actions: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: BoxDecoration(
            color: isCompleted
                ? const Color(0xFFE8F5E9) // 연초록 배경
                : const Color(0x265E5CE6), // 보라색 15% 불투명도
            borderRadius: BorderRadius.circular(9999),
          ),
          child: Text(
            isCompleted ? '완료됨' : '진행 중',
            style: TextStyle(
              color: isCompleted ? const Color(0xFF2E7D32) : const Color(0xFF5E5CE6),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: 4),
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF464554)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

/// 2. 고객 및 위치 정보 카드
class _CustomerCard extends StatelessWidget {
  final OrderData order;

  const _CustomerCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0x4DC7C4D7)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 1,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE2DFFF),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_outline,
                      color: Color(0xFF5E5CE6),
                      size: 24,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        order.customerName,
                        style: const TextStyle(
                          color: Color(0xFF1A1B1F),
                          fontSize: 17,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        order.phoneNumber,
                        style: const TextStyle(
                          color: Color(0xFF464554),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: Color(0xFFF4F3F8),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.phone_outlined,
                  color: Color(0xFF777586),
                  size: 15,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: const Color(0xFFF4F3F8),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.location_on_outlined,
                  color: Color(0xFF5E5CE6),
                  size: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  order.location,
                  style: const TextStyle(
                    color: Color(0xFF464554),
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 3. 상품 정보 카드 (Bento Style 3열 비주얼 그리드)
class _ProductCard extends StatelessWidget {
  final OrderData order;

  const _ProductCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // 이미지 블록 (1/3 너비)
        Expanded(
          flex: 1,
          child: Container(
            height: 128,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x4DC7C4D7)),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(11),
              child: Image.network(
                order.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: const Color(0xFFEEEDF3),
                  child: const Icon(Icons.image, color: Colors.grey, size: 32),
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 12),
        // 정보 블록 (2/3 너비)
        Expanded(
          flex: 2,
          child: Container(
            height: 128,
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0x4DC7C4D7)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      order.productName,
                      style: const TextStyle(
                        color: Color(0xFF1A1B1F),
                        fontSize: 17,
                        fontWeight: FontWeight.normal,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        _buildTag(order.color),
                        const SizedBox(width: 8),
                        _buildTag(order.category),
                      ],
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '보유 사이즈',
                      style: TextStyle(color: Color(0xFF777586), fontSize: 11),
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: order.availableSizes.map((size) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 6.0),
                          child: Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: const Color(0xFFC7C4D7),
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              size,
                              style: const TextStyle(
                                color: Color(0xFF1A1B1F),
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTag(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
      decoration: BoxDecoration(
        color: const Color(0xFFEEEDF3),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text,
        style: const TextStyle(color: Color(0xFF464554), fontSize: 12),
      ),
    );
  }
}

/// 4. 문의 내용 말풍선 카드
class _MessageCard extends StatelessWidget {
  final OrderData order;

  const _MessageCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.chat_bubble_outline, color: Color(0xFF1A1B1F), size: 14),
            SizedBox(width: 8),
            Text(
              '문의 내용',
              style: TextStyle(
                color: Color(0xFF1A1B1F),
                fontSize: 15,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 19),
          decoration: const BoxDecoration(
            color: Color(0xFF5E5CE6),
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
            boxShadow: [
              BoxShadow(
                color: Color(0x0D000000),
                blurRadius: 1,
                offset: Offset(0, 1),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                order.message,
                style: const TextStyle(
                  color: Color(0xFFF4F1FF),
                  fontSize: 17,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 12),
              Align(
                alignment: Alignment.bottomRight,
                child: Text(
                  order.messageTime,
                  style: const TextStyle(
                    color: Color(0xCCF4F1FF), // textOnPrimary 80% 불투명도
                    fontSize: 11,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// 5. 관리자 메모 카드 (Dashed 점선 테두리)
class _AdminMemoCard extends StatelessWidget {
  final OrderData order;

  const _AdminMemoCard({required this.order});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: const [
            Icon(Icons.edit_note, color: Color(0xFF777586), size: 18),
            SizedBox(width: 8),
            Text(
              '관리자 메모',
              style: TextStyle(color: Color(0xFF777586), fontSize: 12),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: const Color(
              0x80E9E7ED,
            ), // rgba(233, 231, 237, 0.5) 연회색 50% 불투명도
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomPaint(
            painter: DashedBorderPainter(color: const Color(0xFFC7C4D7)),
            child: Padding(
              padding: const EdgeInsets.all(17.0),
              child: Text(
                order.adminMemo,
                style: const TextStyle(
                  color: Color(0xFF464554),
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

/// 6. 하단 '전달 완료 처리' 플로팅 버튼 영역
class _BottomActionArea extends StatelessWidget {
  final OrderData order;
  final VoidCallback? onComplete;

  const _BottomActionArea({
    required this.order,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    if (order.isCompleted) {
      // 이미 완료된 경우 하단 버튼 대신 고정된 완료 안내 바를 제공
      return Positioned(
        left: 16,
        right: 16,
        bottom: 16,
        child: Container(
          height: 56,
          decoration: BoxDecoration(
            color: const Color(0xFFE8F5E9),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: const Color(0xFFA5D6A7)),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A2E7D32),
                blurRadius: 10,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Icon(
                Icons.check_circle,
                color: Color(0xFF2E7D32),
                size: 20,
              ),
              SizedBox(width: 8),
              Text(
                '전달 완료된 요청건입니다.',
                style: TextStyle(
                  color: Color(0xFF2E7D32),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Positioned(
      left: 16,
      right: 16,
      bottom: 16,
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Color(0x335E5CE6), // rgba(94, 92, 230, 0.2)
              blurRadius: 15,
              offset: Offset(0, 10),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => RequestSuccessScreen(
                  order: order,
                  onComplete: onComplete,
                ),
              ),
            );
          },
          icon: const Icon(
            Icons.check_circle_outline,
            color: Color(0xFFF4F1FF),
            size: 20,
          ),
          label: const Text(
            '전달 완료 처리',
            style: TextStyle(
              color: Color(0xFFF4F1FF),
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5E5CE6),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
    );
  }
}

/// 점선 테두리를 매끄럽게 그리기 위한 커스텀 페인터
class DashedBorderPainter extends CustomPainter {
  final Color color;

  DashedBorderPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final Path path = Path()
      ..addRRect(
        RRect.fromRectAndRadius(
          Rect.fromLTWH(0, 0, size.width, size.height),
          const Radius.circular(12),
        ),
      );

    Path dashPath = Path();
    const double dashWidth = 5.0;
    const double dashSpace = 3.0;
    double distance = 0.0;

    for (PathMetric pathMetric in path.computeMetrics()) {
      while (distance < pathMetric.length) {
        dashPath.addPath(
          pathMetric.extractPath(distance, distance + dashWidth),
          Offset.zero,
        );
        distance += dashWidth;
        distance += dashSpace;
      }
      distance = 0.0;
    }

    canvas.drawPath(dashPath, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
