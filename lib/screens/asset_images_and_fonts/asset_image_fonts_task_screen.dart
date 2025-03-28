import 'package:flutter/material.dart';
import 'package:flutter_trainee_2025/constants/image_constants.dart';

class AssetImageFontsTaskScreen extends StatelessWidget {
  const AssetImageFontsTaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Image(
              image: AssetImage(ImageConstants.taskAssetImageBackground),
              fit: BoxFit.cover,
              height: double.infinity,
              width: double.infinity,
              alignment: Alignment.center,
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * 0.7,
              child: Text(
                "The Arabic world",
                style: TextStyle(
                  fontFamily: 'playwrite',
                  color: Colors.white,
                  fontSize: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
