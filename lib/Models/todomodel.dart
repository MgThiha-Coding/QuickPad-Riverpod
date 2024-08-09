class Todomodel{
  String title;
  String purpose;
  String date;
  Todomodel({required this.title,required this.purpose,required this.date});

  Map<String,String> toJson()=> {
     'title':title,
     'purpose':purpose,
     'date':date,
  };

  factory Todomodel.fromJson(Map<String,dynamic> json){
    return Todomodel(title: json['title'], purpose: json['purpose'],date :json['date']);
  }
}