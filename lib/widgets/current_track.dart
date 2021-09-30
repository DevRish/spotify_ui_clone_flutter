import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/models/current_track_model.dart';
import 'package:provider/provider.dart';

class CurrentTrack extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: (Platform.isAndroid) ? 200.0 : 84.0,
      width: double.infinity,
      color: Colors.black87,
      child: Padding(
        padding: EdgeInsets.all(12.0),
        child: (Platform.isAndroid) ? CurrTrckAndroid() : CurrTrckDesktop(),
      ),
    );
  }
}

// For Desktop
class CurrTrckDesktop extends StatelessWidget {
  const CurrTrckDesktop({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              _TrackInfo(),
              const Spacer(),
              _PlayerControls(),
              const Spacer(),
              if(MediaQuery.of(context).size.width > 800) _MoreControls()
            ],
          );
  }
}

// For Android
class CurrTrckAndroid extends StatelessWidget {
  const CurrTrckAndroid({ Key? key }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _TrackInfo(),
              const SizedBox(height: 10.0),
              _PlayerControls()
            ],
          );
  }
}

class _TrackInfo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = context.watch<CurrentTrackModel>().selected ;
    if(selected == null) return const SizedBox.shrink();
    return Row(
      mainAxisAlignment: (Platform.isAndroid) ? MainAxisAlignment.center : MainAxisAlignment.start,
      children: [
        Image.asset('assets/lofigirl.jpg', height: 60.0, width: 60.0, fit: BoxFit.cover),
        const SizedBox(width: 12.0),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(selected.title, style: Theme.of(context).textTheme.bodyText1),
            const SizedBox(height: 4.0),
            Text(selected.artist, style: Theme.of(context).textTheme.subtitle1!.copyWith(color: Colors.grey[300], fontSize: 12.0))
          ],
        ),
        const SizedBox(width: 12.0),
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.favorite_border),
        ),
      ],
    );
  }
}

class _PlayerControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final selected = context.watch<CurrentTrackModel>().selected ;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: (Platform.isAndroid) ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            IconButton(
              padding: EdgeInsets.only(),
              onPressed: () {}, 
              icon: const Icon(Icons.shuffle),
              iconSize: (Platform.isAndroid) ? 30.0: 20.0,
            ),
            IconButton(
              padding: EdgeInsets.only(),
              onPressed: () {}, 
              icon: const Icon(Icons.skip_previous_outlined),
              iconSize: (Platform.isAndroid) ? 30.0: 20.0,
            ),
            IconButton(
              padding: EdgeInsets.only(),
              onPressed: () {}, 
              icon: const Icon(Icons.play_circle_outline),
              iconSize: (Platform.isAndroid) ? 44.0: 34.0,
            ),
            IconButton(
              padding: EdgeInsets.only(),
              onPressed: () {}, 
              icon: const Icon(Icons.skip_next_outlined),
              iconSize: (Platform.isAndroid) ? 30.0: 20.0,
            ),
            IconButton(
              padding: EdgeInsets.only(),
              onPressed: () {}, 
              icon: const Icon(Icons.repeat),
              iconSize: (Platform.isAndroid) ? 30.0: 20.0,
            ),
          ],
        ),
        SizedBox(height: (Platform.isAndroid) ? 8.0: 4.0),
        Row(
          mainAxisAlignment: (Platform.isAndroid) ? MainAxisAlignment.center : MainAxisAlignment.start,
          children: [
            Text('0:00', style: Theme.of(context).textTheme.caption),
            const SizedBox(width: 8.0),
            Container(
              height: 5.0, 
              width: (Platform.isAndroid) ? MediaQuery.of(context).size.width*0.7 : MediaQuery.of(context).size.width*0.3, 
              decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(2.5)),
            ),
            const SizedBox(width: 8.0),
            Text(selected?.duration ?? '0:00', style: Theme.of(context).textTheme.caption)
          ],
        ),
      ],
    );
  }
}

class _MoreControls extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.devices_outlined),
          iconSize: 20.0,
        ),
        Row(
          children: [
            IconButton(
              onPressed: () {}, 
              icon: const Icon(Icons.volume_up_outlined),
            ),
            Container(
              height: 5.0, 
              width: 70.0, 
              decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(2.5)),
            )
          ],
        ),
        IconButton(
          onPressed: () {}, 
          icon: const Icon(Icons.fullscreen_outlined),
        )
      ],
    );
  }
}