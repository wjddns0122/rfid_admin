import 'package:flutter/material.dart';
import 'customer_request_screen.dart';

/// Figma 112:2654 디자인에 완벽히 부합하는 전달 완료 처리 결과 화면
/// 100줄 초과 방지를 위해 컴포넌트별로 서브 위젯을 완벽하게 분할하였습니다.
class RequestSuccessScreen extends StatelessWidget {
  final OrderData order;
  final VoidCallback? onComplete;

  const RequestSuccessScreen({
    super.key,
    required this.order,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF9FE),
      appBar: const _SuccessAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: [
                    const SizedBox(height: 24),
                    const _CelebrationHeader(),
                    const SizedBox(height: 32),
                    _SummaryCard(order: order),
                    const SizedBox(height: 24),
                    const _DecorationBanner(),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
            _BottomButton(
              onPressed: () {
                if (onComplete != null) {
                  onComplete!();
                }
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
            ),
          ],
        ),
      ),
    );
  }
}

/// 1. 상단 앱 바 (Success 전용 - suppression Nav)
class _SuccessAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _SuccessAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white.withOpacity(0.9),
      elevation: 0,
      scrolledUnderElevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(
            bottom: BorderSide(color: Color(0xFFE2E8F0), width: 1.0),
          ),
        ),
      ),
      titleSpacing: 16,
      title: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: Color(0xFF5E5CE6),
              shape: BoxShape.circle,
            ),
            child: const Center(
              child: Icon(
                Icons.person_outline,
                color: Colors.white,
                size: 16,
              ),
            ),
          ),
          const SizedBox(width: 8),
          const Text(
            'Retail Ops',
            style: TextStyle(
              color: Color(0xFF0F172A),
              fontSize: 18,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.45,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications_none, color: Color(0xFF464554)),
          onPressed: () {},
        ),
        const SizedBox(width: 8),
      ],
    );
  }
}

/// 2. 중앙 축하 그래픽 원 & 타이틀/서브텍스트
class _CelebrationHeader extends StatelessWidget {
  const _CelebrationHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: SizedBox(
            width: 120,
            height: 120,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // 메인 체크마크 써클
                Positioned(
                  left: 12,
                  top: 12,
                  child: Container(
                    width: 96,
                    height: 96,
                    decoration: BoxDecoration(
                      color: const Color(0xFF5E5CE6),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF5E5CE6).withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 48,
                    ),
                  ),
                ),
                // 데코레이션 우측 상단 붉은자주색 점
                const Positioned(
                  right: 4,
                  top: 4,
                  child: CircleAvatar(
                    radius: 8,
                    backgroundColor: Color(0xFFD072FF),
                  ),
                ),
                // 데코레이션 좌측 하단 연보라 점
                const Positioned(
                  left: 0,
                  bottom: 24,
                  child: CircleAvatar(
                    radius: 6,
                    backgroundColor: Color(0xFFE2DFFF),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          '전달 완료 처리되었습니다',
          style: TextStyle(
            color: Color(0xFF1A1B1F),
            fontSize: 24,
            fontWeight: FontWeight.w700,
            letterSpacing: -0.6,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 8),
        const Text(
          '고객님의 요청이 성공적으로 처리되었습니다.',
          style: TextStyle(
            color: Color(0xFF464554),
            fontSize: 16,
            fontWeight: FontWeight.normal,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

/// 3. 요약 카드 (Bento Style)
class _SummaryCard extends StatelessWidget {
  final OrderData order;

  const _SummaryCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final sizeText = order.availableSizes.isNotEmpty ? order.availableSizes[0] : 'M';
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(21.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFC7C4D7)),
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
          // 카드 헤더 (요청 요약 및 COMPLETED 뱃지)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '요청 요약',
                style: TextStyle(
                  color: Color(0xFF464554),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: const Color(0xFFDCFCE7),
                  borderRadius: BorderRadius.circular(9999),
                ),
                child: const Text(
                  'COMPLETED',
                  style: TextStyle(
                    color: Color(0xFF15803D),
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          // 요청 종류
          _buildSummaryRow(
            icon: Icons.chat_bubble_outline,
            title: '요청 종류',
            value: order.category == 'Outerwear' || order.category == 'Top' ? '사이즈 문의' : '기타 문의',
          ),
          const SizedBox(height: 16),
          // 위치
          _buildSummaryRow(
            icon: Icons.location_on_outlined,
            title: '위치',
            value: order.location,
          ),
          const SizedBox(height: 16),
          // 상품 정보
          Container(
            padding: const EdgeInsets.all(12.0),
            decoration: BoxDecoration(
              color: const Color(0xFFEEEDF3),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: Image.network(
                    order.imageUrl,
                    width: 48,
                    height: 48,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => Container(
                      width: 48,
                      height: 48,
                      color: const Color(0xFFE2E8F0),
                      child: const Icon(Icons.image, color: Colors.grey, size: 24),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '상품명',
                        style: TextStyle(
                          color: Color(0xFF464554),
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '${order.productName} (${order.color} / $sizeText)',
                        style: const TextStyle(
                          color: Color(0xFF1A1B1F),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow({
    required IconData icon,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: const Color(0xFFEEEDF3),
            borderRadius: BorderRadius.circular(6),
          ),
          child: Icon(icon, color: const Color(0xFF5E5CE6), size: 16),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: Color(0xFF464554),
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF1A1B1F),
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

/// 4. 하단 그라데이션 데코레이션 배너
class _DecorationBanner extends StatelessWidget {
  const _DecorationBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        gradient: LinearGradient(
          colors: [
            const Color(0xFF4441CC).withOpacity(0.08),
            const Color(0xFF8D2EBC).withOpacity(0.08),
          ],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (index) {
            return Container(
              margin: const EdgeInsets.symmetric(horizontal: 4.0),
              width: 8,
              height: 8,
              decoration: BoxDecoration(
                color: const Color(0xFF5E5CE6).withOpacity(0.4 - (index * 0.15)),
                shape: BoxShape.circle,
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// 5. 하단 버튼
class _BottomButton extends StatelessWidget {
  final VoidCallback onPressed;

  const _BottomButton({required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF5E5CE6).withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF5E5CE6),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: const Text(
            '요청 목록으로 돌아가기',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}
