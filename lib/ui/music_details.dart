import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:task1app/Provider/connectivity.dart';
import 'package:task1app/bloc/Music/detail_block.dart';
import 'package:task1app/bloc/Music/music_event.dart';
import 'package:task1app/bloc/Music/music_state.dart';
import 'package:task1app/data/Model/LyricsApi.dart';

import 'package:task1app/data/Model/trackapi.dart';
import 'package:task1app/ui/data_connectiviy_service.dart';

class MusicDetail extends StatefulWidget {
  final String id;
  MusicDetail({Key? key, required this.id}) : super(key: key);

  @override
  _MusicDetailState createState() => _MusicDetailState();
}

class _MusicDetailState extends State<MusicDetail> {
  DetailBloc? detail;
  @override
  void initState() {
    detail = BlocProvider.of<DetailBloc>(context);
    detail!.add(FetchMusicEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          title: const Center(
            child: Text(
              'Track Details',
              style: TextStyle(color: Colors.black),
            ),
          ),
          elevation: 3,
          backgroundColor: Colors.white,
        ),
        body: Consumer<ConnectivityProvider>(
            builder: (consumerContext, model, child) {
          if (model.isOnline != null) {
            return model.isOnline
                ? Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: BlocBuilder<DetailBloc, MusicState>(
                      builder: (context, state) {
                        if (state is MusicInitialState) {
                          return buildLoading();
                        } else if (state is MusicLoadingState) {
                          return buildLoading();
                        } else if (state is LyricsLoadedState) {
                          return buildLyricsList(
                              state.lyricsApi, state.trackApifile);
                        } else if (state is MusicErrorState) {
                          return buildErrorUi(state.toString());
                        }
                        return buildLoading();
                      },
                    ),
                  )
                : const NoInternet();
          }
          return buildLoading();
        }));
  }

  Widget buildLoading() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildLyricsList(LyricsApi lyricsApi, TrackApifile trackApifile) {
    return ListView(
      children: [
        const Text(
          'Name',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          trackApifile.message.body.track.trackName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Artist',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          trackApifile.message.body.track.artistName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Album Name',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          trackApifile.message.body.track.albumName,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Explict',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          trackApifile.message.body.track.explicit.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        const Text(
          'Rating',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          trackApifile.message.body.track.trackRating.toString(),
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          alignment: Alignment.topLeft,
          child: const Text(
            'Lyrics',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(
          lyricsApi.data.body.lyrics.lyricsBody,
          textAlign: TextAlign.left,
          style: const TextStyle(fontSize: 16, letterSpacing: 1.0, height: 1.4),
        )
      ],
    );
  }
}
