import 'package:faker/faker.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

import 'package:cleanarquiteture2/domain/helpers/helpers.dart';
import 'package:cleanarquiteture2/domain/entities/entities.dart';
import 'package:cleanarquiteture2/domain/usecases/usecases.dart';

import 'package:cleanarquiteture2/presenter/presenters/presenters.dart';
import 'package:cleanarquiteture2/presenter/protocols/protocols.dart';

class ValidationSpy extends Mock implements Validation {}

class AuthenticationSpy extends Mock implements Authentication {}

void main() {
  StreamLoginPresenter sut;
  ValidationSpy validation;
  AuthenticationSpy authentication;
  String email;
  String password;

  PostExpectation mockValidationCall(String field) => when(validation.validate(
      field: field == null ? anyNamed('field') : field,
      value: anyNamed('value')));

  void mockValidation({String field, String value}) {
    mockValidationCall(field).thenReturn(value);
  }

  PostExpectation mockAuthenticationCall() => when(authentication.auth(any));

  void mockAuthentication({String field, String value}) {
    mockAuthenticationCall()
        .thenAnswer((_) => AccountEntity(faker.guid.guid()));
  }

  void mockAuthenticationError(DomainError error) {
    mockAuthenticationCall().thenThrow(error);
  }

  setUp(() {
    validation = ValidationSpy();
    authentication = AuthenticationSpy();
    sut = StreamLoginPresenter(
        validation: validation, authentication: authentication);
    email = faker.internet.email();
    password = faker.internet.password();
    mockValidation();
    mockAuthentication();
  });

  test('Should call Validation with correct email', () {
    sut.validadeEmail(email);
    verify(validation.validate(field: 'email', value: email)).called(1);
  });

  test('Should emit email error if validation fails', () {
    mockValidation(value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validadeEmail(email);
    sut.validadeEmail(email);
  });

  test('Should emit email error if validation succeeds', () {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validadeEmail(email);
    sut.validadeEmail(email);
  });

  test('Should call Validation with correct password', () {
    sut.validadePassword(password);
    verify(validation.validate(field: 'password', value: password)).called(1);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(value: 'error');

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validadePassword(password);
    sut.validadePassword(password);
  });

  test('Should emit password error if validation fails', () {
    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validadePassword(password);
    sut.validadePassword(password);
  });

  test('Should emit password error if validation fails', () {
    mockValidation(field: 'email', value: 'error');

    sut.emailErrorStream
        .listen(expectAsync1((error) => expect(error, 'error')));

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    sut.isFormValidStream
        .listen(expectAsync1((isValid) => expect(isValid, false)));

    sut.validadeEmail(email);
    sut.validadePassword(password);
  });

  test('Should emit password error if validation fails', () async {
    sut.emailErrorStream.listen(expectAsync1((error) => expect(error, null)));

    sut.passwordErrorStream
        .listen(expectAsync1((error) => expect(error, null)));

    expectLater(sut.isFormValidStream, emitsInOrder([false, true]));

    sut.validadeEmail(email);
    await Future.delayed(Duration.zero);
    sut.validadePassword(password);
  });

  test('Should call Authentication with correct values', () async {
    sut.validadeEmail(email);
    sut.validadePassword(password);
    await sut.auth();

    verify(authentication
            .auth(AuthenticationParams(email: email, password: password)))
        .called(1);
  });

  test('Should emits correct events on Authentication success', () async {
    sut.validadeEmail(email);
    sut.validadePassword(password);

    expectLater(sut.isLoadingStream, emitsInOrder([true, false]));

    await sut.auth();
  });

  test('Should emits correct events on InvalidCredentialsError', () async {
    mockAuthenticationError(DomainError.invalidCredentials);
    sut.validadeEmail(email);
    sut.validadePassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(
        expectAsync1((error) => expect(error, 'Credenciais inválidas.')));

    await sut.auth();
  });

  test('Should emits correct events on UnexpectedError', () async {
    mockAuthenticationError(DomainError.unexpected);
    sut.validadeEmail(email);
    sut.validadePassword(password);

    expectLater(sut.isLoadingStream, emits(false));
    sut.mainErrorStream.listen(expectAsync1((error) =>
        expect(error, 'Algo errado aconteceu. Tente novamente em breve.')));

    await sut.auth();
  });

  test('Should not emit after dispose', () async {
    expectLater(sut.emailErrorStream, neverEmits(null));
    sut.dispose();
    sut.validadeEmail(email);
  });
}
