import 'package:flutter/material.dart';
import 'package:icon_shadow/icon_shadow.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //khai bao bien
  TextEditingController _editTextUsername = TextEditingController();
  TextEditingController _editTextPassword = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String textHindPass;
  static bool isHidden = false;

  //man hinh login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/images/background.png"),
                fit: BoxFit.fill,
              ),
            ),
            child: Container(
              padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
              decoration: BoxDecoration(color: Colors.indigo.withOpacity(0.8)),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SizedBox.fromSize(
                      size: Size.fromHeight(70),
                    ),
                    Image.asset(
                      "assets/logo/logo.png",
                      width: 200,
                      height: 150,
                    ),
                    SizedBox.fromSize(
                      size: Size.fromHeight(30),
                    ),
                    Form(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(
                            prefixIcon: Icon(
                              Icons.person_outline,
                              color: Colors.white,
                            ),
                            hintText: "Tên đăng nhập",
                            border: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(2))),
                          ),
                          keyboardType: TextInputType.text,
                          controller: _editTextUsername,
//                            textAlign: TextAlign.center,
                        ),
                        SizedBox.fromSize(
                          size: Size.fromHeight(10),
                        ),
                        TextFormField(
                          style: TextStyle(color: Colors.white, fontSize: 18),
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.https,
                                color: Colors.white,
                              ),
                              hintText: textHindPass,
                              suffixIcon: IconButton(
                                icon: textHindPass == "Mật khẩu"
                                    ? IconButton(
                                        icon: isHidden
                                            ? Icon(Icons.visibility_off)
                                            : Icon(Icons.visibility),
                                        onPressed: () {
                                          setState(() {
                                            isHidden = !isHidden;
                                          });
                                        })
                                    : null,
                              )),
                          keyboardType: TextInputType.text,
                          controller: _editTextPassword,
                          obscureText: isHidden,
//                            textAlign: TextAlign.center,
                        ),
                        SizedBox.fromSize(
                          size: Size.fromHeight(10),
                        ),
                        MaterialButton(
                            padding: EdgeInsets.all(15),
                            child: Align(
                              child: Text(
                                "ĐĂNG NHẬP",
                                style: TextStyle(
                                    fontSize: 20, fontWeight: FontWeight.bold),
                              ),
                            ),
                            textColor: Colors.white,
                            color: Colors.blue,
                            onPressed: () => {})
                      ],
                    )),
                    SizedBox.fromSize(
                      size: Size.fromHeight(40),
                    ),
                    Text(
                      "Quên mật khẩu?",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox.fromSize(
                      size: Size.fromHeight(130),
                    ),
                    Text("Tổng đài chăm sóc khách hàng",
                        style: TextStyle(fontSize: 18, color: Colors.white)),
                    SizedBox.fromSize(
                      size: Size.fromHeight(10),
                    ),
                    Text("1900 8198",
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white))
                  ],
                ),
              ),
            )
//
            ));
  }
}
