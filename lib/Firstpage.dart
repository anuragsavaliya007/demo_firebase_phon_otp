import 'package:demo_firebase_phon_otp/Otppage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class Firstpage extends StatefulWidget {
  const Firstpage({Key? key}) : super(key: key);

  @override
  State<Firstpage> createState() => _FirstpageState();
}

class _FirstpageState extends State<Firstpage> {

  TextEditingController tphone = TextEditingController();
  String mverificationId="";
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Otp")),
        body: Column(children: [
        Padding(
        padding: EdgeInsets.all(15),
        child: TextField(
          controller: tphone,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Phone Number',
            hintText: 'Enter Your Phone Number',
            suffixIcon: Icon(
              Icons.contacts_outlined,
            ),

          ),
        ),
      ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(onPressed: () async {

            String phone = tphone.text;

            await FirebaseAuth.instance.verifyPhoneNumber(
              phoneNumber: '+91$phone',
              verificationCompleted: (PhoneAuthCredential credential) {},
              verificationFailed: (FirebaseAuthException e) {},
              codeSent: (String verificationId, int? resendToken) {
                mverificationId = verificationId;
                if(mverificationId.isNotEmpty){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                    return Otppage(mverificationId,);
                  },));
                }

              },
              codeAutoRetrievalTimeout: (String verificationId) {},
            );

            if(tphone.text.length == 10 && mverificationId.isNotEmpty){

            }

          }, child: Text("send otp")),
        )
      ]),
      ),
    );
  }
}
