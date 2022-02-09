import 'package:task_master/others/chat_users_model.dart';

enum MediaType {
  image,
  video,
}

class Story {
  final String url;
  final MediaType media;
  final Duration duration;
  final ChatUsers user;

  const Story({
    required this.url,
    required this.media,
    required this.duration,
    required this.user,
  });
}
