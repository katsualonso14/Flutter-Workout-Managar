
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';

@freezed
 class Users with _$Users {
  const factory Users({
    required String uid,
    required String email,
  }) = _Users;
}