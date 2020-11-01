abstract class LoginPresenter {
  Stream get emailErrorStream;
  Stream get passwordErrorStream;
  Stream get mainErrorStream;
  Stream get isFormValidStream;
  Stream get isLoadingStream;

  void validadeEmail(String email);
  void validadePassword(String password);
  void auth();
  void dispose();
}
