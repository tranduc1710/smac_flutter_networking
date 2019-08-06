import 'package:flutter/material.dart';
import 'fetchLogin.dart';

class SearchTransaction extends StatefulWidget {
  String sessionId, token, username;
  SearchTransaction(this.sessionId, this.token, this.username);

  @override
  State createState() => new SearchTransactionState();
}

class SearchTransactionState extends State<SearchTransaction> {
  List<DataTransactionModel> listTransaction = [];

  //ham init
  @override
  void initState() {
    getListDataTransaction(widget.sessionId, widget.token, widget.username).then(
        (data) {
          if(data != null) {
            listTransaction = data;
          }
        }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tìm kiếm giao dịch"),
        centerTitle: true,
        leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: (){
              Navigator.pop(context);
            }
        ),
      ),
      body: Stack(
        children: <Widget>[
          Container(
            height: 50,
            color: Color.fromRGBO(7, 97, 141, 1),
            child: Row(
              children: <Widget>[
                Expanded(
                    child: IconButton(
                        icon: Icon(Icons.search, color: Colors.white,),
                        onPressed: (){}
                    ),
                    flex: 1,
                ),
                Expanded(
                    child: Text("VTV3 • Mobile • Khuyến mãi 20/10", style: TextStyle(color: Colors.white, fontSize: 18),),
                    flex: 5,
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: ListView(
              children: listTransaction.map(
                      (data){
                    print(data.stockModelCode);
                    Text(data.stockModelName, style: TextStyle(color: Colors.black),);
                  }
              ).toList(),
            ),
          ),
        ],
      ),
    );
  }
}