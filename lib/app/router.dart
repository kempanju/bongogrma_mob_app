import 'package:go_router/go_router.dart';
import '../features/home/home_screen.dart';
import '../features/posts/post_detail_screen.dart';
import '../features/search/search_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/notifications/notifications_screen.dart';
import '../features/gallery/gallery_screen.dart';
import '../features/school/search_school_screen.dart';
import '../features/school/list_education_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/auth/complete_profile_screen.dart';
import '../features/auth/user_profile_screen.dart';
import '../features/auth/follow_screen.dart';
import '../features/bongogram/social_feed_screen.dart';
import '../features/bongogram/create_social_post_screen.dart';
import '../features/bongogram/trending_screen.dart';
import '../features/notepad/notes_list_screen.dart';
import '../features/tags/tags_screen.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/post/:id',
        builder: (context, state) {
          final postId = int.parse(state.pathParameters['id']!);
          final title = state.extra as String? ?? '';
          return PostDetailScreen(postId: postId, title: title);
        },
      ),
      GoRoute(
        path: '/search',
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: '/notifications',
        builder: (context, state) => const NotificationsScreen(),
      ),
      GoRoute(
        path: '/gallery/:postId',
        builder: (context, state) {
          final postId = int.parse(state.pathParameters['postId']!);
          return GalleryScreen(postId: postId);
        },
      ),
      GoRoute(
        path: '/school/search',
        builder: (context, state) => const SearchSchoolScreen(),
      ),
      GoRoute(
        path: '/school/education',
        builder: (context, state) => const ListEducationScreen(),
      ),
      GoRoute(
        path: '/auth/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/auth/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/auth/complete-profile',
        builder: (context, state) => const CompleteProfileScreen(),
      ),
      GoRoute(
        path: '/auth/user/:userId',
        builder: (context, state) {
          final userId = int.parse(state.pathParameters['userId']!);
          return UserProfileScreen(userId: userId);
        },
      ),
      GoRoute(
        path: '/auth/follow/:userId',
        builder: (context, state) {
          final userId = int.parse(state.pathParameters['userId']!);
          final showFollowers = state.uri.queryParameters['type'] == 'followers';
          return FollowScreen(userId: userId, showFollowers: showFollowers);
        },
      ),
      GoRoute(
        path: '/social/feed',
        builder: (context, state) => const SocialFeedScreen(),
      ),
      GoRoute(
        path: '/social/create',
        builder: (context, state) => const CreateSocialPostScreen(),
      ),
      GoRoute(
        path: '/social/trending',
        builder: (context, state) => const TrendingScreen(),
      ),
      GoRoute(
        path: '/notepad',
        builder: (context, state) => const NotesListScreen(),
      ),
      GoRoute(
        path: '/tags',
        builder: (context, state) {
          final tag = state.uri.queryParameters['tag'];
          return TagsScreen(initialTag: tag);
        },
      ),
    ],
  );
}
