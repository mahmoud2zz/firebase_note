
import 'package:firebase_note_provider/utils/context_extention.dart';
import 'package:flutter/material.dart';

import '../../firebase/fb_auth_controller.dart';
import '../../models/process_response.dart';
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController _emailTextController;
  late TextEditingController _passwordTextController;

  String? _language;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailTextController = TextEditingController();
    _passwordTextController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailTextController.dispose();
    _passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.language)),
          SizedBox(
            width: 10,
          )
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Login',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
            Text(
              '',
              style: TextStyle(
                fontWeight: FontWeight.w300,
                fontSize: 16,
              ),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _emailTextController,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                  helperText: 'Email',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            TextField(
              controller: _passwordTextController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  helperText: 'Password',
                  border: OutlineInputBorder()),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    minimumSize: Size(double.infinity, 40),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    )),
                onPressed: () => _performLogin(),
                child: Text(
                    'Login',
                  style: TextStyle(color: Colors.white),
                )),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Don\t have account?' ),
                TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                          context, '/register_screen');
                    },
                    child: Text('Create acccount'))
              ],
            )
          ],
        ),
      ),
    );
  }

  void _performLogin() {
    if (checkData()) {
      _login();
    }
  }

  bool checkData() {
    if (_emailTextController.text.isNotEmpty &&
        _passwordTextController.text.isNotEmpty) {

      return true;
    } else {
      context.showSnackBar(message: 'Enter required data!', error: true);

      return false;
    }
  }

  void _login() async {
 ProcessResponse processResponse= await FbAuthController().signInWithEmailAndPassword(_emailTextController.text, _passwordTextController.text);
  if(processResponse.success){
    Navigator.pushReplacementNamed(context, '/home_screen');
  }
 context.showSnackBar(message: processResponse.message,error: !processResponse.success);

_clear();
  }
  _clear() {
    _emailTextController.clear();
    _passwordTextController.clear();
  }
  }

