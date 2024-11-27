import 'package:e_commerce_app/screen/live_scorer.dart';
import 'package:flutter/material.dart';

class LiveScorerApp extends StatefulWidget {
  const LiveScorerApp({super.key});

  @override
  State<LiveScorerApp> createState() => _LiveScorerAppState();
}

class _LiveScorerAppState extends State<LiveScorerApp> {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home:LiveScorer() ,
    );
  }
}
