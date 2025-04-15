import 'package:flutter/material.dart';

class FeedbackBar extends StatelessWidget {
  final String question;
  final int selectedItem;
  final Function(int value) onSelectionChange;

  const FeedbackBar({
    super.key,
    required this.question,
    required this.selectedItem,
    required this.onSelectionChange,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(question),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      onSelectionChange(index);
                    },
                    child: Chip(
                      color: WidgetStatePropertyAll(
                        selectedItem == index ? Colors.black : Colors.white,
                      ),
                      label: Text(
                        "${index + 1}",
                        style: TextStyle(
                          color:
                          selectedItem == index
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
