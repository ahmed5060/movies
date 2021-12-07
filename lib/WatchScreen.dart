// ignore_for_file: use_key_in_widget_constructors, file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

class WatchScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "WatchList",
            style: TextStyle(
              color: Colors.white,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 15,),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (context, index){
                    return Row(
                      children: [
                        Image.asset("assets/images/Image.png"),
                        const SizedBox(width: 15,),
                        Expanded(
                          child: Column(
                            children: [
                              Text(
                                "Dora and the last city of gold",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  overflow: TextOverflow.clip,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "2019",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 10,),
                              Text(
                                "Dora, savwvwarve, vcewevwe",
                                style: TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                          ),
                        ),
                      ],
                    );
                  },
                  separatorBuilder: (context, index){
                    return Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Container(
                        width: double.infinity,
                        height: 1,
                        color: Colors.white,
                      ),
                    );
                  },
                  itemCount: 5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}