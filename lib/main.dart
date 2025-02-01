import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyCalculatricex());
}

class MyCalculatricex extends StatefulWidget {
  const MyCalculatricex({super.key});

  @override
  State<MyCalculatricex> createState() => _MyCalculatricexState();
}



class _MyCalculatricexState extends State<MyCalculatricex> {
  String? affichage;
  String? result;
  bool isDark = true;

  Color get couleur1 => isDark ? Color(0xFF17171C) : Color(0xFFF1F2F3);
  Color get couleur2 => isDark ? Color(0xFF2E2F38) : Color(0xFFFFFFFF);
  Color get couleur4 => isDark ? Color(0xFFFFFFFF) : Color(0xFF000000);
  Color get couleur5 => isDark ? Color(0xFF7B61FF) : Color(0xFF4B5EFC);
  Color get couleur6 => isDark ? Color(0xFF4E505F) : Color(0xFFD2D3DA);
  Widget myContainer = Container(
    width: 30,
    height: 30,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      color: Color.fromRGBO(229, 229, 229, 0.4),
    ),
  );

  void ajouterValeur(String valeur){
    setState(() {
      if (affichage == "0") {
        affichage = "";
      } else if (affichage == "." && affichage == "") {
        affichage = "0.";
      }

      affichage = (affichage ?? "") + valeur;
    });
  }

  void ajouterSigne(String signe){
    setState(() {
      //pour eviter que les ooperateur se reprte et aussi pas d'operateur quand affichage est null ou contient une chaine vide
      double? x = double.tryParse(affichage!); //varible pour stocker la conversion de affichage en double. si impossible xa retour null. donc evite dounle operation exemple: 1+2-4
      if(affichage != null && affichage != ''){
        if(affichage?[affichage!.length - 1] == "+" || affichage?[affichage!.length - 1] == "-" || affichage?[affichage!.length - 1] == "x" || affichage?[affichage!.length - 1] == "\u00F7"){
          affichage = (affichage!.substring(0, affichage!.length -1) + signe);
        }else if(x != null){
          affichage = affichage! + signe;
        }
      }
    });
  }

  void calcul(){
    setState(() {
      double? nbr1;
      double? nbr2;
      String? signe;
      //si on convertis la premiere valeur en nombre negatif il faut s'assurer que la boucle commence apres le signe -
      bool casNegatif = affichage![0] == '-';
      int j = casNegatif ? 1 : 0;
      for(int i = j; i < affichage!.length; i++){
        if(affichage![i] == "+" || affichage![i] == "-" || affichage![i] == "x" || affichage![i] == "\u00F7" || affichage![i] == "%"){
          signe = affichage![i];
          nbr1 = double.tryParse(affichage!.substring(0, i));
          nbr2 = double.tryParse(affichage!.substring(i + 1));
          break;
        }
      }
      switch(signe){
        case '\u00F7':
          if(nbr2 == 0){
            result = 'Infini';
          }else{
            result = "${nbr1! / nbr2!}";
          }
          break;

        case '%':
          if(nbr2 == 0){
            result = 'Impossible';
          }else{
            result = "${nbr1! % nbr2!}";
          }
          break;

        case 'x':
          result = '${nbr1! * nbr2!}';
          break;

        case '-':
          result = '${nbr1! - nbr2!}';
          break;

        case '+':
          result = '${nbr1! + nbr2!}';
          break;
      }
    });
  }



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        resizeToAvoidBottomInset: false, //pour empecher une deformation de l'affichage ou pour rendre l'affichage fixe
        backgroundColor: couleur1,
        appBar: AppBar(
            title: Text("CalculatriX de Carlos", style: TextStyle(color: couleur4),),
            backgroundColor: couleur1
        ),
        body: Column(
          children: [
            SizedBox(
              width: 110,
              height: 40,
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      isDark = !isDark;
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: couleur2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      isDark ? myContainer : Icon(isDark ? (CupertinoIcons.moon) : (CupertinoIcons.sun_min_fill), color: couleur5, size: 24,),
                      SizedBox(width: 8),
                      !isDark ? myContainer : Icon(isDark ? (CupertinoIcons.moon) : (CupertinoIcons.sun_min_fill), color: couleur5, size: 24,)
                    ],
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(35.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(height: 50,),
                  SizedBox(
                    width: 335,
                    height: 47,
                    child: Text(affichage ?? '', style: TextStyle(
                      color: isDark ? Color.fromRGBO(229, 229, 229, 0.7) : Color(0xFFD2D3DA),
                      fontSize: 28,
                    ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(
                    width: 335,
                    height: 96,
                    child: Text(result ?? '', style: TextStyle(
                      color: couleur4,
                      fontSize: 80,
                    ),
                      textAlign: TextAlign.right,
                    ),
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                            onPressed: () {
                              setState(() {
                                affichage = "0";
                                affichage = int.parse(affichage!).toString();
                                result = '';
                              });
                            },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur6,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                            child: Text("C", style: TextStyle(
                              color: couleur4,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              if(affichage != null){
                                double valeur = double.parse(affichage!);
                                if(valeur > 0){
                                  affichage = (-valeur).toString();
                                }
                                if(valeur < 0){
                                  affichage = (-valeur).toString();
                                }
                              }
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Icon(CupertinoIcons.plus_slash_minus, color: couleur4, size: 32)
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterSigne("%"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur6,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                            child: Icon(CupertinoIcons.percent, color: couleur4, size: 32)
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterSigne("\u00F7"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur5,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                            child: Icon(CupertinoIcons.divide, color: couleur4, size: 32)
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("7"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("7", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                            onPressed: () => ajouterValeur("8"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: couleur2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)
                              ),
                            ),
                            child: Text("8", style: TextStyle(
                              color: couleur4,
                              fontSize: 32,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("9"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("9", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                            onPressed: () => ajouterSigne("x"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: couleur5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)
                              ),
                            ),
                            child: Icon(CupertinoIcons.multiply, color: couleur4, size: 32)
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("4"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("4", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("5"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("5", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("6"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("6", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                            onPressed: () => ajouterSigne("-"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: couleur5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)
                              ),
                            ),
                            child: Icon(CupertinoIcons.minus, color: couleur4, size: 32)
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("1"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("1", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("2"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("2", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("3"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("3", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                            onPressed: () => ajouterSigne("+"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: couleur5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)
                              ),
                            ),
                            child: Icon(CupertinoIcons.plus, color: couleur4, size: 32)
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 16,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("."),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text(".", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () => ajouterValeur("0"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                          child: Text("0", style: TextStyle(
                            color: couleur4,
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                          ),
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              affichage = affichage?.substring(0, affichage!.length - 1);
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: couleur2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24)
                            ),
                          ),
                            child: Icon(CupertinoIcons.delete_left, color: couleur4, size: 32)
                        ),
                      ),
                      SizedBox(width: 17,),
                      SizedBox(
                        width: 71.5,
                        height: 72,
                        child: ElevatedButton(
                            onPressed: () => calcul(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: couleur5,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(24)
                              ),
                            ),
                            child: Icon(CupertinoIcons.equal, color: couleur4, size: 32)
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

