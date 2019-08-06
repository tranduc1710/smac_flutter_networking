import 'package:flutter/material.dart';
import 'fetchLogin.dart';
import 'searchTransaction.dart';

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
  String textHindPass = "Mật khẩu";
  static bool isHidden = false;
  //kiem tra trang thai dang nhap
  bool check = true;
  //kiem tra trang thai click button dang nhap
  bool checkStatus = false;

  //ham loading dang nhap
  Widget loadingLogin(bool check){
    return Expanded(
      child: check == false ? Text("") : CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
      flex: 0,
    );
  }

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
                                    )
                                ),
                                keyboardType: TextInputType.text,
                                controller: _editTextPassword,
                                obscureText: isHidden,
                              ),
                              SizedBox.fromSize(
                                size: Size.fromHeight(10),
                              ),
                              MaterialButton(
//                                  padding: EdgeInsets.all(15),
                                  height: 50,
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Expanded(
                                        child: checkStatus == false ? Text("") : CircularProgressIndicator(
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                        flex: 0,
                                      ),
                                      Expanded(
                                          child: Text(
                                          "ĐĂNG NHẬP",
                                          style: TextStyle(
                                              fontSize: 20, fontWeight: FontWeight.bold),
                                        ),
                                          flex: 0,
                                      ),
                                    ],
//
                                  ),
                                  textColor: Colors.white,
                                  color: Colors.blue,
                                  onPressed: () => {
                                    setState((){
                                      if(checkStatus) checkStatus = false;
                                      else checkStatus = true;

//                                      Navigator.push(context, MaterialPageRoute(builder: (context) =>
//                                          SearchTransaction("eeece5ff-a3cc-43f8-8c0d-a907f6a80c90", "Msfrp+kNqYJKDiVwrFBNcA==", "TU_NPW0101_CHIEF")));

                                      createLogin(new LoginModel(
                                          username: "TU_NPW0101_CHIEF",
                                          password: "Bietlamgi@1",
                                          prefix: "95",
                                          appCode: "mbccs")).then((status){
                                            if(status != null){
                                              checkStatus = false;
                                              String sessionId ,token, username;

                                              sessionId = status[1].toString();
                                              token = status[2].toString();
                                              username = status[3].toString();

                                              Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                                  SearchTransaction(sessionId, token, username)));
                                            }else{
                                              check = false;
                                              checkStatus = false;
                                              print(checkStatus);
                                              loadingLogin(checkStatus);
                                            }
                                          }
                                      );
                                    }),
                                  }
                              )
                            ],
                          )),
                          SizedBox.fromSize(
                            size: Size(MediaQuery.of(context).size.width, 70),
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              color: Color.fromRGBO(253, 245, 230, check == false ? 0.8 : 0),
                              child: check == true ? Text("") :
                                  Align(
                                    alignment: Alignment(-1, 0),
                                    child: Text("Tên đăng nhập hoặc mật khẩu không đúng!", style: TextStyle(color: Colors.red,
                                        fontSize: 20),
                                    ),
                                  )
                            ),
                          ),
                          Text(
                            "Quên mật khẩu?",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                          SizedBox.fromSize(
                            size: Size.fromHeight(100),
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
                                  color: Colors.white)
                          )
                  ],
                ),
              ),
            )
        )
    );
  }
}
