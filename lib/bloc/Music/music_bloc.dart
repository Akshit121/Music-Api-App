import 'package:bloc/bloc.dart';

import 'package:task1app/bloc/Music/music_event.dart';
import 'package:task1app/bloc/Music/music_state.dart';
import 'package:task1app/data/Model/MusicApi.dart';
import 'package:task1app/data/repository/music_repository.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState> {
  MusicRepository repository;

  MusicBloc({required this.repository}) : super(MusicInitialState());

  @override
  MusicState get initialState => MusicInitialState();

  @override
  Stream<MusicState> mapEventToState(MusicEvent event) async* {
    if (event is FetchMusicEvent) {
      yield MusicLoadingState();
      try {
        Music music = await repository.getMusic();
        yield MusicLoadedState(music: music);
      } catch (e) {
        yield MusicErrorState(message: e.toString());
      }
    }
  }
}
