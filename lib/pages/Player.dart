import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import '../notifiers/play_button_notifier.dart';
import '../notifiers/progress_notifier.dart';
import '../notifiers/repeat_button_notifier.dart';
import '../page_manager.dart';
import '../services/service_locator.dart';
import 'AboutApp.dart';
import 'SecondPage.dart';

class Player extends StatefulWidget {
  final color;
  final index;
  Player({
    super.key,
    this.color = Colors.brown,
    this.index = 0,
  });
  @override
  _MyAppState createState() => _MyAppState(color, index);
}

String titleH = "دعاء 1 ";

class _MyAppState extends State<Player> {
  final pageManager = getIt<PageManager>();
  final color;
  final index;
  _MyAppState(this.color, this.index);
  Future<void> share() async {
    await FlutterShare.share(
        title: 'تطبيق البر والصلة والاداب',
        text: 'مشاركة التطبيق',
        linkUrl:
            'https://play.google.com/store/apps/details?id=apps.soonfu.pro',
        chooserTitle: 'Example Chooser Title');
  }

  @override
  void dispose() {
    pageManager.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: color,
          title: CurrentSongTitle(),
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AboutApp()),
                  );
                },
                icon: Icon(
                  Icons.info,
                  color: Colors.white,
                )),
            IconButton(
                onPressed: () {
                  share();
                },
                icon: Icon(
                  Icons.share,
                  color: Colors.white,
                ))
          ],
        ),
        body: Container(
          color: color.withOpacity(0.8),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Playlist(
                  pageManager: pageManager,
                ),
                AudioProgressBar(),
                Directionality(
                    textDirection: TextDirection.ltr,
                    child: AudioControlButtons()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CurrentSongTitle extends StatelessWidget {
  const CurrentSongTitle({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<String>(
      valueListenable: pageManager.currentSongTitleNotifier,
      builder: (_, title, __) {
        titleH = title != "" ? title : titleH;
        return Text(title, style: TextStyle(fontSize: 20));
      },
    );
  }
}

class Playlist extends StatelessWidget {
  Playlist({Key? key, this.pageManager}) : super(key: key);
  PageManager? pageManager;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ValueListenableBuilder<List<String>>(
        valueListenable: pageManager!.playlistNotifier,
        builder: (context, playlistTitles, _) {
          return ListView.separated(
            separatorBuilder: (context, index) {
              return Container();
            },
            itemCount: playlistTitles.length,
            itemBuilder: (context, index) {
              return Container(
                color: titleH == playlistTitles[index] ? Colors.black26 : null,
                child: ListTile(
                  onTap: () {
                    pageManager!.playIndex(index);
                  },
                  title: Text(
                    '${playlistTitles[index]}',
                    style: TextStyle(color: Colors.white),
                  ),
                  leading: titleH == playlistTitles[index]
                      ? Icon(
                          Icons.queue_music_sharp,
                          color: Colors.white,
                        )
                      : Icon(
                          Icons.music_note,
                          color: Colors.white,
                        ),
                  subtitle: Text(
                    "البر والصلة والآداب",
                    style: TextStyle(color: Colors.white70),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AudioProgressBar extends StatelessWidget {
  const AudioProgressBar({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: pageManager.progressNotifier,
      builder: (_, value, __) {
        return ProgressBar(
          progressBarColor: Colors.white,
          thumbColor: Colors.white70,
          bufferedBarColor: Colors.white70,
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: pageManager.seek,
          timeLabelTextStyle: TextStyle(color: Colors.white),
        );
      },
    );
  }
}

class AudioControlButtons extends StatelessWidget {
  const AudioControlButtons({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          RepeatButton(),
          PreviousSongButton(),
          PlayButton(),
          NextSongButton(),
          ShuffleButton(),
        ],
      ),
    );
  }
}

class RepeatButton extends StatelessWidget {
  const RepeatButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<RepeatState>(
      valueListenable: pageManager.repeatButtonNotifier,
      builder: (context, value, child) {
        Icon icon;
        switch (value) {
          case RepeatState.off:
            icon = Icon(Icons.repeat, color: Colors.white);
            break;
          case RepeatState.repeatSong:
            icon = Icon(
              Icons.repeat_one,
              color: Colors.white,
            );
            break;
          case RepeatState.repeatPlaylist:
            icon = Icon(
              Icons.repeat,
              color: Colors.white70,
            );
            break;
        }
        return IconButton(
          icon: icon,
          onPressed: pageManager.repeat,
        );
      },
    );
  }
}

class PreviousSongButton extends StatelessWidget {
  const PreviousSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isFirstSongNotifier,
      builder: (_, isFirst, __) {
        return IconButton(
          icon: Icon(
            Icons.skip_previous,
            color: isFirst ? Colors.white70 : Colors.white,
          ),
          onPressed: (isFirst) ? null : pageManager.previous,
        );
      },
    );
  }
}

class PlayButton extends StatelessWidget {
  const PlayButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<ButtonState>(
      valueListenable: pageManager.playButtonNotifier,
      builder: (_, value, __) {
        switch (value) {
          case ButtonState.loading:
            return Container(
              margin: EdgeInsets.all(8.0),
              width: 32.0,
              height: 32.0,
              child: CircularProgressIndicator(),
            );
          case ButtonState.paused:
            return IconButton(
              icon: Icon(
                Icons.play_arrow,
                color: Colors.white,
              ),
              iconSize: 32.0,
              onPressed: pageManager.play,
            );
          case ButtonState.playing:
            return IconButton(
              icon: Icon(
                Icons.pause,
                color: Colors.white,
              ),
              iconSize: 32.0,
              onPressed: pageManager.pause,
            );
        }
      },
    );
  }
}

class NextSongButton extends StatelessWidget {
  const NextSongButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isLastSongNotifier,
      builder: (_, isLast, __) {
        return IconButton(
          icon: Icon(
            Icons.skip_next,
            color: isLast ? Colors.white70 : Colors.white,
          ),
          onPressed: (isLast) ? null : pageManager.next,
        );
      },
    );
  }
}

class ShuffleButton extends StatelessWidget {
  const ShuffleButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final pageManager = getIt<PageManager>();
    return ValueListenableBuilder<bool>(
      valueListenable: pageManager.isShuffleModeEnabledNotifier,
      builder: (context, isEnabled, child) {
        return IconButton(
          icon: (isEnabled)
              ? Icon(
                  Icons.shuffle,
                  color: Colors.white,
                )
              : Icon(Icons.shuffle, color: Colors.white70),
          onPressed: pageManager.shuffle,
        );
      },
    );
  }
}
