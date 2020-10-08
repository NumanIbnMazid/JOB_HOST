import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:job_host/registration/bloc/registration_bloc.dart';
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:job_host/shared/snackBars.dart';
import 'package:job_host/shared/textInputDecoration.dart';

class RegistrationForm extends StatefulWidget {
  @override
  State<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _password1Controller = TextEditingController();
  final _password2Controller = TextEditingController();

  List accountTypeChoicesDataSource = [
    {"display": "Job Seeker", "value": "Job Seeker"},
    {"display": "Employer", "value": "Employer"},
  ];
  String _selectedAccountType;

  Map<String, dynamic> formFieldProperty = {
    'username': {'fieldStatus': true, 'fieldMessage': '', 'isChanged': false},
    'email': {'fieldStatus': true, 'fieldMessage': '', 'isChanged': false},
    'password1': {'fieldStatus': true, 'fieldMessage': '', 'isChanged': false},
    'password2': {'fieldStatus': true, 'fieldMessage': '', 'isChanged': false},
  };

  bool _autoValidate = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _password1Controller.dispose();
    _password2Controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _selectedAccountType = '';
  }

  @override
  Widget build(BuildContext context) {
    _onRegistrationButtonPressed() {
      setState(() {
        _selectedAccountType = _selectedAccountType;
      });

      if (_formKey.currentState.validate()) {
        final int _formFieldPropertyLength = formFieldProperty.length;
        var _iterator = 0;
        formFieldProperty.forEach((key, value) {
          if (formFieldProperty[key]['fieldStatus'] == true) {
            _iterator++;
            if (_iterator == _formFieldPropertyLength) {
              BlocProvider.of<RegistrationBloc>(context).add(
                RegistrationButtonPressed(
                  username: _usernameController.text,
                  email: _emailController.text,
                  accountType: _selectedAccountType,
                  password1: _password1Controller.text,
                  password2: _password2Controller.text,
                ),
              );
            }
          }
        });
      } else {
        setState(() {
          _autoValidate = true;
        });
      }
    }

    _formFieldOnChanged({
      String fieldName,
      String fieldValue,
      bool requiredField,
      String modelName,
      String searchType,
    }) {
      BlocProvider.of<RegistrationBloc>(context).add(
        RegistrationFormFieldOnChanged(
          fieldName: fieldName,
          fieldValue: fieldValue,
          requiredField: requiredField,
          modelName: modelName,
          searchType: searchType,
        ),
      );
    }

    _validateEmail(value) {
      if (value.isEmpty) {
        return 'Please enter your email address!';
      }
      bool isValidEmail =
          RegExp(r"^[a-z0-9]+[\._]?[a-z0-9]+[@]\w+[.]\w{2,3}$").hasMatch(value);
      // print(isValidEmail);
      if (isValidEmail == false) {
        return "Please enter a valid email!";
      }
      return null;
    }

    _validateUsername(value) {
      if (value.isEmpty) {
        return 'Please enter your desired username!';
      }
      return null;
    }

    _validatePassword1(value) {
      if (value.isEmpty) {
        return 'Please enter your password!';
      }
      return null;
    }

    _validatePassword2(value) {
      if (value.isEmpty) {
        return 'Please enter your password again!';
      }
      if (value != _password1Controller.text) {
        return "Password does not match";
      }
      return null;
    }

    return BlocListener<RegistrationBloc, RegistrationState>(
      listener: (context, state) {
        if (state is RegistrationFailure) {
          Scaffold.of(context).showSnackBar(
            errorSnackBar(
              duration: 7,
              errorText: state.error,
            ),
          );
        }
        if (state is RegistrationFormFieldValidation) {
          setState(() {
            formFieldProperty[state.fieldName.toString()]['fieldStatus'] =
                state.status;
            formFieldProperty[state.fieldName.toString()]['fieldMessage'] =
                state.message;
            formFieldProperty[state.fieldName.toString()]['isChanged'] = true;
          });
        }
        // if (state is RegistrationFormFieldValidation &&
        //     state.fieldName == 'email') {
        //   setState(() {
        //     formFieldProperty['email']['fieldStatus'] = state.status;
        //     formFieldProperty['email']['fieldMessage'] = state.message;
        //     formFieldProperty['email']['isChanged'] = true;
        //   });
        // }
      },
      child: BlocBuilder<RegistrationBloc, RegistrationState>(
        builder: (context, state) {
          return Form(
            key: _formKey,
            autovalidate: _autoValidate,
            child: Padding(
              padding: const EdgeInsets.all(23.0),
              child: Column(
                children: [
                  TextFormField(
                    autofocus: true,
                    decoration: textInputDecoration(
                      fieldStatus: formFieldProperty['username']['fieldStatus'],
                      fieldMessage: formFieldProperty['username']
                          ['fieldMessage'],
                      isChanged: formFieldProperty['username']['isChanged'],
                      labelText: 'Username *',
                      prefixIcon: Icons.person,
                    ),
                    controller: _usernameController,
                    validator: _validateUsername,
                    onChanged: (value) {
                      _formFieldOnChanged(
                        fieldName: 'username',
                        fieldValue: value,
                        requiredField: true,
                        modelName: 'User',
                        searchType: 'iexact',
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: textInputDecoration(
                      fieldStatus: formFieldProperty['email']['fieldStatus'],
                      fieldMessage: formFieldProperty['email']['fieldMessage'],
                      isChanged: formFieldProperty['email']['isChanged'],
                      labelText: 'Email *',
                      prefixIcon: Icons.email,
                    ),
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: _validateEmail,
                    onChanged: (value) {
                      _formFieldOnChanged(
                        fieldName: 'email',
                        fieldValue: value,
                        requiredField: true,
                        modelName: 'User',
                        searchType: 'iexact',
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  Container(
                    // color: Colors.white,
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: _selectedAccountType == ''
                            ? Colors.white
                            : Colors.blue,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      color: Colors.white,
                    ),
                    child: DropDownFormField(
                      titleText: 'Account Type *',
                      hintText: 'Please Select Account Type',
                      value: _selectedAccountType,
                      onSaved: (value) {
                        setState(() {
                          _selectedAccountType = value;
                        });
                      },
                      onChanged: (value) {
                        setState(() {
                          _selectedAccountType = value;
                        });
                      },
                      dataSource: accountTypeChoicesDataSource,
                      textField: 'display',
                      valueField: 'value',
                      required: true,
                      validator: (value) {
                        if (value == null) {
                          return "Please select an account type!";
                        }
                        return null;
                      },
                    ),
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: textInputDecoration(
                      fieldStatus: formFieldProperty['password1']
                          ['fieldStatus'],
                      fieldMessage: formFieldProperty['password1']
                          ['fieldMessage'],
                      isChanged: formFieldProperty['password1']['isChanged'],
                      labelText: 'Password *',
                      prefixIcon: Icons.lock,
                    ),
                    controller: _password1Controller,
                    obscureText: true,
                    validator: _validatePassword1,
                    onChanged: (value) {
                      _formFieldOnChanged(
                        fieldName: 'password1',
                        fieldValue: value,
                        requiredField: true,
                      );
                    },
                  ),
                  SizedBox(height: 10),
                  TextFormField(
                    decoration: textInputDecoration(
                      isChanged: formFieldProperty['password1']['isChanged'],
                      labelText: 'Confirm Password *',
                      prefixIcon: Icons.lock,
                      fieldStatus:
                          _password1Controller.text == _password2Controller.text
                              ? true
                              : false,
                    ),
                    controller: _password2Controller,
                    obscureText: true,
                    validator: _validatePassword2,
                    onChanged: (value) {
                      _formFieldOnChanged(
                        fieldName: 'password2',
                        fieldValue: value,
                        requiredField: true,
                      );
                    },
                  ),
                  SizedBox(height: 15),
                  RaisedButton(
                    onPressed: state is! RegistrationInProgress
                        ? _onRegistrationButtonPressed
                        : null,
                    child: Text('Register'),
                  ),
                  Container(
                    child: state is RegistrationInProgress
                        ? CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
