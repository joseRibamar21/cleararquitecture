import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
              height: 240,
              margin: EdgeInsets.only(bottom: 32),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topRight,
                  end: Alignment.bottomLeft,
                  colors: [
                    Theme.of(context).primaryColorLight,
                    Theme.of(context).primaryColorDark
                  ]
                ),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0,0),
                    spreadRadius: 0,
                    blurRadius: 4,
                    color: Colors.black
                  ),
                ],
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80))
              ),
              child: Image(image: AssetImage('lib/ui/assets/camicase01.png')),
            ),
            Text('Login'.toUpperCase(),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.headline1,),
            Form(
                child: Column(
              children: <Widget>[
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    icon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Senha',
                    icon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text('Entrar'.toUpperCase()),
                ),
                FlatButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.person),
                    label: Text('Criar Conta'))
              ],
            ))
          ],
        ),
      ),
    );
  }
}
