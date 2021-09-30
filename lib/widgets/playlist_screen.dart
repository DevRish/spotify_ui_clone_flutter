import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/data/data.dart';
import 'package:flutter_spotify_ui/widgets/playlist_header.dart';
import 'package:flutter_spotify_ui/widgets/side_menu.dart';
import 'package:flutter_spotify_ui/widgets/tracks_list.dart';

class PlaylistScreen extends StatefulWidget {
  final Playlist playlist;
  const PlaylistScreen({ 
    Key? key, 
    required this.playlist 
  }) : super(key: key);

  @override
  _PlaylistScreenState createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  ScrollController? _scrollController;
  var scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: (Platform.isAndroid) ? false : true,
      drawer: (MediaQuery.of(context).size.width <= 800) ? drawer() : SizedBox(height: 0.0, width: 0.0),
      key: scaffoldKey,
      appBar: AppBar(
        backgroundColor: (Platform.isAndroid) ? const Color(0xFFAF1018) : Colors.transparent,
        elevation: 0,
        leadingWidth: (Platform.isAndroid) ? double.infinity : (MediaQuery.of(context).size.width > 800) ? 140.0 : 200.0,
        leading: Padding(
          padding: EdgeInsets.symmetric(horizontal: (Platform.isAndroid) ? 20.0 : 16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if(MediaQuery.of(context).size.width <= 800)
                InkWell(
                  customBorder: const CircleBorder(),
                  onTap: () => scaffoldKey.currentState?.openDrawer(),
                  child: Container(
                    padding: const EdgeInsets.all(6.0),
                    decoration: const BoxDecoration(
                      color: Colors.black26,
                      shape: BoxShape.circle
                    ),
                    child: const Icon(Icons.menu_rounded, size: 28.0,),
                  ),
                ),
              if(MediaQuery.of(context).size.width <= 800) SizedBox(width: (Platform.isAndroid) ? 8.0 : 16.0),
              if(!Platform.isAndroid) roundButton('left'),
              SizedBox(width: (Platform.isAndroid) ? 8.0 : 16.0),
              if(!Platform.isAndroid) roundButton('right'),
            ],
          ),
        ),
        actions: [
          TextButton.icon(
            style: TextButton.styleFrom(primary: Theme.of(context).iconTheme.color),
            onPressed: () {}, 
            icon: const Icon(Icons.account_circle_outlined, size: 30.0,), 
            label: const Text('Rishav')
          ),
          const SizedBox(width: 8.0),
          IconButton(
            onPressed: () {}, 
            icon: const Icon(Icons.keyboard_arrow_down, size: 30.0),
            padding: const EdgeInsets.only(),
          ),
          const SizedBox(width: 20.0),
        ],
      ),
      body: Container(
        width: double.infinity,
        decoration: BoxDecoration(gradient: LinearGradient(
          begin: Alignment.topCenter, 
          end: Alignment.bottomCenter,
          colors: [
            const Color(0xFFAF1018),
            Theme.of(context).backgroundColor
          ],
          stops: const [0, 0.3]
          )
        ),
        child: Scrollbar(
          isAlwaysShown: true,
          controller: _scrollController,
          child: ListView(
            controller: _scrollController,
            padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: (Platform.isAndroid) ? 10.0 : 60.0),
            children: [
              PlaylistHeader(playlist: widget.playlist),
              Trackslist(tracks: widget.playlist.songs)
            ],
          ),
        ),
      ),
    );
  }
}

// Drawer for small screen size and android
Widget drawer() {
  return Drawer(
    child: SideMenu(),
  );
}

// Round Buttons of AppBar
Widget roundButton(String b) {
  return InkWell(
    customBorder: const CircleBorder(),
    onTap: () {},
    child: Container(
      padding: const EdgeInsets.all(6.0),
      decoration: const BoxDecoration(
        color: Colors.black26,
        shape: BoxShape.circle
      ),
      child: Icon(
        (b=='left') ? Icons.chevron_left : Icons.chevron_right, 
        size: 28.0,
      ),
    ),
  );
}