import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_stickers_internet/app/controller/search/wa_search.dart';
import 'package:flutter_stickers_internet/app/view/navigation/wa_navigation.dart';
import 'package:flutter_stickers_internet/app/widget/global_colors.dart';
import 'package:flutter_stickers_internet/app/widget/hex_colors.dart';

import 'package:http/http.dart' as http;
import 'package:sizer/sizer.dart';


class WaAppBar extends StatefulWidget {
  @override
  _EbookAppBarState createState() => _EbookAppBarState();
}

class _EbookAppBarState extends State<WaAppBar> {

  // GoogleSignIn _googleSignIn = GoogleSignIn(
  //   scopes: [
  //     'email',
  //     'https://www.googleapis.com/auth/contacts.readonly',
  //   ],
  // );

  // Widget checkStatusLogin(){
  //   return StreamBuilder(
  //     stream: _googleSignIn.onCurrentUserChanged,
  //     builder: (BuildContext context, AsyncSnapshot<GoogleSignInAccount> account){
  //       if (account.hasData) {
  //         addIdUser(account.data.id);
  //         return GestureDetector(
  //           onTap: (){
  //             Navigator.of(context).push(new MaterialPageRoute<Null>(
  //                 builder: (BuildContext context) {
  //                   return WaNavigation(
  //                     image: account.data.photoUrl,
  //                     email: account.data.email,
  //                     name: account.data.displayName,
  //                     id: account.data.id,);
  //                 },
  //                 fullscreenDialog: true
  //             ));
  //           },
  //           child: Padding(
  //             padding: EdgeInsets.only(top: 1, bottom: 1, right: 10),
  //             child: Container(
  //               width: 35,
  //               height: 35,
  //               decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   image: new DecorationImage(
  //                     fit: BoxFit.cover,
  //                     image: new NetworkImage(
  //                         account.data.photoUrl.toString()),
  //                   )
  //               ),
  //             ),
  //           ),
  //         );
  //       } else {
  //         return GestureDetector(
  //           onTap: ()=>login(),
  //           child: Padding(
  //             padding: EdgeInsets.only(top: 1, bottom: 1, right: 10),
  //             child: Container(
  //               width: 28,
  //               height: 28,
  //               decoration: BoxDecoration(
  //                   shape: BoxShape.circle,
  //                   image: new DecorationImage(
  //                     fit: BoxFit.fill,
  //                     image: AssetImage(
  //                         'assets/image/account.png',
  //                     ),
  //                   ),
  //               ),
  //             ),
  //           ),
  //         );
  //       }
  //     }
  //   );
  // }

  // Future<void> login() async{
  //   try{
  //     await _googleSignIn.signIn();
  //     http.post(ApiConstant.BASE_URL+ApiConstant.REGISTER
  //         +"name_user="+_googleSignIn.currentUser.displayName.toString()
  //         +"&email_user="+_googleSignIn.currentUser.email.toString()
  //         +"&photo_user="+_googleSignIn.currentUser.photoUrl.toString()
  //         +"&tokens="+_googleSignIn.currentUser.id.toString());
  //   }catch(error){
  //     print("error is: " + error);
  //   }
  // }

  @override
  void initState() {
    // _googleSignIn.signInSilently().whenComplete(() => print("Success logged"));
    // checkStatusLogin();
    super.initState();
  }

  addIdUser(String idUser) async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();
    // preferences.setString("idUser", idUser);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: getColorFromHex(GlobalColors().colorWhite),
      height: 25.0.h,
      child: Padding(
        padding: EdgeInsets.only(top: 4.8.h, left: 3.0.w, right: 3.0.w, bottom: 0.5.h),
        child: Container(
          decoration: BoxDecoration(
            color: getColorFromHex(GlobalColors().activeIconDefault),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Row(
            children: [
              WaSearch(),
              Expanded(
                child: GestureDetector(
                  child: Text('Search Stickers',
                    //DemoLocalizations.of(context).translate('search_edu_book'),
                    style: TextStyle(
                      fontSize: 17,
                      color: getColorFromHex(GlobalColors().searchIconColor), //ebookTheme.themeMode().textAppBar
                    ),
                  ),
                  onTap: (){
                  },
                ),
              ),
             //checkStatusLogin()
            ],
          ),
        )
      ),
    );
  }
}

