import 'package:flutter/material.dart';
import 'package:mysql1/mysql1.dart';


class SignIn extends StatelessWidget {
  const SignIn({Key? key});


  Future<bool> validateLogin(String email, String password) async{
    String DB_IP = "192.168.0.26";
    int DB_PORT =3306;
    String DB_NAME ="eVoznikDB";
    String DB_USERNAME = "admin";
    String DB_PASS = "adminadmin123!";

    final settings = ConnectionSettings(
      host: DB_IP,
      port: DB_PORT,
      user: DB_USERNAME,
      password: DB_PASS,
      db: DB_NAME,
      timeout: const Duration(seconds: 5),
    );
    if (email.isEmpty) {
      return false;
    }
    if (password.isEmpty || password.length < 6) {
      return false;
    }
    print("DB CONNECTION TEST");
    try{
      final conn = await MySqlConnection.connect(settings);
      final results = await conn.query('SELECT * FROM users');
      for (var row in results) {
        print(row.fields); // Access row data
      }
      await conn.close();
    }catch(e){
      print(e.toString());
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green[200], // Set the desired background color here
        child: Padding(
          padding: const EdgeInsets.all(60.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Email',
                ),
              ),
              const SizedBox(height: 16.0),
              const TextField(
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                obscureText: true,
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  bool validate = await validateLogin("email", "password") ;
                  if(validate){
                    Navigator.pushNamedAndRemoveUntil(context, '/loadingScreen', (route) => false);
                  }
                  // Handle sign in
                },
                child: const Text('Sign In'),
              ),
            ],
          ),
        ),
      ),
        resizeToAvoidBottomInset: false
    );
  }
}
