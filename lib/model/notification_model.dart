class NotificationModel {
  String to;
  Data data;

  NotificationModel({this.to, this.data});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    to = json['to'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['to'] = this.to;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    return data;
  }
}

class Data {
  String title;
  String message;
  String body;
  String contentAvailable;
  String registrationIds;
  String priority;

  Data({this.title, this.message, this.body, this.contentAvailable, this.registrationIds, this.priority});

  Data.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    message = json['message'];
    body = json['body'];
    contentAvailable = json['content_available'];
    registrationIds = json['registration_ids'];
    priority = json['priority'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['message'] = this.message;
    data['body'] = this.body;
    data['content_available'] = this.contentAvailable;
    data['registration_ids'] = this.registrationIds;
    data['priority'] = this.priority;
    return data;
  }
}
