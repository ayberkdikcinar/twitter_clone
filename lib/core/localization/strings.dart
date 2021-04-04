class ApplicationStrings {
  static ApplicationStrings _instance;
  static ApplicationStrings get instance {
    if (_instance != null) {
      return _instance;
    }
    _instance = ApplicationStrings._init();
    return _instance;
  }

  ApplicationStrings._init();

  final String loginwithGoogle = 'Login With Google';
  final String loginWithEmail = 'Login With Email';
  final String follow = 'Follow';
  final String unfollow = 'Unfollow';
  final String editProfile = 'Edit Profile';
  final String following = 'Following';
  final String followers = 'Followers';
  final String home = 'Home';
  final String noPostError = 'There are no posts to show';
  final String accountDetail = 'Account Detail';
  final String profile = 'Profile';
  final String logOut = 'Logout';
}
