import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'fetchLogin.dart';

class SearchTransaction extends StatefulWidget {
  String sessionId, token, username;

  SearchTransaction(this.sessionId, this.token, this.username);

  @override
  State createState() => new SearchTransactionState();
}

class SearchTransactionState extends State<SearchTransaction> {
  List<DataTransactionModel> listTransaction = [];
  TextEditingController number = new TextEditingController();
  TextEditingController textSearch = new TextEditingController();
  List<int> numberIndex = [];
  PanelController _pc = new PanelController();

  //ham init
  @override
  void initState() {
    //get list san pham tu server
//    getListDataTransaction(widget.sessionId, widget.token, widget.username)
//        .then((data) => {
//              listTransaction = data,
//            })
//        .whenComplete(() {
//      setState(() {});
//    });

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
            onPressed: () {
              Navigator.pop(context);
            }),
      ),
      body: Stack(
        children: <Widget>[
          SlidingUpPanel(
            controller: _pc,
            slideDirection: SlideDirection.DOWN,
            backdropEnabled: true,
            minHeight: 50,
            maxHeight: 200,
            panel: Container(
              color: Color.fromRGBO(7, 97, 141, 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  TextField(
                    controller: textSearch,
                    textAlign: TextAlign.center,
                    decoration:
                        InputDecoration(hintText: "Nhập giá trị tìm kiếm", hintStyle: TextStyle(color: Colors.white)),
                    style: TextStyle(color: Colors.white),
                  ),
                  MaterialButton(
                    color: Colors.lightBlueAccent,
                    child: Text("Search", style: TextStyle(color: Colors.white),),
                    onPressed: () => {
                      textSearch.clear(),
                      _pc.close()
                    },
                  )
                ],
              ),
            ),
            collapsed: Container(
              child: Center(
                child: Container(
                  height: 50,
                  color: Color.fromRGBO(7, 97, 141, 1),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: Colors.white,
                                ),
                                onPressed: () {
                                  getListDataTransaction(widget.sessionId,
                                          widget.token, widget.username)
                                      .then((data) => {
                                            listTransaction = data,
                                          })
                                      .whenComplete(() {
                                    setState(() {});
                                  });
                                }),
                            flex: 1,
                          ),
                          Expanded(
                            child: Text(
                              "VTV3 • Mobile • Khuyến mãi 20/10",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18),
                            ),
                            flex: 5,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: Stack(children: <Widget>[
              Container(
                color: Color.fromRGBO(237, 237, 237, 0.8),
                margin: EdgeInsets.fromLTRB(0, 50, 0, 0),
                height: 40,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(20, 8, 0, 0),
                child: Text(
                  "Danh sách mặt hàng trong kho",
                  style: TextStyle(fontSize: 19),
                ),
              ),
              Container(
                color: Color.fromRGBO(237, 237, 237, 0.8),
                margin: EdgeInsets.fromLTRB(0, 90, 0, 60),
                child: ListView.builder(
                  itemCount: listTransaction.length,
                  itemBuilder: (context, index) {
                    DataTransactionModel data = listTransaction[index];
                    numberIndex.add(0);

                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 100,
                        child: Card(
                          margin: EdgeInsets.fromLTRB(10, 0, 10, 3),
                          child: Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Container(
                                  height: MediaQuery.of(context).size.height,
                                  width: MediaQuery.of(context).size.width,
                                  decoration: BoxDecoration(
                                      border: Border(
                                          right: BorderSide(
                                              color: Colors.grey, width: 1))),
                                  child: Padding(
                                    padding: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    child:
                                        Image.asset("assets/images/iphone.jpg"),
                                  ),
                                ),
                              ),
                              Expanded(
                                  flex: 3,
                                  child: Container(
                                    height: MediaQuery.of(context).size.height,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        border: Border(
                                            right: BorderSide(
                                                color: Colors.grey, width: 1))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: <Widget>[
                                          Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(data.stockModelName),
                                                Text(
                                                  data.price.toString() + " đ",
                                                  style: TextStyle(
                                                      color: Colors.red),
                                                ),
                                                Center(
                                                    child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceAround,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: IconButton(
                                                          icon: Icon(
                                                              Icons.remove),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (numberIndex[
                                                                      index] >
                                                                  0)
                                                                numberIndex[
                                                                        index] =
                                                                    numberIndex[
                                                                            index] -
                                                                        1;
                                                            });
                                                          }),
                                                    ),
                                                    Expanded(
                                                      child: Container(
                                                        height: 45,
                                                        width: 10,
                                                        child: TextField(
                                                          keyboardType:
                                                              TextInputType
                                                                  .number,
                                                          textAlign:
                                                              TextAlign.center,
                                                          decoration:
                                                              InputDecoration(
                                                            border:
                                                                OutlineInputBorder(),
                                                          ),
                                                          controller: TextEditingController.fromValue(
                                                              new TextEditingValue(
                                                                  text: numberIndex[
                                                                          index]
                                                                      .toString())),
                                                        ),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: IconButton(
                                                          icon: Icon(Icons.add),
                                                          onPressed: () {
                                                            setState(() {
                                                              if (numberIndex[
                                                                      index] <
                                                                  data.quantity)
                                                                numberIndex[
                                                                        index] =
                                                                    numberIndex[
                                                                            index] +
                                                                        1;
                                                            });
                                                          }),
                                                    ),
                                                  ],
                                                ))
                                              ]),
                                        ],
                                      ),
                                    ),
                                  )),
                              Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text("Kho còn\n" +
                                          data.quantity.toString() +
                                          "sản phẩm"),
                                      RichText(
                                          text: TextSpan(children: [
                                        TextSpan(
                                            text: "Chọn serial",
                                            style: TextStyle(
                                                color: Colors.lightBlue,
                                                decoration:
                                                    TextDecoration.underline))
                                      ]))
                                    ],
                                  )),
                            ],
                          ),
                        ));
                  },
                ),
              ),
              Container(
                color: Color.fromRGBO(237, 237, 237, 0.8),
                height: 70,
                margin: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.height - 150.toInt(), 0, 0),
                padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        color: Colors.white,
                        child: Text("ĐÓNG"),
                        padding: EdgeInsets.all(15),
                        onPressed: () {},
                      ),
                    ),
                    SizedBox.fromSize(
                      size: Size(10, 0),
                    ),
                    Expanded(
                      flex: 1,
                      child: MaterialButton(
                        child: Text(
                          "TIẾP TỤC",
                          style: TextStyle(color: Colors.white),
                        ),
                        color: Color.fromRGBO(0, 131, 194, 0.9),
                        padding: EdgeInsets.all(15),
                        onPressed: () {},
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
