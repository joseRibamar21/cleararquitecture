abstract class LoginPresenter {
  Stream get emailErrorStream;

  void validadeEmail(String email);
  void validadePassword(String password);
}
