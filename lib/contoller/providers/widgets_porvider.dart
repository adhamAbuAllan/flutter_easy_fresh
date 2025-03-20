import 'package:flutter_riverpod/flutter_riverpod.dart';

final isVisibleNotifier = StateProvider<bool>((ref) => false);
final isBoxVisibleNotifier = StateProvider<bool>((ref) => false);
final isLevelTwoNotifier = StateProvider<bool>((ref) => false);
final isLevelOneNotifier = StateProvider<bool>((ref) => false);
final isLevelThreeNotifier = StateProvider<bool>((ref) => false);
final isListOfTypesNotifier = StateProvider<bool>((ref) => false);
final isEn = StateProvider<bool>((ref) => false);
final isDurationFilterLoading = StateProvider<bool>((ref) => false);
final apartmentTypeNotifier = StateProvider<String>((ref) => 'طلاب');
final selectedCityIdToFilter = StateProvider<int>((ref) => 0);

