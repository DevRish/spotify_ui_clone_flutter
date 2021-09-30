import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_spotify_ui/data/data.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spotify_ui/models/current_track_model.dart';

class Trackslist extends StatelessWidget {
  final List<Song> tracks;
  const Trackslist({ 
    Key? key,
    required this.tracks
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if(Platform.isAndroid) return SingleChildScrollView(child: TracksTable(tracks: tracks));
    else return TracksTable(tracks: tracks);
  }
}

// The data table
class TracksTable extends StatelessWidget {
  final List<Song> tracks;
  const TracksTable({ 
    Key? key,
    required this.tracks
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DataTable(
      headingTextStyle: Theme.of(context).textTheme.overline!.copyWith(fontSize: 12.0),
      dataRowHeight: 54.0,
      showCheckboxColumn: false,
      columns: const [
        DataColumn(label: Text('TITLE')),
        DataColumn(label: Text('ARTIST')),
        DataColumn(label: Text('ALBUM')),
        DataColumn(label: Icon(Icons.access_time)),
      ],
      rows: tracks.map( (e) {
        final selected = context.watch<CurrentTrackModel>().selected?.id == e.id;
        final textstyle = TextStyle(color: selected ? const Color(0xFF1DB954) : Theme.of(context).iconTheme.color);
        return DataRow(
          cells: [
            DataCell(Text(e.title, style: textstyle)),
            DataCell(Text(e.artist, style: textstyle)),
            DataCell(Text(e.album, style: textstyle)),
            DataCell(Text(e.duration, style: textstyle)),
          ],
          selected: selected,
          onSelectChanged: (_) => context.read<CurrentTrackModel>().selectTrack(e)
        );
      }).toList(),
    );
  }
}