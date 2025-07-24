import 'package:flutter_workout_manager/domain/entities/user_entity.dart';

// テスト用のユーザー
const testId = 'test_id';
const testMailAddress = 'test@test.com';

final testUser = UserEntity(
  uid: testId,
  email: testMailAddress,
);
