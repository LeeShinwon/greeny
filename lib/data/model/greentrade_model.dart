
class GreenTrade{
  String writerId;
  String title;
  String content;
  bool isGreen;
  String registrationTime;
  String manufacturingDate;
  String expiryDate;
  String location;
  List<dynamic> picture;
  List<dynamic> like;
  List<dynamic> report;
  String id;

  GreenTrade(this.writerId, this.title, this.content, this.isGreen, this.registrationTime, this.manufacturingDate, this.expiryDate, this.location,this.picture, this.like, this.report, this.id);


}

class Comment{
  String uid;
  String content;
  String commentTime;

  Comment(this.uid, this.content, this.commentTime);
}
