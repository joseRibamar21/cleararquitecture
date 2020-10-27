abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get isFormValidStream;

  void validadeEmail(String email);
  void validadePassword(String password);
}
