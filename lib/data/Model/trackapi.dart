import 'package:task1app/data/Model/MusicApi.dart';

class TrackApifile {
  TrackApifile({
    required this.message,
  });
  late final Message message;

  TrackApifile.fromJson(Map<String, dynamic> json) {
    message = Message.fromJson(json['message']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['message'] = message.toJson();
    return _data;
  }
}

class Message {
  Message({
    required this.header,
    required this.body,
  });
  late final Header header;
  late final Body body;

  Message.fromJson(Map<String, dynamic> json) {
    header = Header.fromJson(json['header']);
    body = Body.fromJson(json['body']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['header'] = header.toJson();
    _data['body'] = body.toJson();
    return _data;
  }
}

class Header {
  Header({
    required this.statusCode,
    required this.executeTime,
  });
  late final int statusCode;
  late final double executeTime;

  Header.fromJson(Map<String, dynamic> json) {
    statusCode = json['status_code'];
    executeTime = json['execute_time'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status_code'] = statusCode;
    _data['execute_time'] = executeTime;
    return _data;
  }
}

class Body {
  Body({
    required this.track,
  });
  late final Track track;

  Body.fromJson(Map<String, dynamic> json) {
    track = Track.fromJson(json['track']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['track'] = track.toJson();
    return _data;
  }
}
