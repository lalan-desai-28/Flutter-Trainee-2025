import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trainee_2025/screens/responsive/screens/contact_info_screen.dart';
import 'package:flutter_trainee_2025/widgets/custom_signup_form_field.dart';
import 'package:flutter_trainee_2025/widgets/feedback_bar.dart';

class AdaptiveFromScreen extends StatefulWidget {
  const AdaptiveFromScreen({super.key});

  @override
  State<AdaptiveFromScreen> createState() => _AdaptiveFromScreenState();
}

class _AdaptiveFromScreenState extends State<AdaptiveFromScreen> {
  int _q1Rate = -1;
  int _q2Rate = -1;
  int _q3Rate = -1;

  Widget _buildNameField() {
    return SignUpFormField(
      hintText: "Name",
      prefixIcon: Icon(Icons.person),

      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            !(RegExp(r"^[a-zA-Z ]+$").hasMatch(value))) {
          return "Please enter a proper name.";
        }
        return null;
      },
      inputFormatters: [
        FilteringTextInputFormatter(RegExp('[a-zA-Z ]'), allow: true),
      ],
    );
  }

  Widget _buildNumberField() {
    return SignUpFormField(
      hintText: "Number",
      maxLength: 10,
      counterText: "",
      prefixIcon: Icon(Icons.phone),
      keyboardType: TextInputType.numberWithOptions(
        decimal: false,
        signed: false,
      ),
      validator: (value) {
        if (value == null || value.isEmpty || value.length != 10) {
          return "Please enter a proper number.";
        }
        return null;
      },
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
    );
  }

  Widget _buildEmailField() {
    return SignUpFormField(
      hintText: "Email",
      prefixIcon: Icon(Icons.email),
      inputFormatters: [
        FilteringTextInputFormatter(
          RegExp("[a-z0-9.@]"),
          allow: true,
          replacementString: '',
        ),
      ],
      keyboardType: TextInputType.emailAddress,
      validator: (value) {
        if (value == null ||
            value.isEmpty ||
            (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value))) {
          return "Please enter a proper email address.";
        }
        return null;
      },
    );
  }

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
      child: ElevatedButton(
        onPressed: () {},
        child: Text("Submit")
      ),
    );
  }

  Widget _buildCompactBody() {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            spacing: 10,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Contact Information", style: TextStyle(fontSize: 30),),
              _buildNameField(),
              _buildNumberField(),
              _buildEmailField(),
      
              Text("Feedback Information", style: TextStyle(fontSize: 30),),
              _buildFeedbackBarOne(),
              _buildFeedbackBarTwo(),
              _buildFeedbackBarThree(),
      
              _buildSubmitButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWideBody() {
    return ContactInfoScreen();
  }

  Widget _buildBody() {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 600) {
          return _buildCompactBody();
        } else {
          return _buildWideBody();
        }
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
