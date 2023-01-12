import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import 'athlets_form.dart';

class NetWorking {
  static const String URL =
      "https://script.google.com/macros/s/AKfycbzeuHKd5kRpKVbY0ak8klaBMZeZ6wOoDwzpehCheZhJTAKF5co/exec";

      //"https://script.google.com/macros/s/AKfycbyZdvD4qSE2BBUtZ6oMX_BXSwN8urbiHhIFkKdFGf3qpj5aKmo/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  // отправляет один элемент списка в таблицу
  void sent_to_table(Today today, String id, void Function(String) callback) async {
    try {
      await http.post(
        Uri.parse('$URL?id=$id'),
          // URL+'?id='+id,
          body: today.toJson()).then((response) async {
     //   await http.post(URL, body: today.toJson()).then((response) async {
        if (response.statusCode == 302) {
          var url = response.headers['location'];
          await http.get(Uri.parse('$URL?id=$id')).then((response) {
            callback(convert.jsonDecode(response.body)['status']);
          });
        } else {
          callback(convert.jsonDecode(response.body)['status']);
        }
      });
    } catch (e) {
      print(e);
    }
  }

  // читает из таблицы список и возвращает его в качестве list (или map?)
  Future<List<Athlets>> get_List(String id) async {
    return
      await http.get(
      //    URL+'?id='+id
          (Uri.parse('$URL?id=$id'))
      ).then((response) {
      var jsonFeedback = convert.jsonDecode(response.body) as List;
      var sp = jsonFeedback.map((json) => Athlets.fromJson(json)).toList();
      var it = sp.length;
      print("${sp[2].id}");
      print('Количество спортсменов в списке = $it');
      print(URL+'?id='+id);
      return sp;
    });
  }

  void getData() async {
    http.Response response = await http.get(Uri.parse('$URL'));
    if (response.statusCode == 200) {
      String data = response.body;
      var name = convert.jsonDecode(data)[0]['name'];
      print('data: $data');
      print('name: $name');
      var lenghth = convert.jsonDecode(data.length.toString());
      print(lenghth);

      return convert.jsonDecode(data);
    } else {
      print(response.statusCode);
    }
  }
}
