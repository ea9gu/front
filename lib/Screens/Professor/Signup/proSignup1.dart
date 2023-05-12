import 'package:ea9gu/Components/accountcheck.dart';
import 'package:ea9gu/Components/input_form.dart';
import 'package:ea9gu/Components/next_button.dart';
import 'package:ea9gu/Screens/Professor/Login/pro_login.dart';
import 'package:ea9gu/Screens/Professor/Signup/proSignup2.dart';
import 'package:flutter/material.dart';
import 'package:ea9gu/Components/validate.dart';

class ProSignup1 extends StatefulWidget {
  @override
  SignUpFormState createState() => SignUpFormState();
}

class SignUpFormState extends State<ProSignup1> {
  final _formKey = GlobalKey<FormState>();
  String name = '';
  int? id;
  final password_controller = TextEditingController();
  String password_confirm = '';
  String email = '';

  String? validateConfirmPassword(String? value) {
    if (value != password_controller.text) {
      return '비밀번호가 다릅니다.';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      //두번째 padding <- LIstview에 속함.
      padding: const EdgeInsets.all(16.0),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SizedBox(
                height: 80,
              ),
              Text('회원가입하기',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
              SizedBox(height: 50),
              buildTextFormField(
                hintText: "이름",
                validator: (value) => Validate().validateName(value),
                onSaved: (value) {
                  name = value!;
                },
              ),
              SizedBox(height: 15),
              buildTextFormField(
                controller: password_controller,
                hintText: "비밀번호",
                validator: (value) => Validate().validatePassword(value),
                obscureText: true,
              ),
              SizedBox(height: 15),
              buildTextFormField(
                hintText: "비밀번호 확인",
                validator: validateConfirmPassword,
                obscureText: true,
                onSaved: (value) {
                  password_confirm = value!;
                },
              ),
              SizedBox(height: 15),
              buildTextFormField(
                hintText: "이메일",
                validator: (value) => Validate().validateEmail(value),
                onSaved: (value) {
                  email = value!;
                },
              ),
              SizedBox(height: 30),
              Column(children: [
                NextButton(
                    text: "계속",
                    onpress: () {
                      if (_formKey.currentState!.validate()) {
                        // 유효성 검사가 모두 통과된 경우 처리
                        _formKey.currentState!.save();
                        final password = password_controller.text;
                        email = email.split('@')[0];
                        print('Name: $name');
                        print('Username: $id');
                        print('Password: $password');
                        print('Email: $email');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return proSignup2();
                            },
                          ),
                        );
                      }
                    }),
                SizedBox(height: 20),
                AccountCheck(
                  login: false,
                  onpress: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Login();
                        },
                      ),
                    );
                  },
                ),
              ])
            ],
          ),
        ),
      ),
    ));
  }
}
