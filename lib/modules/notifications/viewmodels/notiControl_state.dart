import 'package:freezed_annotation/freezed_annotation.dart';

part 'notiControl_state.freezed.dart';
@Freezed()
class NotiControlState with _$NotiControlState {
  const factory NotiControlState.loading() = _Loading;

  const factory NotiControlState.error({String? errorText}) = _Error;

  const factory NotiControlState.available() = _Available;
}