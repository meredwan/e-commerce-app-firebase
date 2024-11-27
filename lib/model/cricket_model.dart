class CricketScorer {
  final String teamOne;
  final String teamTwo;
  final int teamOneScorer;
  final int wicket;
  final int teamTwoScorer;
  final bool isMatchRunning;
  final String winnerTeam;

  CricketScorer({
    required this.wicket,
    required this.teamOne,
    required this.teamTwo,
    required this.teamOneScorer,
    required this.teamTwoScorer,
    required this.isMatchRunning,
    required this.winnerTeam,
  });

  factory CricketScorer.fromJson(Map<String, dynamic> json) {
    return CricketScorer(
      wicket: json['wicket'],
      teamOne: json['teamOne'],
      teamTwo: json['teamTwo'],
      teamOneScorer: json['teamOneScorer'],
      teamTwoScorer: json['teamTwoScorer'],
      isMatchRunning: json['isMatchRunning'],
      winnerTeam: json['winnerTeam'],
    );
  }
}
