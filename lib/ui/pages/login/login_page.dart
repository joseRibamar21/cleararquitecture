import 'package:flutter/material.dart';

import '../../components/components.dart';
import 'login_presenter.dart';

class LoginPage extends StatelessWidget {
  final LoginPresenter presenter;

  LoginPage(this.presenter);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            LoginHeader(),
            Headline1(text: 'Login'),
            Padding(
              padding: EdgeInsets.all(32),
              child: Form(
                  child: Column(
                children: <Widget>[
                  StreamBuilder<String>(
                    stream: presenter.emailErrorStream,
                    builder: (context, snapshot) {
                      return TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Email',
                          icon: Icon(Icons.email,
                              color: Theme.of(context).primaryColorLight),
                          errorText: snapshot.data
                        ),
                        keyboardType: TextInputType.emailAddress,
                        onChanged: presenter.validadeEmail,
                      );
                    }
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 8, bottom: 32),
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Senha',
                        icon: Icon(Icons.lock,
                            color: Theme.of(context).primaryColorLight),
                      ),
                      onChanged: presenter.validadePassword,
                      obscureText: true,
                    ),
                  ),
                  RaisedButton(
                    onPressed: null,
<<<<<<< HEAD:lib/ui/pages/login/login_page.dart
=======
                    
>>>>>>> 9c977eb9718dcd0e34f29abe59348612131e17ab:lib/ui/pages/login_page.dart
                    child: Text('Entrar'.toUpperCase()),
                  ),
                  FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.person),
                      label: Text('Criar Conta'))
                ],
              )),
            )
          ],
        ),
      ),
    );
  }
}
