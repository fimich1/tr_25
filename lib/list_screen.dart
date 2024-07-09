import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'athlets_form.dart';
import 'web_matters.dart';
//import 'helloua_screen.dart';

class ListScreen extends StatelessWidget {
  late String text;

  ListScreen ({@required text});
 //  ListScreen ({required Key key, @required text}) : super(key: key);

  // final String treiner;
  //
  // ListScreen({this.treiner})


  @override
  Widget build(BuildContext context) {
   text = 'orient';
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Дневник тренера ПКУ, $text',
      // title: text,
      theme: ThemeData.dark(),
      // ThemeData(
      //   primaryColor: Colors.white,
    //  ),
      home: RandomWords(text: text),
    );
  }
}

class RandomWords extends StatefulWidget {
  final String text;
  RandomWords ({required this.text});
  @override
  RandomWordsState createState() => RandomWordsState(text: text);
}

class RandomWordsState extends State<RandomWords> {

  final String text;
  RandomWordsState ({required this.text});

  final _biggerFont = const TextStyle(fontSize: 18.0);
  var athlets;
  final _saved = ['кадеты'];
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final SnackBar snackBar = const SnackBar(content: Text('отправлены'));

 // final text = ListScreen.text.toString();
   // String idread = 'boxing';

  // получить список с web
  Widget _buildSuggestions() {

//    final ScreenArguments args = ModalRoute.of(context).settings.arguments;


  print ('переданный аргумент - $text');

    // NetWorking().get_List(idread).then((feedbackItems) {
    // здесь должен стоять аргумент вместо 'boxing'
    NetWorking().get_List(text).then((feedbackItems) {
      this.athlets = feedbackItems;

    setState(() {
        //this.athlets = feedbackItems;
    });
    });
    // athlets[0].name = 'Кадеты';
    // athlets[0].unit = '1';
    int z = athlets?.length ?? 0;// athlets[0].id = '1';
    print('длина списка равна = $z'); // $athlets.name.length' ? не работает );
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: athlets?.length ?? 0,
      itemBuilder: (context, i) {
        final index = i;
        // здесь формируется строка списка  id не работает
        //  if athlets[index].id = 'сборная' {}  - реализовать такой функционал
        String row = athlets[index].name + " ←имя " + athlets[index].unit + " ←unit " + athlets[index].id + " ←id ";
        return _buildRow(row);"м";
        return _buildRow(row);
      },
    );
  }

  Widget _buildRow(pair) {
    final alreadySaved = _saved.contains(pair);
    return ListTile(
      title: Text(
        pair,
        style: _biggerFont,
      ),
      trailing: Icon(
        alreadySaved ? Icons.accessibility_new : Icons.weekend_rounded,
        color: alreadySaved ? Colors.green : null,
      ),
      onTap: () {
        setState(() {
          if (alreadySaved) {
            _saved.remove(pair);
          } else {
            _saved.add(pair);
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {



    return Scaffold(
      appBar: AppBar(
        title: Text('Общий список кадет: $text'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.list),
            tooltip: 'Список присутствующих сегодня',
            onPressed: _pushSaved,
          ),
        ],
      ),
      body: _buildSuggestions(),
    );
  }

// нужно просто всплывающее окно или уведомление, можно менять
  void _showCupertinoDialog() {
    showDialog(
        context: context,
        builder: (_) => new CupertinoAlertDialog(
          title: new Text("Список присутствующих на тренировке"),
          content: new Text("отправлен"),
          actions: <Widget>[
            TextButton(
              child: Text('Принято!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        ));
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Отправлено'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Список отправлен в журнал'),
                Text('Нажмите чтобы закрыть окно'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Закрыть'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
// Открывается окно с выбранными позициями и возможностью отправить в net
  void _pushSaved() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {
          print(_saved);
          final tiles = _saved.map(
                (pair) {
              return ListTile(
                title: Text(
                  pair,
                  style: _biggerFont,
                ),
              );
            },
          );
          final divided = ListTile.divideTiles(
            context: context,
            tiles: tiles,
          ).toList();

          return Scaffold(
            //       key: scaffoldKey,
            appBar: AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.alternate_email),
                  tooltip: 'Отправить всех в облако',
                  onPressed: () {
                    submit(_saved, text);
                    // _showCupertinoDialog();
                    _showMyDialog();

                  },
                ),
              ],
              title: Text('Тренируются сегодня'),
            ),
            body: ListView(children: divided),
          );
        },
      ),
    );
  }
}

// функция циклом по длине списка отправляет
// спортсменов по одному в google sheet
// вызывает функцию  networking.submitForm из файла web matters

Future<void> submit(List saved, String text) async {
  // void submit(List saved) {    - так было до конвертации в async
  int i = saved.length; // длина списка
  // String name1;
  String id = '0'; // id - код тренера, номер листа в таблице
  // String ids='orient';
  for (int j = 1; j < i; j++) {
    print('список тренирующихся = $i');
    Today today = Today(saved[j], text);
    today.tr_id = text;
    // name1 = saved[j].name;
    // print(name1);
    NetWorking form = NetWorking();
    form.sent_to_table(
      today,
          text,

          (String response) {
        if (response == NetWorking.STATUS_SUCCESS) {
          print(
              '$j спортсмен успешно отправлен, идем за следующим'); // print("Response: $response");
        } else {
          print("Что-то не так!");
        }
      },
    );
  }
}


