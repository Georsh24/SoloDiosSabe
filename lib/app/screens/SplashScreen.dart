import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_stickers_internet/app/ui/pages/login/login_page.dart';
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
    final pages = [
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
              0.1,
              0.60,
            ],
                colors: [
              HexColor('00ff00'),
              HexColor('05d0ae'),
            ])),
        child: Stack(
          children: [
            Positioned(
              child: ClipPath(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logowhite.png',
                      width: 500,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
              0.1,
              0.60,
            ],
                colors: [
              HexColor('A65C4D'),
              HexColor('C43213'),
            ])),
        child: Stack(
          children: [
            Positioned(
              child: ClipPath(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logowhite.png',
                      width: 500,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
              0.1,
              0.60,
            ],
                colors: [
              HexColor('57926F'),
              HexColor('3BC374'),
            ])),
        child: Stack(
          children: [
            Positioned(
              child: ClipPath(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logowhite.png',
                      width: 500,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [
              0.1,
              0.60,
            ],
                colors: [
              HexColor('99d98c'),
              HexColor('4361ee'),
            ])),
        child: Stack(
          children: [
            Positioned(
              child: ClipPath(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/logowhite.png',
                      width: 500,
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 30,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.blue),
                      child: MaterialButton(
                        padding:
                            EdgeInsets.symmetric(horizontal: 100, vertical: 20),
                        child: Text(
                          'Comencemos',
                          style: TextStyle(fontSize: 20),
                        ),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      ),
                    )
                  ],
                ),
              ),
            )
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
                    500, // Establece la distancia de desplazamiento o la sensibilidad para un deslizamiento completo. */
                enableLoop:
                    false, // Habilitar o deshabilitar la recurrencia de páginas. */
                positionSlideIcon:
                    0.45, // Coloque su icono en el eje y en el lado derecho de la pantalla */
                slideIconWidget: Icon(Icons.arrow_back_ios,
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
    });
  }
}
