class PollOptionModel {
  final int id;
  String title;
  final int listingsId;
  int votes;

  PollOptionModel({
    required this.id,
    required this.title,
    required this.listingsId,
    required this.votes,
  });

  factory PollOptionModel.fromJson(Map<String, dynamic> json) {
    return PollOptionModel(
      id: json['id'],
      title: json['title'],
      listingsId: json['listingId'],
      votes: json['votes'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'listingsId': listingsId,
      'votes': votes,
    };
  }
}
