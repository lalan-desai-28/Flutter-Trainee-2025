import 'package:flutter/material.dart';

import '../../../widgets/feedback_bar.dart';

class FeedbackInfoScreen extends StatefulWidget {
  const FeedbackInfoScreen({super.key});

  @override
  State<FeedbackInfoScreen> createState() => _FeedbackInfoScreenState();
}

class _FeedbackInfoScreenState extends State<FeedbackInfoScreen> {
  int _q1Rate = -1;
  int _q2Rate = -1;
  int _q3Rate = -1;

  Widget _buildFeedbackBarOne() {
    return FeedbackBar(
      question: "How much do you like being here?",
      selectedItem: _q1Rate,
      onSelectionChange: (value) {
        setState(() {
          _q1Rate = value;
        });
      },
    );
  }

  Widget _buildFeedbackBarTwo() {
    return FeedbackBar(
      question: "How much you would like to suggest this to others?",
      selectedItem: _q2Rate,
      onSelectionChange: (value) {
        setState(() {
          _q2Rate = value;
        });
      },
    );
  }

  Widget _buildFeedbackBarThree() {
    return FeedbackBar(
      question: "How was your overall experience?",
      selectedItem: _q3Rate,
      onSelectionChange: (value) {
        setState(() {
          _q3Rate = value;
        });
      },
    );
  }

  Widget _buildSubmitButton() {
    return Center(
      child: ElevatedButton(onPressed: () {}, child: Text("Submit")),
    );
  }

  Widget _buildSidePanel() {
    return Expanded(
      child: Container(
        height: double.infinity,
        color: Colors.redAccent,
        child: Column(
          spacing: 30,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 80),
            Text(
              "Just right there!",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.26,
              child: Text(
                textAlign: TextAlign.center,
                "Please input a genuine feedback as it's help us to improve a lot 😊",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackForm() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.31,
        child: Column(
          spacing: 20,
          children: [
            Text("Feedback Information", style: TextStyle(fontSize: 30)),
            _buildFeedbackBarOne(),
            _buildFeedbackBarTwo(),
            _buildFeedbackBarThree(),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.6,
        width: MediaQuery.of(context).size.width * 0.7,
        child: Card(
          clipBehavior: Clip.hardEdge,
          child: Row(children: [_buildSidePanel(), _buildFeedbackForm()]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
