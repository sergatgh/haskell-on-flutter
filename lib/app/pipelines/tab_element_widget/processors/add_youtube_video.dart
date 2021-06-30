import 'package:flutter/material.dart';
import 'package:haskell_is_beautiful/app/entities/content_piece.dart';
import 'package:haskell_is_beautiful/base/pipelines.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class AddYoutubeVideo extends Processor {
  @override
  Object safeExecute(PipelineContext context) {
    final piece = context.get<ContentPiece>("data");

    YoutubePlayerController _controller = YoutubePlayerController(
      initialVideoId: YoutubePlayer.convertUrlToId(piece.data),
      flags: YoutubePlayerFlags(autoPlay: false, hideControls: false),
    );

    return YoutubePlayer(
      controller: _controller,
      liveUIColor: Colors.amber,
      bottomActions: [
        CurrentPosition(),
        ProgressBar(isExpanded: true),
      ],
    );
  }

  @override
  bool safeCondition(PipelineContext context) {
    final piece = context.get<ContentPiece>("data");

    return piece != null && piece.type == "youtube-video";
  }
}
