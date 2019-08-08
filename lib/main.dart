import 'package:flutter/material.dart';
import 'fetchLogin.dart';
import 'searchTransaction.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
  String textHindPass = "Mật khẩu";
  static bool isHidden = false;

  //kiem tra trang thai dang nhap
  bool check = true;

  //kiem tra trang thai click button dang nhap
  bool checkStatus = false;

  //ham loading dang nhap
  Widget loadingLogin(bool check) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: check == false
              ? Text("")
              : SpinKitCircle(
                  color: Colors.white,
                  size: 35,
                ),
          flex: 0,
        ),
        Expanded(
          child: check == false
              ? Text(
                  "ĐĂNG NHẬP",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                )
              : Text(
                  "ĐANG ĐĂNG NHẬP",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
          flex: 0,
        ),
      ],
    );
  }

  //man hinh login
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      reverse: false,
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          //background
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.png"),
              fit: BoxFit.fill,
            ),
          ),
          child: Container(
            padding: EdgeInsets.fromLTRB(50, 0, 50, 0),
            decoration: BoxDecoration(color: Color.fromRGBO(28, 66, 82, 0.9)),
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  reverse: true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      SizedBox.fromSize(
                        size: Size.fromHeight(70),
                      ),
                      //logo
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
                          //text field username
                          TextFormField(
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: Colors.white,
                              ),
                              prefixStyle: TextStyle(backgroundColor: Colors.white),
                              suffix: SizedBox.fromSize(
                                size: Size(70, 20),
                              ),
                              hintText: "Tên đăng nhập",
                              hintStyle: TextStyle(
                                color: Colors.white,
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _editTextUsername,
                          ),
                          SizedBox.fromSize(
                            size: Size.fromHeight(10),
                          ),
                          //text field password
                          TextFormField(
                            style: TextStyle(color: Colors.white, fontSize: 18),
                            textAlign: TextAlign.center,
                            decoration: InputDecoration(
                              prefixIcon: Icon(
                                Icons.https,
                                color: Colors.white,
                              ),
                              hintText: textHindPass,
                              hintStyle: TextStyle(color: Colors.white),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              suffix: Container(
                                width: 70,
                                height: 20,
                                child: textHindPass == textHindPass
                                    ? Row(
                                        children: <Widget>[
                                          Expanded(
                                              child: IconButton(
                                                  icon: Icon(
                                                    Icons.clear,
                                                    color: Colors.white,
                                                  ),
                                                  onPressed: () {
                                                    _editTextPassword.clear();
                                                  })),
                                          Expanded(
                                              child: IconButton(
                                                  icon: isHidden
                                                      ? Icon(Icons.visibility_off)
                                                      : Icon(Icons.visibility),
                                                  color: Colors.white,
                                                  onPressed: () {
                                                    setState(() {
                                                      isHidden = !isHidden;
                                                    });
                                                  }))
                                        ],
                                      )
//
                                    : null,
                              ),
                            ),
                            keyboardType: TextInputType.text,
                            controller: _editTextPassword,
                            obscureText: isHidden,
                          ),
                          SizedBox.fromSize(
                            size: Size.fromHeight(10),
                          ),
                          //button dang nhap
                          MaterialButton(
                              height: 50,
                              child: loadingLogin(checkStatus),
                              textColor: Colors.white,
                              color: Colors.blue,
                              onPressed: () => {
                                    setState(() {
                                      if (checkStatus)
                                        checkStatus = false;
                                      else
                                        checkStatus = true;

                                      createLogin(new LoginModel(
                                              username: "TU_NPW0101_CHIEF2",
                                              password: "Bietlamgi@1",
                                              prefix: "95",
                                              appCode: "mbccs"))
                                          .then((status) {
                                        if (status != null) {
                                          check = true;
                                          checkStatus = false;
                                          String sessionId, token, username;

                                          sessionId = status[1].toString();
                                          token = status[2].toString();
                                          username = status[3].toString();

                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      SearchTransaction(sessionId,
                                                          token, username)));
                                        } else {
                                          check = false;
                                          checkStatus = false;
                                          setState(() {});
                                        }
                                      });
                                    }),
                                  })
                        ],
                      )),
                      //thong bao sai thong tin dang nhap
                      SizedBox.fromSize(
                        size: Size(MediaQuery.of(context).size.width, 70),
                        child: Container(
                            width: MediaQuery.of(context).size.width,
                            color: Color.fromRGBO(
                                253, 245, 230, check == false ? 0.8 : 0),
                            margin: EdgeInsets.fromLTRB(5, 10, 5, 10),
                            child: check == true
                                ? Text("")
                                : Container(
                                    child: Text(
                                      "Tên đăng nhập hoặc mật khẩu không đúng!",
                                      style: TextStyle(
                                          color: Colors.red, fontSize: 20),
                                      textAlign: TextAlign.center,
                                    ),
                                  )),
                      ),
                      Text(
                        "Quên mật khẩu?",
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                SizedBox.fromSize(
                  size: Size.fromHeight(70),
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
          )),
    ));
  }
}
