import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travelapp/models/comment_model.dart';
import 'package:travelapp/models/customer_model.dart';

Widget CommentItem(BuildContext context, Customer customer, Comment comment) {
  String displayRating() {
    String rating = '';
    for (int i = 0; i < comment.rating; i++) {
      rating += '⭐';
    }
    return rating;
  }

  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // circle avatar
            CircleAvatar(
              radius: 26.0,
              backgroundImage: MemoryImage(base64Decode(customer.avatar)),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        customer.name,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        comment.time,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 2),
                  Text(displayRating()),
                  const SizedBox(height: 6),
                  Text(comment.comment),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 1,
          margin: const EdgeInsets.symmetric(horizontal: 30),
          color: Colors.grey[300],
        ),
      ],
    ),
  );
}
