import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'coin_data.dart';
import 'list_screen.dart';

class PassWordPage extends StatefulWidget {
  @override
  _PassWordPageState createState() => _PassWordPageState();
}

class _PassWordPageState extends State<PassWordPage> {
  String selectedCurrency = 'USD';
  // добступ к тексту строки
  TextEditingController textEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar (
        title: Text('Введите пароль'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: 'logo',
            child: Container(
              height: 200.0,
              child: Image.asset('images/logo.png'),
            ),
          ),
          SizedBox(
            height: 48.0,
          ),
          SizedBox(
            height: 48.0,
            child: Text(
              '$selectedCurrency',
              style: TextStyle(
                  fontSize: 27,
                  color: Colors.blueGrey),

            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Padding(
            padding: const EdgeInsets.all(32.0),

            child:

            TextField(
              controller: textEditingController,
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
              ),
              decoration: InputDecoration(
                // icon: new Icon(Icons.message),
                labelText: '$selectedCurrency',
                enabledBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20.0)),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  borderSide: BorderSide(color: Colors.black54),
                ),
              ),
            ),

          ),
          ElevatedButton(
            // shape: RoundedRectangleBorder(
            //     borderRadius: BorderRadius. circular(11.0),
            //     side: BorderSide(color: Colors.black )
            // ),
            //
            // color: Colors.black54,
            //
              child: Text(
                'Открыть список',
                style: TextStyle(
                    fontSize: 27,
                color: Colors.deepPurple),

              ),

              onPressed: () {
                //_sendDatatoScreen(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ListScreen(text: selectedCurrency,),

                  ),
                );
              },
    ),
          SizedBox(
            height: 48.0,
          ),

          Container(
            height: 150.0,
            alignment: Alignment.center,
            padding: EdgeInsets.only(bottom: 30.0),
            color: Colors.lightBlue,
            //child: Platform.isIOS ? iOSPicker() : androidDropdown(),
            child: iOSPicker(),
          ),

       ],

      ),
    );
  }

  CupertinoPicker iOSPicker() {
    List<Text> pickerItems = [];
    for (String currency in currenciesList) {
      pickerItems.add(Text(currency));
    }

    return CupertinoPicker(
      backgroundColor: Colors.lightBlue,
      itemExtent: 32.0,
      onSelectedItemChanged: (selectedIndex) {
        setState(() {
          selectedCurrency = currenciesList[selectedIndex];
          print('$selectedCurrency');
          //getData(coin: cryptoList, currency: selectedCurrency);
        });
        print(selectedIndex);
      },
      children: pickerItems,
    );
  }

  // void _sendDatatoScreen (BuildContext context){
  //   String textToSend = textEditingController.text;
  //   Navigator.push(
  //       context,
  //       MaterialPageRoute(
  //           builder: (context) => ListScreen(text: textToSend,),
  //
  //       ),
  //   );
  // }


}
