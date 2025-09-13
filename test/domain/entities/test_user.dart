import 'package:flutter_workout_manager/domain/entities/user_entity.dart';

// テスト用のユーザー
const testId = 'test_id';
const testMailAddress = 'test@test.com';
const testPassword = 'test_password';

final testUser = UserEntity(
  uid: testId,
  email: testMailAddress,
);
