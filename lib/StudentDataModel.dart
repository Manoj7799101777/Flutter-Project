class StudentDataModel {
  String? name;
  int? id;
  String? atype;

  StudentDataModel({
    this.name,
    this.id,
    this.atype,
  });

  StudentDataModel.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    id = json['id'];
    atype = json['atype'];
  }
}
