import '../models/app_language.dart';
import '../models/input_kind.dart';

class AppStrings {
  const AppStrings._({
    required this.tagline,
    required this.settings,
    required this.language,
    required this.theme,
    required this.system,
    required this.light,
    required this.dark,
    required this.live,
    required this.waiting,
    required this.pickImage,
    required this.removeImage,
    required this.copy,
    required this.share,
    required this.copied,
    required this.shareText,
    required this.shareFailed,
    required this.textKind,
    required this.linkKind,
    required this.phoneKind,
    required this.imageKind,
    required this.textLabel,
    required this.linkLabel,
    required this.phoneLabel,
    required this.imageLabel,
  });

  final String tagline;
  final String settings;
  final String language;
  final String theme;
  final String system;
  final String light;
  final String dark;
  final String live;
  final String waiting;
  final String pickImage;
  final String removeImage;
  final String copy;
  final String share;
  final String copied;
  final String shareText;
  final String shareFailed;
  final String textKind;
  final String linkKind;
  final String phoneKind;
  final String imageKind;
  final String textLabel;
  final String linkLabel;
  final String phoneLabel;
  final String imageLabel;

  static AppStrings of(AppLanguage language) {
    return language == AppLanguage.ar ? ar : en;
  }

  String kind(InputKind kind) {
    return switch (kind) {
      InputKind.text => textKind,
      InputKind.link => linkKind,
      InputKind.phone => phoneKind,
      InputKind.image => imageKind,
    };
  }

  String inputLabel(InputKind kind) {
    return switch (kind) {
      InputKind.text => textLabel,
      InputKind.link => linkLabel,
      InputKind.phone => phoneLabel,
      InputKind.image => imageLabel,
    };
  }

  static const ar = AppStrings._(
    tagline: 'اكتب، شاهد، وشارك رمزك فورًا',
    settings: 'الإعدادات',
    language: 'اللغة',
    theme: 'المظهر',
    system: 'النظام',
    light: 'فاتح',
    dark: 'داكن',
    live: 'الرمز جاهز ويتحدث مباشرة',
    waiting: 'ابدأ بإدخال محتوى لإنشاء الرمز',
    pickImage: 'اختيار صورة',
    removeImage: 'إزالة الصورة',
    copy: 'نسخ',
    share: 'مشاركة',
    copied: 'تم نسخ محتوى الرمز',
    shareText: 'تم إنشاؤه بواسطة QR One',
    shareFailed: 'تعذرت مشاركة الرمز',
    textKind: 'نص',
    linkKind: 'رابط',
    phoneKind: 'جوال',
    imageKind: 'صورة',
    textLabel: 'اكتب النص هنا',
    linkLabel: 'أدخل الرابط',
    phoneLabel: 'أدخل رقم الجوال',
    imageLabel: 'عنوان أو وصف الصورة',
  );

  static const en = AppStrings._(
    tagline: 'Type, preview, and share your code instantly',
    settings: 'Settings',
    language: 'Language',
    theme: 'Theme',
    system: 'System',
    light: 'Light',
    dark: 'Dark',
    live: 'Your code is ready and updating live',
    waiting: 'Add content to generate a code',
    pickImage: 'Pick image',
    removeImage: 'Remove image',
    copy: 'Copy',
    share: 'Share',
    copied: 'QR content copied',
    shareText: 'Created with QR One',
    shareFailed: 'Could not share the QR code',
    textKind: 'Text',
    linkKind: 'Link',
    phoneKind: 'Phone',
    imageKind: 'Image',
    textLabel: 'Write your text',
    linkLabel: 'Enter a link',
    phoneLabel: 'Enter a phone number',
    imageLabel: 'Image title or caption',
  );
}
