class VideoEntity {
  final String videoId;
  final String tilte;
  final int durationInSeconds;
  final int seqCount;
  final String language;
  final String videoUrl;
  final String thumbnailUrl;

  VideoEntity(
      {required this.videoId,
      required this.tilte,
      required this.durationInSeconds,
      required this.seqCount,
      required this.language,
      required this.videoUrl,
      required this.thumbnailUrl});
}
