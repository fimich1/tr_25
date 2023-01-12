// класс для списка с таблицы
class Athlets {
  String name;
  String unit;
  String id;
  Athlets(this.name, this.unit, this.id);

  factory Athlets.fromJson(dynamic json) {
    return Athlets("${json['name']}", "${json['unit']}", "${json['id']}");
  }
  Map toJson() => {
        'name': name,
        'unit': unit,
        'id': id,
      };
}

// класс для отправляемого списка писутствующих (сделать в одном калассе?)
class Today {
  String name;
  String tr_id;
  Today(this.name, this.tr_id);

  Map toJson() => {
        'name': name,
        'tr_id': tr_id,
      };
}
