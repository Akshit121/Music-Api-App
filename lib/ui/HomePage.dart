import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:task1app/Provider/connectivity.dart';
import 'package:task1app/bloc/Music/detail_block.dart';
import 'package:task1app/bloc/Music/music_bloc.dart';
import 'package:task1app/bloc/Music/music_event.dart';
import 'package:task1app/bloc/Music/music_state.dart';
import 'package:task1app/data/Model/MusicApi.dart';
import 'package:task1app/data/repository/music_repository.dart';
import 'package:task1app/ui/data_connectiviy_service.dart';
import 'music_details.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MusicBloc? musicBloc;
  @override
  void initState() {
    super.initState();
    musicBloc = BlocProvider.of<MusicBloc>(context, listen: false);
    musicBloc!.add(FetchMusicEvent());
    Provider.of<ConnectivityProvider>(context, listen: false).startMonitoring();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Center(
            child: Text(
              'Trending',
              style: TextStyle(color: Colors.black),
            ),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.refresh),
              color: Colors.black,
              onPressed: () {
                musicBloc!.add(FetchMusicEvent());
              },
            ),
          ],
          elevation: 3,
          backgroundColor: Colors.white,
        ),
        body: Consumer<ConnectivityProvider>(
            builder: (consumerContext, model, child) {
          if (model.isOnline != null) {
            return model.isOnline
                ? Padding(
                    padding: const EdgeInsets.only(left: 10, top: 6),
                    child: Container(
                      child: BlocBuilder<MusicBloc, MusicState>(
                        builder: (context, state) {
                          if (state is MusicInitialState) {
                            return buildLoading();
                          } else if (state is MusicLoadingState) {
                            return buildLoading();
                          } else if (state is MusicLoadedState) {
                            return buildMusicList(state.music);
                          } else if (state is MusicErrorState) {
                            return buildErrorUi(state.toString());
                          }
                          return Container(
                            child: Text(''),
                          );
                        },
                      ),
                    ),
                  )
                : NoInternet();
          }
          return buildLoading();
        }));
  }

  Widget buildLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget buildErrorUi(String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: TextStyle(color: Colors.red),
        ),
      ),
    );
  }

  Widget buildMusicList(Music mu) {
    return ListView(
        children: mu.message.body.trackList.map((e) {
      return Column(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BlocProvider(
                      create: (context) => DetailBloc(
                          repository: MusicRepositoryImpl(),
                          id: e.track.trackId.toString()),
                      child: MusicDetail(id: e.track.trackId.toString()),
                    ),
                  ));
            },
            child: ListTile(
              leading: const Icon(
                Icons.music_video_sharp,
                color: Colors.black54,
              ),
              title: Text(
                e.track.albumName,
                style:
                    const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              subtitle: Text(
                e.track.trackName,
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              trailing: SizedBox(
                  width: 120,
                  child: Text(
                    e.track.artistName,
                    style: const TextStyle(
                        fontSize: 14, fontWeight: FontWeight.w600),
                  )),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(4.0),
            child: Divider(
              height: 9,
              color: Colors.black,
            ),
          )
        ],
      );
    }).toList());
  }
}
