import 'package:demo_firebase_phon_otp/Firstpage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class Otppage extends StatefulWidget {
  String mverificationId;
  Otppage(this.mverificationId);



  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {

  FirebaseAuth auth = FirebaseAuth.instance;
  String otp = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
        OtpTextField(
          numberOfFields: 6,
          keyboardType: TextInputType.number,


          borderColor: Color(0xFF512DA8),
          //set to true to show as box or false to show as dash
          showFieldAsBox: true,
          //runs when a code is typed in
          onCodeChanged: (String code) {
            //handle validation or checks here
          },
          //runs when every textfield is filled
          onSubmit: (String verificationCode) async {

            showDialog(

                context: context,
                builder: (context){
                  return AlertDialog(

                    title: Text("Verification Code"),
                    content: Text('Code entered is $verificationCode'),

                  );
                }
            );
            PhoneAuthCredential credential = PhoneAuthProvider.credential(verificationId: widget.mverificationId, smsCode: verificationCode);

            // Sign the user in (or link) with the credential
            await auth.signInWithCredential(credential).then((value) {

              print(value);
            },);
          }, // end onSubmit
        ),
          ElevatedButton(onPressed: () async {


            // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            //   return Firstpage();
            // },));



          }, child: Text("Submit")),

      ],)),
    );
  }
}
