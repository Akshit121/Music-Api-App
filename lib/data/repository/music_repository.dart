import 'dart:convert';

import 'package:task1app/data/Model/LyricsApi.dart';
import 'package:task1app/data/Model/MusicApi.dart';
import 'package:http/http.dart' as http;
import 'package:task1app/data/Model/trackapi.dart';

abstract class MusicRepository {
  Future getMusic();
  Future getTrack(String id);
  Future getlyrics(String id);
}

class MusicRepositoryImpl implements MusicRepository {
  @override
  Future getMusic() async {
    http.Response response = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/chart.tracks.get?apikey=bff5f8af2e47878d9e298dabf6e0ddc8'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      Music music = Music.fromJson(body);

      return music;
    } else {
      throw Exception();
    }
  }

  @override
  Future getTrack(String id) async {
    http.Response response = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.get?track_id=$id&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7'));
    if (response.statusCode == 200) {
      var body = jsonDecode(response.body);
      TrackApifile trackId = TrackApifile.fromJson(body);
      return trackId;
    } else {
      throw Exception();
    }
  }

  @override
  Future getlyrics(String id) async {
    http.Response res = await http.get(Uri.parse(
        'https://api.musixmatch.com/ws/1.1/track.lyrics.get?track_id=$id&apikey=2d782bc7a52a41ba2fc1ef05b9cf40d7'));
    if (res.statusCode == 200) {
      var bo = jsonDecode(res.body);

      LyricsApi lyricsapi = LyricsApi.fromJson(bo);
      return lyricsapi;
    } else {
      throw Exception();
    }
  }
}
