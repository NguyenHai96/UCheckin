import 'package:flutter/cupertino.dart';

class LoginPageProvider extends ChangeNotifier {
  LoginPageProvider();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isHidden = true;
  bool isActiveSignUp = false;

  void togglePasswordView() {
    isHidden = !isHidden;
    notifyListeners();
  }

  bool checkSignUp() {
    if (emailController.text.isNotEmpty && passwordController.text.isNotEmpty) {
      notifyListeners();
      return true;
    }
    notifyListeners();
    return false;
  }
}
