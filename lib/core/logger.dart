import 'package:logger/logger.dart';

/// ログ出力用ファイル
final logger = Logger(
  printer: PrettyPrinter(
    lineLength: 100, // デフォルト120が少し横長なので調整
    methodCount: 4, // 4つぐらいの深さで見るように調整
  ),
);