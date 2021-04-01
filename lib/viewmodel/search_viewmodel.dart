import 'package:endower/model/user_model.dart';
import 'package:endower/services/user_services.dart';
import 'package:flutter/cupertino.dart';

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
