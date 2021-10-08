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
    final size = MediaQuery.of(context).size;
    final pages = [
      Container(
        height: double.infinity,
        width: double.infinity,
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
            _tapiz(size: size),
            Padding(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            SizedBox(height: size.width * 0.50,),
            Container(
              color: Colors.white,
              width: size.width * 0.75,
              child: Column(
                children: [
                  Text('')
                ],
              ),
            )
          ],
        ),
 
      ),
    ),
          ],
        ),

        // child: Center(
        //   child: Stack(

        //     children: [

        //       Positioned(
        //         child: ClipPath(
        //           child: Column(
        //             mainAxisAlignment: MainAxisAlignment.center,
        //             children: [
        //               Image.asset(
        //                 'assets/logowhite.png',
        //                 width: 500,
        //               ),
        //             ],
        //           ),
        //         ),
        //       )
        //     ],
        //   ),
        // ),
      ),
      Container(
        width: double.infinity,
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
        width: double.infinity,
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
        width: double.infinity,
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

class _tapiz extends StatelessWidget {
  const _tapiz({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
    
      child: Stack(
        children: [
          // 1, 1
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.05,
            left: size.width * 0.05,
          ),
          // 1,2
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.05,
            left: size.width * 0.55,
          ),
          //2,1
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.2,
            left: size.width * -0.25,
          ), 
          // 2,2
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.2,
            left: size.width * 0.3,
          ), 
          //2,3
           Positioned(
            child: _logoTapiz(),
            top: size.height * 0.2,
            left: size.width * 0.8,
          ),
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.35,
            left: size.width * 0.1,
          ),
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.35,
            left: size.width * 0.6,
          ),
            Positioned(
            child: _logoTapiz(),
            top: size.height * 0.5,
            left: size.width * -0.1,
          ),
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.5,
            left: size.width * 0.4,
          ),
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.5,
            left: size.width * 0.9,
          ),
         
           Positioned(
            child: _logoTapiz(),
            top: size.height * 0.65,
            left: size.width * 0.15,
          ),  Positioned(
            child: _logoTapiz(),
            top: size.height * 0.65,
            left: size.width * 0.65,
          ),
           Positioned(
            child: _logoTapiz(),
            top: size.height * 0.8,
            left: size.width * -0.1,
          ),
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.8,
            left: size.width * 0.4,
          ),
          
          Positioned(
            child: _logoTapiz(),
            top: size.height * 0.8,
            left: size.width * 0.9,
          ),
            Positioned(
            child: _logoTapiz(),
            top: size.height * 0.95,
            left: size.width * -0.3,
          ),
           Positioned(
            child: _logoTapiz(),
            top: size.height * 0.95,
            left: size.width * 0.2,
          ),
           Positioned(
            child: _logoTapiz(),
            top: size.height * 0.95,
            left: size.width * 0.7,
          ),
           
           
         
        ],
      ),
    );
  }
}

class _logoTapiz extends StatelessWidget {
  const _logoTapiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final size = MediaQuery.of(context).size;
    return Container(

   
      width: size.width * 0.35,
      child: Opacity(
        opacity: 0.3,
        child: Image(image: AssetImage('assets/logoblack.png')),
      ),
    );
  }
}
