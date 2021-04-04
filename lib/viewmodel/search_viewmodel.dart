import 'package:flutter/cupertino.dart';

import '../model/user_model.dart';
import '../services/user_services.dart';

class SearchViewModel with ChangeNotifier {
  String _searchText = '';
  String get getSearchText => _searchText;
  UserServices _userServices = UserServices();
  void setSearchText(String value) {
    _searchText = value;
    notifyListeners();
  }

  Stream<List<UserModel>> searchWithUsername() {
    return _userServices.searchWithUsername(_searchText);
  }
}
