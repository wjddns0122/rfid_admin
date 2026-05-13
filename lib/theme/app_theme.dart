import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF5E5CE6);
  static const background = Color(0xFFFAF9FE);
  
  static const textPrimary = Color(0xFF1A1B1F);
  static const textSecondary = Color(0xFF464554);
  static const textOnPrimary = Color(0xFFF4F1FF);
  
  static const cardBackground = Color(0xFFF4F3F8);
  static const cardBorder = Color(0x4DC7C4D7); // rgba(199,196,215,0.3)
  
  static const statusWaitBg = Color(0x1A4441CC); 
  static const statusWaitText = Color(0xFF4441CC);
  
  static const statusProcessBg = Color(0x1A8D2EBC);
  static const statusProcessText = Color(0xFF8D2EBC);
  
  static const bottomNavUnselected = Color(0xFF94A3B8);
  static const bottomNavSelected = Color(0xFF5E5CE6);
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        background: AppColors.background,
      ),
      scaffoldBackgroundColor: AppColors.background,
      fontFamily: 'Pretendard', // 프로젝트 설정에 맞춰 폰트 변경
    );
  }
}
