import 'dart:async';
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../model/cricket_model.dart';

class LiveScorer extends StatefulWidget {
  const LiveScorer({super.key});

  @override
  State<LiveScorer> createState() => _LiveScorerState();
}

class _LiveScorerState extends State<LiveScorer> {
  List<CricketScorer> cricketScorerList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: const Text(
          "Live Scorer",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('Cricket').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return Text(snapshot.error.toString());
            }
            if (snapshot.hasData) {
              _extractData(snapshot.data);
              return ListView.builder(
                itemCount: cricketScorerList.length,
                itemBuilder: (context, index) {
                  CricketScorer cricketScorer = cricketScorerList[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 30,
                    ),
                    child: Column(
                      children: [
                        ListTile(
                          leading: Badge(
                              backgroundColor: _indicatorColor(
                                  cricketScorer.isMatchRunning)),
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.flag),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(cricketScorer.teamOne)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(cricketScorer.teamOneScorer
                                          .toString()),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.flag),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(cricketScorer.teamTwo)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(cricketScorer.teamTwoScorer
                                          .toString()),
                                    ],
                                  )
                                ],
                              ),
                              Text(cricketScorer.winnerTeam == ""
                                  ? "Penning"
                                  : cricketScorer.winnerTeam)
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          }),
    );
  }

  void _extractData(QuerySnapshot<Map<String, dynamic>>? snapshot) {
    cricketScorerList.clear();
    for (DocumentSnapshot doc in snapshot?.docs ?? []) {
      cricketScorerList
          .add(CricketScorer.fromJson(doc.data() as Map<String, dynamic>));
    }
  }

  Color _indicatorColor(bool isMatchRunning) {
    return isMatchRunning ? Colors.green : Colors.grey;
  }
}
