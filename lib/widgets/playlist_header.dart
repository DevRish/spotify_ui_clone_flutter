import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/data/data.dart';

class PlaylistHeader extends StatelessWidget {
  final Playlist playlist;

  const PlaylistHeader({
    Key? key, 
    required this.playlist
  }) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (Platform.isAndroid) ? headAndr(playlist: playlist) : headDesktop(playlist: playlist),
        const SizedBox(height: 20.0),
        _PlaylistButtons(followers: playlist.followers)
      ],
    );
  }
}

// For desktop
class headDesktop extends StatelessWidget {
  final Playlist playlist;
  const headDesktop({
    Key? key, 
    required this.playlist
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            lofigirlImg(playlist.imageURL),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'PLAYLIST', 
                    style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0)
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    playlist.name, 
                    style: Theme.of(context).textTheme.headline2
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    playlist.description, 
                    style: Theme.of(context).textTheme.subtitle1
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Created by ${playlist.creator} • ${playlist.songs.length} songs, ${playlist.duration} ', 
                    style: Theme.of(context).textTheme.subtitle1
                  ),
                ],
              )
            )
          ],
        );
  }
}

// For android
class headAndr extends StatelessWidget {
  final Playlist playlist;
  const headAndr({
    Key? key, 
    required this.playlist
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: lofigirlImg(playlist.imageURL)),
                  const SizedBox(height: 12.0),
                  Text(
                    'PLAYLIST', 
                    style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0)
                  ),
                  const SizedBox(height: 12.0),
                  Text(
                    playlist.name, 
                    style: Theme.of(context).textTheme.headline2
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    playlist.description, 
                    style: Theme.of(context).textTheme.subtitle1
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    'Created by ${playlist.creator} • ${playlist.songs.length} songs, ${playlist.duration} ', 
                    style: Theme.of(context).textTheme.subtitle1
                  ),
                ],
              )
            )
          ],
        );
  }
}

// Lofigirl Image
Widget lofigirlImg(String url)
{
  return Image.asset(
    url,
    height: 200.0,
    width: 200.0,
    fit: BoxFit.cover,
  );
}

// PLAY, Favourites icon etc, that row
class _PlaylistButtons extends StatelessWidget {
  final String followers;
  const _PlaylistButtons({ 
    Key? key,
    required this.followers
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TextButton(
          style: TextButton.styleFrom(
            padding: EdgeInsets.symmetric(
              horizontal: (Platform.isAndroid) ? 32.0 : 48.0, 
              vertical: (Platform.isAndroid) ? 14.0 : 20.0
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
            backgroundColor: const Color(0xFF1DB954),
            primary: Theme.of(context).iconTheme.color,
            textStyle: Theme.of(context).textTheme.caption!.copyWith(fontSize: 12.0, letterSpacing: 2.0)
          ),
          onPressed: () {},
          child: const Text('PLAY'),
        ),
        const SizedBox(width: 8.0),
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.favorite_border),
          iconSize: (Platform.isAndroid) ? 25.0 : 30.0,
        ),
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.more_horiz),
          iconSize: (Platform.isAndroid) ? 25.0 : 30.0,
        ),
        const Spacer(),
        Text(
          'FOLLOWERS\n$followers', 
          style: Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0),
          textAlign: TextAlign.right,
        )
      ],
      
    );
  }
}