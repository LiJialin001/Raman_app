
class ResultModel {
  String name;
  String result;
  int bacteriaNum;
  List<String> bacteriaList;
  int importance;
  List<int> ramanPic;
  String detail;

  ResultModel({
    required this.name,
    required this.result,
    required this.bacteriaList,
    required this.ramanPic,
    this.bacteriaNum = 0,
    this.importance = 0,
    this.detail = '',
  });

}