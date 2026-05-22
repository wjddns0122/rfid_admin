import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class NotificationItem {
  final String id;
  final String title;
  final String content;
  final String timeAgo;
  final IconData icon;
  final Color iconColor;
  final Color iconBgColor;
  bool hasActions;
  final Color? leftBorderColor;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.content,
    required this.timeAgo,
    required this.icon,
    required this.iconColor,
    required this.iconBgColor,
    this.hasActions = false,
    this.leftBorderColor,
    this.isRead = false,
  });
}

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  late List<NotificationItem> _todayItems;
  late List<NotificationItem> _earlierItems;

  @override
  void initState() {
    super.initState();
    _todayItems = [
      NotificationItem(
        id: '1',
        title: '신규 고객 요청',
        content: 'A구역 아우터 매대에서 사이즈 문의가 들어왔습니다.',
        timeAgo: '2분 전',
        icon: Icons.support_agent,
        iconColor: const Color(0xFF3F3BBD),
        iconBgColor: const Color(0xFFD8E2FF),
        hasActions: true,
        leftBorderColor: const Color(0xFF3F3BBD),
      ),
      NotificationItem(
        id: '2',
        title: '재고 부족 알림',
        content: '프리미엄 린넨 셔츠의 재고가 3개 남았습니다.',
        timeAgo: '15분 전',
        icon: Icons.inventory_2_outlined,
        iconColor: const Color(0xFFC2410C),
        iconBgColor: const Color(0xFFFFDCBF),
        leftBorderColor: const Color(0xFF3F3BBD),
      ),
      NotificationItem(
        id: '3',
        title: '시스템 점검 안내',
        content: '오늘 오후 10시부터 POS 시스템 정기 점검이 예정되어 있습니다.',
        timeAgo: '1시간 전',
        icon: Icons.info_outline,
        iconColor: const Color(0xFF5E5CE6),
        iconBgColor: const Color(0xFFE2DFFF),
        leftBorderColor: const Color(0xFF3F3BBD),
      ),
    ];

    _earlierItems = [
      NotificationItem(
        id: '4',
        title: '시즌 오프 프로모션 종료',
        content: '2024 S/S 시즌 오프 프로모션이 금일 자정으로 종료되었습니다. 홍보물 철거를 확인해주세요.',
        timeAgo: '어제',
        icon: Icons.campaign_outlined,
        iconColor: const Color(0xFF64748B),
        iconBgColor: const Color(0xFFEEEDF3),
      ),
      NotificationItem(
        id: '5',
        title: '근태 확인 요청',
        content: '지난 주 정산된 초과 근무 시간에 대한 승인 요청이 도착했습니다.',
        timeAgo: '2일 전',
        icon: Icons.badge_outlined,
        iconColor: const Color(0xFF64748B),
        iconBgColor: const Color(0xFFEEEDF3),
      ),
    ];
  }

  void _clearAllNotifications() {
    setState(() {
      _todayItems.clear();
      _earlierItems.clear();
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('모든 알림이 삭제되었습니다.'),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hasNotifications = _todayItems.isNotEmpty || _earlierItems.isNotEmpty;
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const _NotificationAppBar(),
      body: hasNotifications
          ? SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (_todayItems.isNotEmpty) ...[
                    _TodaySection(
                      items: _todayItems,
                      onAssist: (item) {
                        setState(() {
                          item.isRead = true;
                          item.hasActions = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${item.title} 응대를 수락했습니다.'),
                            backgroundColor: const Color(0xFF3F3BBD),
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      },
                      onDismiss: (item) {
                        setState(() {
                          _todayItems.remove(item);
                        });
                      },
                    ),
                    const SizedBox(height: 24),
                  ],
                  if (_earlierItems.isNotEmpty) ...[
                    _EarlierSection(items: _earlierItems),
                    const SizedBox(height: 24),
                  ],
                  const _EfficiencyInsightCard(),
                  const SizedBox(height: 80),
                ],
              ),
            )
          : const Center(
              child: Text(
                '새로운 알림이 없습니다.',
                style: TextStyle(color: Color(0xFF94A3B8), fontSize: 16),
              ),
            ),
      floatingActionButton: hasNotifications
          ? FloatingActionButton(
              onPressed: _clearAllNotifications,
              backgroundColor: const Color(0xFF3F3BBD),
              foregroundColor: Colors.white,
              shape: const CircleBorder(),
              child: const Icon(Icons.delete_sweep_outlined, size: 28),
            )
          : null,
    );
  }
}

class _NotificationAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _NotificationAppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      elevation: 0,
      scrolledUnderElevation: 0,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF3F3BBD), size: 20),
        onPressed: () => Navigator.pop(context),
      ),
      title: const Text(
        '알림',
        style: TextStyle(
          color: Color(0xFF3F3BBD),
          fontSize: 20,
          fontWeight: FontWeight.w700,
          letterSpacing: -0.2,
        ),
      ),
      flexibleSpace: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Color(0xFFE5E5EA))),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _TodaySection extends StatelessWidget {
  final List<NotificationItem> items;
  final Function(NotificationItem) onAssist;
  final Function(NotificationItem) onDismiss;

  const _TodaySection({
    required this.items,
    required this.onAssist,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Today',
              style: TextStyle(
                color: Color(0xFF464554),
                fontSize: 17,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.1,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: const Color(0xFF5856D6),
                borderRadius: BorderRadius.circular(99),
              ),
              child: Text(
                '${items.length} New',
                style: const TextStyle(
                  color: Color(0xFFE7E4FF),
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: items.length,
          separatorBuilder: (context, index) => const SizedBox(height: 8),
          itemBuilder: (context, index) {
            final item = items[index];
            return _NotificationCard(
              item: item,
              onAssist: () => onAssist(item),
              onDismiss: () => onDismiss(item),
            );
          },
        ),
      ],
    );
  }
}

class _EarlierSection extends StatelessWidget {
  final List<NotificationItem> items;

  const _EarlierSection({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Earlier',
          style: TextStyle(
            color: Color(0xFF464554),
            fontSize: 17,
            fontWeight: FontWeight.w600,
            letterSpacing: -0.1,
          ),
        ),
        const SizedBox(height: 12),
        Opacity(
          opacity: 0.8,
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: items.length,
            separatorBuilder: (context, index) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final item = items[index];
              return _NotificationCard(
                item: item,
              );
            },
          ),
        ),
      ],
    );
  }
}

class _NotificationCard extends StatelessWidget {
  final NotificationItem item;
  final VoidCallback? onAssist;
  final VoidCallback? onDismiss;

  const _NotificationCard({
    required this.item,
    this.onAssist,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    final isEarlier = item.leftBorderColor == null;
    return Container(
      decoration: BoxDecoration(
        color: isEarlier ? const Color(0xFFF4F3F8) : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isEarlier ? Border.all(color: const Color(0xFFC7C4D6)) : null,
        boxShadow: isEarlier
            ? null
            : const [
                BoxShadow(
                  color: Color(0x0A000000),
                  blurRadius: 8,
                  offset: Offset(0, 2),
                ),
              ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          if (item.leftBorderColor != null)
            Positioned(
              left: 0,
              top: 0,
              bottom: 0,
              width: 4,
              child: Container(color: item.leftBorderColor),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.leftBorderColor != null) const SizedBox(width: 4),
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: item.iconBgColor,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(item.icon, color: item.iconColor, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                color: Color(0xFF1A1B1F),
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Text(
                            item.timeAgo,
                            style: const TextStyle(
                              color: Color(0xFF777585),
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        item.content,
                        style: const TextStyle(
                          color: Color(0xFF464554),
                          fontSize: 14,
                          height: 1.35,
                        ),
                      ),
                      if (item.hasActions && onAssist != null && onDismiss != null) ...[
                        const SizedBox(height: 12),
                        _NotificationCardActions(
                          onAssist: onAssist!,
                          onDismiss: onDismiss!,
                        ),
                      ],
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
}

class _NotificationCardActions extends StatelessWidget {
  final VoidCallback onAssist;
  final VoidCallback onDismiss;

  const _NotificationCardActions({
    required this.onAssist,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ElevatedButton(
          onPressed: onAssist,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF3F3BBD),
            foregroundColor: Colors.white,
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            '응대하기',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
        const SizedBox(width: 8),
        ElevatedButton(
          onPressed: onDismiss,
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFFEEEDF3),
            foregroundColor: const Color(0xFF464554),
            elevation: 0,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
            minimumSize: Size.zero,
            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: const Text(
            '무시',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ),
      ],
    );
  }
}

class _EfficiencyInsightCard extends StatelessWidget {
  const _EfficiencyInsightCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 128,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            Image.network(
              'https://images.unsplash.com/photo-1441986300917-64674bd600d8?w=600&auto=format&fit=crop&q=80',
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: const Color(0xFF3F3BBD),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    const Color(0xFF3F3BBD).withOpacity(0.85),
                    const Color(0xFF3F3BBD).withOpacity(0.15),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Text(
                    'Efficiency Insight',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      letterSpacing: -0.2,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    'You resolved 15 alerts today. Keep it up!',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
