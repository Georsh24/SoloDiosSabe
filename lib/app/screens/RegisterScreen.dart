// import 'package:flutter/material.dart';
// import 'package:flutter_stickers_internet/app/provider/loginFormProvider.dart';
// import 'package:flutter_stickers_internet/app/services/AuthService.dart';
// import 'package:flutter_stickers_internet/app/widgets/CardContainer.dart';
// import 'package:flutter_stickers_internet/app/widgets/auth_background.dart';
// import 'package:flutter_stickers_internet/app/ui/InputDecoration.dart';
// import 'package:hexcolor/hexcolor.dart';
// import 'package:provider/provider.dart';

// class RegisterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: AuthBackround(
//       child: SingleChildScrollView(
//         child: Column(
//           children: [
//             SizedBox(
//               height: 250,
//             ),
//             CardContainer(
//                 child: Column(
//               children: [
//                 SizedBox(height: 10),
//                 Text(
//                   'Crear cuenta',
//                   style: Theme.of(context).textTheme.headline4,
//                 ),
//                 SizedBox(
//                   height: 30,
//                 ),
//                 ChangeNotifierProvider(
//                   create: (_) => LoginFormProvider(),
//                   child: _LoginForm(),
//                 )
//               ],
//             )),
//             SizedBox(
//               height: 50,
//             ),
//             TextButton(
//               child: Text(
//                 '¿Ya tienes una cuenta?',
//                 style: TextStyle(fontSize: 18, color: Colors.black87),
//               ),
//               style: ButtonStyle(
//                   overlayColor:
//                       MaterialStateProperty.all(Colors.indigo.withOpacity(0.1)),
//                   shape: MaterialStateProperty.all(StadiumBorder())),
//               onPressed: () {
//                 Navigator.pushReplacementNamed(context, 'login');
//               },
//             ),
//             SizedBox(
//               height: 50,
//             ),
//           ],
//         ),
//       ),
//     ));
//   }
// }

// class _LoginForm extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final loginForm = Provider.of<LoginFormProvider>(context);

//     return Container(
//       child: Form(
//           key: loginForm.formKey,
//           autovalidateMode: AutovalidateMode.onUserInteraction,
//           child: Column(
//             children: [
//               TextFormField(
//                 autocorrect: false,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecorations.authInputDecorations(
//                   hintText: 'sticker_fun@stickerfun.com',
//                   labelText: 'Email',
//                   prefixIcon: Icons.alternate_email_sharp,
//                 ),
//                 onChanged: (value) => loginForm.email = value,
//                 validator: (value) {
//                   String pattern =
//                       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//                   RegExp regExp = new RegExp(pattern);
//                   return regExp.hasMatch(value ?? '') ? null : 'Email Invalido';
//                 },
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               TextFormField(
//                 autocorrect: false,
//                 obscureText: true,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecorations.authInputDecorations(
//                   hintText: '*****',
//                   labelText: 'Password',
//                   prefixIcon: Icons.lock_outline,
//                 ),
//                 onChanged: (value) => loginForm.password = value,
//                 validator: (value) {
//                   if (value != null && value.length >= 6) return null;
//                   return 'La contraseña debe de ser de 6 caracteres';
//                 },
//               ),
//               SizedBox(
//                 height: 30,
//               ),
//               Container(
//                 decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(10),
//                     gradient: LinearGradient(
//                         begin: Alignment.topLeft,
//                         end: Alignment.topRight,
//                         stops: [
//                           0.1,
//                           0.80,
//                         ],
//                         colors: [
//                           HexColor('00ff00'),
//                           HexColor('05d0ae'),
//                         ])),
//                 child: MaterialButton(
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(10)),
//                     disabledColor: Colors.grey,
//                     elevation: 0,
//                     child: Container(
//                       padding:
//                           EdgeInsets.symmetric(horizontal: 80, vertical: 15),
//                       child: Text(
//                         loginForm.isLoading ? 'Loading...' : 'Sing Up',
//                         style: TextStyle(
//                             color: Colors.white,
//                             fontWeight: FontWeight.bold,
//                             fontSize: 18),
//                       ),
//                     ),
//                     onPressed: loginForm.isLoading
//                         ? null
//                         : () async {
//                             FocusScope.of(context).unfocus();
//                             final authService = Provider.of<AuthService>(
//                                 context,
//                                 listen: false);
//                             if (!loginForm.isValidForm()) return;
//                             loginForm.isLoading = true;

//                             // validar si el login es correcto
//                             final String? errorMessage =
//                                 await authService.createUser(
//                                     loginForm.email, loginForm.password);
//                             if (errorMessage == null) {
//                               Navigator.pushReplacementNamed(context, 'home');
//                             } else {
//                               print(errorMessage);
//                               loginForm.isLoading = false;
//                             }
//                           }),
//               )
//             ],
//           )),
//     );
//   }
// }
