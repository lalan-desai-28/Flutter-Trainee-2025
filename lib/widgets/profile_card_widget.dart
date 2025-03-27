import 'dart:math' as math;

import 'package:flutter/material.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({
    super.key,
    required this.name,
    required this.username,
    required this.isMale,
    required this.bio,
    required this.moreDescription,
    required this.imageURL,
  });

  final String name;
  final String username;
  final bool isMale;

  final String bio;
  final String moreDescription;
  final String imageURL;

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: Duration(milliseconds: 125),
  );

  @override
  Widget build(BuildContext context) {
    void showAdditionalDetails() {
      showDialog(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text(widget.name),
              content: Text(widget.moreDescription),
            ),
      );
    }

    return GestureDetector(
      onTap: () => showAdditionalDetails(),
      onHorizontalDragStart: (_) {
        _controller.forward().then((_) {
          _controller.reset();
        });
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6),
        child: SizedBox(
          child: Card(
            color:
                widget.isMale
                    ? const Color.fromARGB(255, 250, 222, 222)
                    : const Color.fromARGB(255, 255, 186, 240),
            clipBehavior: Clip.hardEdge,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (_, child) {
                      return Transform.rotate(
                        angle: _controller.value * 2 * math.pi,
                        child: child,
                      );
                    },
                    child: CircleAvatar(
                      radius: 40,
                      backgroundImage: NetworkImage(widget.imageURL),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.name, style: TextStyle(fontSize: 25)),
                        Text(
                          "@${widget.username}",
                          style: TextStyle(
                            fontSize: 17,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: Text(
                            widget.bio,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 20),
                          ),
                        ),

                        Row(children: [
                          
                        ],),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
