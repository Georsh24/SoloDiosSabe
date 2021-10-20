import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stickers_internet/app/ui/routes/routes.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  /// Declarar variables
  int page = 0; // Posición de la página
  bool enableSlideIcon =
      true; // Controla el estado de la visibilidad de iconButton para deslizar la pantalla del lado izquierdo
  bool isDarkGlobal = false; // Controla el brillo de la barra de estado

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final colorshex1 =
        Theme.of(context).brightness == Brightness.dark ? '3A3E98' : '00ff00';
    final colorshex2 =
        Theme.of(context).brightness == Brightness.dark ? '4AB1D8' : '05d0ae';
    final pages = [
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            _Tapiz(size: size),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15.0,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: size.height * 0.50,
                      width: size.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image(
                                image: (AssetImage('assets/logowhite.png'))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            _Tapiz2(size: size),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15.0,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: size.height * 0.50,
                      width: size.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image(
                                image: (AssetImage('assets/logowhite.png'))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            _Tapiz3(size: size),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15.0,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: size.height * 0.50,
                      width: size.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            child: Image(
                                image: (AssetImage('assets/logoblack.png'))),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      Container(
        height: double.infinity,
        width: double.infinity,
        child: Stack(
          children: [
            _Tapiz4(size: size),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 30),
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    SizedBox(
                      height: size.width * 0.50,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            blurRadius: 15.0,
                          )
                        ],
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      height: size.height * 0.50,
                      width: size.width * 0.75,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            child: Image(
                              image: (AssetImage('assets/logowhite.png')),
                            ),
                          ),
                          SizedBox(
                            height: size.height * 0.29,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                width: size.width * 0.7,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.topRight,
                                    stops: [
                                      0.1,
                                      0.80,
                                    ],
                                    colors: [
                                      HexColor('$colorshex1'),
                                      HexColor('$colorshex2'),
                                    ],
                                  ),
                                ),
                                child: MaterialButton(
                                  child: Text(
                                    'Let´s Start!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () {
                                    Navigator.pushNamed(context, Routes.LOGIN);
                                  },
                                ),
                              ),
                              SizedBox(
                                height: size.height * 0.02,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ];
    // Cambia el brillo de la barra de estado segun el el brillo pasado en cada vista
    SystemChrome.setSystemUIOverlayStyle(
        isDarkGlobal ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light);

    return Scaffold(
      body: Builder(
          builder: (context) => LiquidSwipe(
                initialPage: 0,
                fullTransitionValue:
                    800, // Establece la distancia de desplazamiento o la sensibilidad para un deslizamiento completo. */
                enableLoop:
                    false, // Habilitar o deshabilitar la recurrencia de páginas. */
                positionSlideIcon:
                    0.5, // Coloque su icono en el eje y en el lado derecho de la pantalla */
                slideIconWidget: Icon(Icons.arrow_back_ios,
                    size: size.width * 0.10,
                    color: isDarkGlobal ? Colors.black : Colors.white),
                pages:
                    pages, // Establecer las páginas / vistas / contenedores */
                onPageChangeCallback:
                    onPageChangeCallback, // Pase su método como devolución de llamada, devolverá un número de página. */
                waveType: WaveType
                    .liquidReveal, // Seleccione el tipo de revelación que desea. */
              )),
    );
  }

  /// liquid_swipe / Pase su método como devolución de llamada, devolverá un número de página. */
  onPageChangeCallback(int lpage) {
    setState(
      // Controla el estado de la visibilidad de iconButton para deslizar la pantalla del lado izquierdo
      () {
        page = lpage;
        if (4 == page) {
          // Esconde el iconButton de desplazamiento */
          enableSlideIcon = false;
          // Aplicar color oscuro al iconButton de deslizamiento */
          isDarkGlobal = true;
        } else {
          // Muestra el iconButton de desplazamiento */
          enableSlideIcon = true;
          // Por default aplica el brillo al iconButton */
          isDarkGlobal = false;
        }
      },
    );
  }
}

class _Tapiz extends StatelessWidget {
  const _Tapiz({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/1.png'), fit: BoxFit.cover),
      ),
    );
  }
}

class _Tapiz2 extends StatelessWidget {
  const _Tapiz2({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/2.png'), fit: BoxFit.cover),
      ),
    );
  }
}

class _Tapiz3 extends StatelessWidget {
  const _Tapiz3({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/3.png'), fit: BoxFit.cover),
      ),
    );
  }
}

class _Tapiz4 extends StatelessWidget {
  const _Tapiz4({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/4.png'), fit: BoxFit.cover),
      ),
    );
  }
}

// class _LogoTapiz extends StatelessWidget {
//   const _LogoTapiz({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     return Container(
//       width: size.width * 0.35,
//       child: Opacity(
//         opacity: 0.3,
//         child: Image(
//           image: AssetImage('assets/logoblack.png'),
//         ),
//       ),
//     );
//   }
// }
