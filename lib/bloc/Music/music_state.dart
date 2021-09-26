import 'package:equatable/equatable.dart';

import 'package:task1app/data/Model/LyricsApi.dart';
import 'package:task1app/data/Model/MusicApi.dart';
import 'package:task1app/data/Model/trackapi.dart';

abstract class MusicState extends Equatable {}

class MusicInitialState extends MusicState {
  @override
  List<Object> get props => [];
}

class MusicLoadingState extends MusicState {
  @override
  List<Object> get props => [];
}

class LyricsLoadedState extends MusicState {
  final LyricsApi lyricsApi;
  final TrackApifile trackApifile;
  LyricsLoadedState({required this.lyricsApi, required this.trackApifile});

  @override
  List<Object> get props => [lyricsApi];
  List<Object> get prop => [trackApifile];
}

class MusicLoadedState extends MusicState {
  final Music music;

  MusicLoadedState({required this.music});

  @override
  List<Object> get props => [music];
}

class MusicErrorState extends MusicState {
  final String? message;

  MusicErrorState({required this.message});

  @override
  List<Object> get props => [message!];
}
