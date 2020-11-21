import 'package:first_app/widgets/pickers/user_image.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AuthForm extends StatefulWidget {
  AuthForm(
    this.submitFn,
    this.isLoading,
  );
  final bool isLoading;
  final void Function(
    String email,
    String userName,
    String phoneNumber,
    String address,
    String role,
    String password,
    File image,
    bool isLogin,
    BuildContext ctx,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}

class _AuthFormState extends State<AuthForm> {
  final _formkey = GlobalKey<FormState>();
  var _isLogin = true;
  var _userEmail = '';
  var _userName = '';
  var _userPhoneNumber = '';
  var _useraddress = '';
  var _userrole = '';
  var _userPassword = '';

  File _userImageFile;

  void _pickedImage(File image) {
    _userImageFile = image;
  }

  void _trySubmit() {
    final isValid = _formkey.currentState.validate();
    FocusScope.of(context).unfocus();

    if (_userImageFile == null && !_isLogin) {
      Scaffold.of(context).showSnackBar(
        SnackBar(
          content: Text('Please pick an image'),
          backgroundColor: Theme.of(context).errorColor,
        ),
      );
      return;
    }

    if (isValid) {
      _formkey.currentState.save();
      widget.submitFn(
        _userEmail.trim(),
        _userName.trim(),
        _userPhoneNumber,
        _useraddress,
        _userrole,
        _userPassword.trim(),
        _userImageFile,
        _isLogin,
        context,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Color(0xff8998BF),
        margin: EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Form(
              key: _formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text(
                    'Daily Wings',
                    style: TextStyle(
                      fontFamily: 'SyneMono',
                      color: Color(0xff3E3758),
                      fontSize: 35.0,
                      fontWeight: FontWeight.w900,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  if (!_isLogin) UserImagePicker(_pickedImage),
                  TextFormField(
                    key: ValueKey('email'),
                    validator: (value) {
                      if (value.isEmpty || !value.contains('@')) {
                        return 'Please enter a valid email address.';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: 'Email address',
                    ),
                    onSaved: (value) {
                      _userEmail = value;
                    },
                  ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('userName'),
                      validator: (value) {
                        if (value.isEmpty || value.length < 4) {
                          return 'Please enter atleast 4 characters.';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Username'),
                      onSaved: (value) {
                        _userName = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('phoneNumber'),
                      validator: (value) {
                        if (value.isEmpty ||
                            value.length < 10 ||
                            value.length > 10) {
                          return 'Please enter a valid number';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Phone number'),
                      onSaved: (value) {
                        _userPhoneNumber = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('address'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter a valid address';
                        }
                        return null;
                      },
                      decoration: InputDecoration(labelText: 'Address'),
                      onSaved: (value) {
                        _useraddress = value;
                      },
                    ),
                  if (!_isLogin)
                    TextFormField(
                      key: ValueKey('role'),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please enter worker or employer';
                        }
                        return null;
                      },
                      decoration:
                          InputDecoration(labelText: 'Role(worker/employer)'),
                      onSaved: (value) {
                        _userrole = value;
                      },
                    ),
                  TextFormField(
                    key: ValueKey('password'),
                    validator: (value) {
                      if (value.isEmpty || value.length < 7) {
                        return 'Password must be at least 7 characters long.';
                      }
                      return null;
                    },
                    decoration: InputDecoration(labelText: 'Password'),
                    obscureText: true,
                    onSaved: (value) {
                      _userPassword = value;
                    },
                  ),
                  SizedBox(height: 12),
                  if (widget.isLoading) CircularProgressIndicator(),
                  if (!widget.isLoading)
                    RaisedButton(
                      child: Text(_isLogin ? 'Login' : 'Signup'),
                      onPressed: _trySubmit,
                    ),
                  if (!widget.isLoading)
                    FlatButton(
                      textColor: Color(0xff3E3758),
                      child: Text(_isLogin
                          ? 'Create new account'
                          : 'I already have an account'),
                      onPressed: () {
                        setState(() {
                          _isLogin = !_isLogin;
                        });
                      },
                    )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
