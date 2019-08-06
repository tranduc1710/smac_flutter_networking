import 'dart:convert';

import 'package:http/http.dart' as http;

//model login
class LoginModel {
  //khai bao thuoc tinh
  String username, password, prefix, appCode;

  LoginModel({this.username, this.password, this.prefix, this.appCode});

  factory LoginModel.fromJson(Map<String, dynamic> json) =>
      LoginModel(username: json['username'],
          password: json['sessionId'],
          prefix: json['prefix'],
          appCode: json['appCode']);
}

//model check login
class CheckStatusLogin{
  //khai bao
  String sessionId, username, token;

  CheckStatusLogin({this.sessionId, this.username, this.token});

  factory CheckStatusLogin.fromJson(Map<String, dynamic> json)
    => CheckStatusLogin(
      sessionId: json['sessionId'],
      username: json['username'],
      token: json['token']
    );
}

//model san pham
class DataTransactionModel{
  bool logistic;
  String stockModelCode, stockModelName;
  int availableQuantity, checkSerial, price, productOfferTypeId, stockModelId, quantity;

  DataTransactionModel({this.logistic, this.stockModelCode, this.stockModelName,
  this.availableQuantity, this.checkSerial, this.price,
  this.productOfferTypeId, this.stockModelId, this.quantity});

  factory DataTransactionModel.fromJson(Map<String, dynamic> json)
    => DataTransactionModel(
      logistic: json['logistic'],
      availableQuantity:  json['availableQuantity'],
      checkSerial: json['checkSerial'],
      price: json['price'],
      productOfferTypeId: json['productOfferTypeId'],
      stockModelId: json['stockModelId'],
      stockModelCode: json['stockModelCode'],
      stockModelName: json['stockModelName'],
      quantity: json['quantity']
    );
}

//model get result
class GetDataTransactionResultModel{
  var result;

  GetDataTransactionResultModel({this.result});

  factory GetDataTransactionResultModel.fromJson(Map<String, dynamic> json)
    => GetDataTransactionResultModel(
        result: json['result']
    );
}

//model get object
class GetDataTransactionObjectModel{
  var object;

  GetDataTransactionObjectModel({this.object});

  factory GetDataTransactionObjectModel.fromJson(Map<String, dynamic> json)
    => GetDataTransactionObjectModel(
        object: json['object']
    );
}

//model get san pham
class GetDataTransactionModel{
  List<DataTransactionModel> lsStockModel;

  GetDataTransactionModel({this.lsStockModel});

  factory GetDataTransactionModel.fromJson(Map<String, dynamic> json)
    => GetDataTransactionModel(
        lsStockModel: json['lsStockModel'].cast<DataTransactionModel>()
    );
}

//ham login
Future<List<String>> createLogin(LoginModel loginModel) async {
  String url = "https://vmyapigw.viettelglobal.net/CoreService/UserLogin";

  Map data = {

    "username": loginModel.username,

    "password": loginModel.password,

    "prefix": loginModel.prefix,

    "appCode": loginModel.appCode
  };

  var body = json.encode(data);

  var response = await http.post(
      url, headers: {"Content-Type": "application/json"}, body: body);

  Map<String, dynamic> data1 = json.decode(response.body);
  var dataCheck = CheckStatusLogin.fromJson(data1);

  if(response.statusCode == 200 && data1.containsKey("sessionId")){
    List<String> listData;
    listData = ["true", dataCheck.sessionId, dataCheck.token, dataCheck.username];
    return listData;
  }else{
    return null;
  }
}

//ham lay san pham
Future<List<DataTransactionModel>> getListDataTransaction(String sessionId, String token, String username) async {
  String url = "https://vmyapigw.viettelglobal.net/CoreService/UserRouting";

  Map data = {

    "sessionId": sessionId,

    "token": token,

    "username": username,

    "wsCode": "WS_GetStockTotal",

    "apiKey": "308FD5F2C770DE0356150AFD667D90FB",

    "language": "en",

    "wsRequest": {

      "isSaleForAgent": false,

      "saleTransType": "3",

      "staffCode": "TU_NPW0101_CHIEF",

      "language": "en"

    }
  };

  var body = json.encode(data);

  var response = await http.post(url, headers: {"Content-Type": "application/json"}, body: body);

  Map<String, dynamic> data1 = json.decode(response.body);

  var dataGetResult = GetDataTransactionResultModel.fromJson(data1);
  var dataGetObject = GetDataTransactionObjectModel.fromJson(dataGetResult.result);
  var dataGet = GetDataTransactionModel.fromJson(dataGetObject.object);

  List<DataTransactionModel> list = dataGet.lsStockModel;

  if(response.statusCode == 200){
    return list;
  }else{
    return null;
  }

}