import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/api_service.dart';
import '../../data/models/user.dart';

// API Service Provider
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// App State
class AppState {
  final bool isLoggedIn;
  final User? currentUser;
  final String countryCode;
  final int notificationCount;
  final int messageCount;

  AppState({
    this.isLoggedIn = false,
    this.currentUser,
    this.countryCode = 'tz',
    this.notificationCount = 0,
    this.messageCount = 0,
  });

  AppState copyWith({
    bool? isLoggedIn,
    User? currentUser,
    String? countryCode,
    int? notificationCount,
    int? messageCount,
  }) {
    return AppState(
      isLoggedIn: isLoggedIn ?? this.isLoggedIn,
      currentUser: currentUser ?? this.currentUser,
      countryCode: countryCode ?? this.countryCode,
      notificationCount: notificationCount ?? this.notificationCount,
      messageCount: messageCount ?? this.messageCount,
    );
  }
}

class AppStateNotifier extends StateNotifier<AppState> {
  AppStateNotifier() : super(AppState());

  void setLoggedIn(bool value, {User? user}) {
    state = state.copyWith(isLoggedIn: value, currentUser: user);
  }

  void setCountryCode(String code) {
    state = state.copyWith(countryCode: code);
  }

  void updateNotificationCount(int count) {
    state = state.copyWith(notificationCount: count);
  }

  void updateMessageCount(int count) {
    state = state.copyWith(messageCount: count);
  }

  void updateLocation(double lat, double lng, String city) {
    if (state.currentUser != null) {
      state = state.copyWith(
        currentUser: state.currentUser!.copyWith(
          latitude: lat,
          longitude: lng,
          city: city,
        ),
      );
    }
  }
}

final appStateProvider = StateNotifierProvider<AppStateNotifier, AppState>((ref) {
  return AppStateNotifier();
});
