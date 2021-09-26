import 'package:bloc/bloc.dart';

import 'package:task1app/bloc/Music/music_event.dart';
import 'package:task1app/bloc/Music/music_state.dart';
import 'package:task1app/data/Model/LyricsApi.dart';

import 'package:task1app/data/Model/trackapi.dart';
import 'package:task1app/data/repository/music_repository.dart';

class DetailBloc extends Bloc<MusicEvent, MusicState> {
  MusicRepository repository;
  String id;

  DetailBloc({required this.repository, required this.id})
      : super(MusicInitialState());

  @override
  MusicState get initialState => MusicInitialState();

  @override
  Stream<MusicState> mapEventToState(MusicEvent event) async* {
    // if (event is FetchMusicEvent) {
    //   yield MusicLoadingState();
    //   try {
    //     TrackApifile trackApifile = await repository.getTrack(id);
    //     yield TrackLoadedState(trackApifile: trackApifile);
    //   } catch (e) {
    //     yield MusicErrorState(message: e.toString());
    //   }
    // }
    if (event is FetchMusicEvent) {
      yield MusicLoadingState();
      try {
        TrackApifile trackApifile = await repository.getTrack(id);
        LyricsApi lyricsApi = await repository.getlyrics(id);
        yield LyricsLoadedState(
            lyricsApi: lyricsApi, trackApifile: trackApifile);
      } catch (e) {
        yield MusicErrorState(message: e.toString());
      }
    }
  }
}
