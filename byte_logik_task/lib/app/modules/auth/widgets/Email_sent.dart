import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
class EmailSentDialog extends StatelessWidget {
  const EmailSentDialog({super.key});
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          height: 280,
          width: 250,
          child: Column(
            children: [
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Email Sent",
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 24),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                  padding: EdgeInsets.only(left: 15),
                  width: 200,
                  child: const Text(
                    'A password reset link has been sent to your email.',
                    overflow: TextOverflow.visible,
                    style: TextStyle(fontWeight: FontWeight.w600),
                  )),
              const SizedBox(
                height: 10,
              ),
              SvgPicture.asset(
                'assets/undraw_message_sent_re_q2kl.svg',
                height: 150,
              ),

            ],
          ),
        ),
      ),
    );
  }
}
