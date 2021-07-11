import 'package:flutter/material.dart';
import 'homeScreen.dart';

class LoginDemo extends StatefulWidget {
  @override
  _LoginDemoState createState() => _LoginDemoState();
}

class _LoginDemoState extends State<LoginDemo> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String name = 'admin';
  String password = 'admin';
  bool _obscureText = true;
  bool isValid = false;
  final _formKey = GlobalKey<FormState>();
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  void _trySubmitForm() {
    if (_formKey.currentState!.validate()) {
      if (usernameController.text == name &&
          passwordController.text == password) {
        Navigator.push(context, MaterialPageRoute(builder: (_) => MapSample()));
      }
      print('Everything looks good!');
      print(usernameController.text);
      print(passwordController.text);
    } else {
      return print('invalid');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 150.0),
                child: Center(
                  child: Container(
                      width: 200,
                      height: 150,
                      /*decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(50.0)),*/
                      child: Text(
                        "SignIn",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.black,
                          fontWeight: FontWeight.w700,
                          fontStyle: FontStyle.normal,
                        ),
                      )),
                ),
              ),
              Padding(
                //padding: const EdgeInsets.only(left:15.0,right: 15.0,top:0,bottom: 0),
                padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      labelText: 'Username',
                      hintText: 'Enter valid Username as admin'),
                  validator: (value) {
                    if (usernameController.text.isEmpty) {
                      return 'Please enter Username';
                    }
                    if (usernameController.text != name) {
                      return 'Invalid Usename';
                    }
                  },
                  controller: usernameController,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 15, bottom: 0),
                //padding: EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                        borderSide: BorderSide(
                          color: Colors.deepPurple,
                        )),
                    labelText: 'Password',
                    hintText: 'Enter valid Password as admin',
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: _toggle,
                    ),
                  ),
                  validator: (value) {
                    if (passwordController.text.isEmpty) {
                      return 'Please enter Password';
                    }
                    if (passwordController.text != password) {
                      return 'Invalid Password';
                    }
                  },
                  obscureText: _obscureText,
                  controller: passwordController,
                ),
              ),
              FlatButton(
                onPressed: () {
                  //TODO FORGOT PASSWORD SCREEN GOES HERE
                },
                child: Text(
                  'Forgot Password',
                  style: TextStyle(color: Colors.deepPurple, fontSize: 15),
                ),
              ),
              Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(20)),
                child: FlatButton(
                  onPressed: _trySubmitForm,
                  child: Text(
                    'Login',
                    style: TextStyle(color: Colors.white, fontSize: 25),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text('New User? Create Account')
            ],
          ),
        ),
      ),
    );
  }
}
