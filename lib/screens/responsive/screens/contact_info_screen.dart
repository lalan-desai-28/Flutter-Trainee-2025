import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_trainee_2025/screens/responsive/screens/feedback_info_screen.dart';

import '../../../widgets/custom_signup_form_field.dart';

class ContactInfoScreen extends StatefulWidget {
  const ContactInfoScreen({super.key});

  @override
  State<ContactInfoScreen> createState() => _ContactInfoScreenState();
}

class _ContactInfoScreenState extends State<ContactInfoScreen> {
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

  Widget _buildNextButton() {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => FeedbackInfoScreen()));
        },
        child: Text("Next"),
      ),
    );
  }

  Widget _buildFormPanel() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.31,
        child: Column(
          spacing: 20,
          children: [
            Text("Contact Information", style: TextStyle(fontSize: 30)),
            _buildNameField(),
            _buildEmailField(),
            _buildNumberField(),
            _buildNextButton(),
          ],
        ),
      ),
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
              "Hello Friend!",
              style: TextStyle(color: Colors.white, fontSize: 30),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.26,
              child: Text(
                textAlign: TextAlign.center,
                "Enter your personal contact details to continue to the feedback form.",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
            ),
            Spacer(),
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
          child: Row(children: [_buildFormPanel(), _buildSidePanel()]),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: _buildBody());
  }
}
