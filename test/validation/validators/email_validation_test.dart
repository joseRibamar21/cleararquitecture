import 'package:test/test.dart';

import 'package:cleanarquiteture2/validation/validators/validators.dart';

void main() {
  EmailValidation sut;

  setUp(() {
    sut = EmailValidation('any_field');
  });

  test('Should return null if email is empty', () {
    expect(sut.validate(''), null);
  });

  test('Should return null if email is null', () {
    expect(sut.validate(null), null);
  });

  test('Should return null if email is valid', () {
    expect(sut.validate('jose.21rbrb@gmail.com'), null);
  });

  test('Should return null if email is invalid', () {
    expect(sut.validate('jose.21rbrb'), 'Campo inválido');
  });
}
