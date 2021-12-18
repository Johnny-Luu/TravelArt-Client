import 'package:flutter/material.dart';

Widget CommentItem(BuildContext context) {
  return Container(
    width: MediaQuery.of(context).size.width,
    padding: const EdgeInsets.all(10.0),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // circle avatar
            const CircleAvatar(
              radius: 26,
              backgroundImage: AssetImage('assets/images/newyork.jpg'),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text(
                        "Johnny Luu",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        "12 Dec, 2021",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          fontStyle: FontStyle.italic,
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text("⭐⭐⭐⭐⭐"),
                  const SizedBox(height: 6),
                  const Text(
                      "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam quis orci ut ex imperdiet ultricies et vehicula tellus. In hac habitasse platea dictumst. Etiam vitae neque in libero cursus ultrices eu et sem. "),
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
