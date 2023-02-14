import 'dart:async';
import 'dart:math';
import 'dart:ui';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

int _difficultySettings = 0;

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter sDemo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    void gameChanger(int d) {
      _difficultySettings = d;
      if (d == 5) {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const CoopScreen(title: "marcin")));
      } else {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const ThirdScreen(title: "marcin")));
      }
    }

    return Scaffold(
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/backgroundImage2.png'),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          alignment: Alignment(0, -0.8),
          child: ButtonTheme(
            height: 200,
            child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.black.withOpacity(0.05),
                ),
                onPressed: () {
                  gameChanger(1);
                },
                child: Image.asset(
                  'assets/images/farmer.png',
                  height: 100,
                  scale: 2.5,
                )),
          ),
        ),
        Container(
          alignment: Alignment(0, -0.5),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                gameChanger(2);
              },
              child: Image.asset('assets/images/bandyta.png',
                  height: 100, scale: 2.5)),
        ),
        Container(
          alignment: Alignment(0, -0.2),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                gameChanger(3);
              },
              child: Image.asset('assets/images/szeryf.png',
                  height: 100, scale: 2.5)),
        ),
        Container(
          alignment: Alignment(0, 0.1),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                gameChanger(4);
              },
              child: Image.asset('assets/images/rewolwerowiec.png',
                  height: 100, scale: 2.5)),
        ),
        Container(
          alignment: Alignment(0, 0.4),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                gameChanger(5);
              },
              child:
                  Image.asset('assets/images/1vs1.png', height: 100, scale: 3)),
        ),
        Container(
          alignment: Alignment(0, 0.7),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text("Instrukcja"),
                          content: const Text(
                              "Po wciśnięciu Start masz 3 sekundy na przygotowanie. Po tym gdy czerwony kwadrat zmieni kolor na zielony, jak najszybciej wciśnij cylinder rewolwera"),
                          actions: [
                            TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("Wróć"))
                          ],
                        ));
              },
              child: Image.asset('assets/images/instrukcja.png',
                  height: 100, scale: 2.5)),
        ),
        Container(
          alignment: Alignment(0, 1),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Image.asset('assets/images/cofnij.png',
                  height: 100, scale: 2.5)),
        )
      ],
    ));
  }
}

class ThirdScreen extends StatefulWidget {
  const ThirdScreen({super.key, required this.title});

  final String title;

  @override
  State<ThirdScreen> createState() => _ThirdScreenState();
}

class _ThirdScreenState extends State<ThirdScreen> {
  Stopwatch watch = Stopwatch();
  int seconds = 0;
  int milliSeconds = 0;
  int randomSeconds = 0;
  bool isRandomEqual = false;
  bool gameStarted = false;
  bool gameStartCount = false;
  String countDownDisplay = "";
  bool playerPressedButton = false;
  int aiSeconds = 0;
  int aiMilliseconds = 0;
  int x = 3;

  Timer timerOne = Timer.periodic(const Duration(seconds: 1), (_) {});
  Random rng = Random();
  Timer timer = Timer.periodic(const Duration(seconds: 1), (_) {});

  void startTimer() {
    setState(() {
      gameStarted = true;
      gameStartCount = true;
    });
    aiLearn();
    timerOne = Timer.periodic(const Duration(seconds: 1), (_) {
      if (x == 0) {
        setState(() {
          gameStartCount = false;
          timerOne.cancel();
          listed();
        });
      } else {
        setState(() {
          countDownDisplay = x.toString();
          x = x - 1;
        });
      }
    });
  }

  aiLearn() {
    switch (_difficultySettings) {
      case 1:
        aiSeconds = 1;
        aiMilliseconds = rng.nextInt(20) + 50;
        break;
      case 2:
        aiSeconds = 0;
        aiMilliseconds = rng.nextInt(25) + 74;
        break;
      case 3:
        aiSeconds = 0;
        aiMilliseconds = rng.nextInt(20) + 30;
        break;
      case 4:
        aiSeconds = 0;
        aiMilliseconds = rng.nextInt(5) + 20;
        break;
      case 5:
        break;
    }
  }

  listed() {
    randomSeconds = rng.nextInt(5) + 1;
    if (!watch.isRunning) {
      watch.start();
      timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
        setState(() {
          if (watch.isRunning) {
            seconds = (watch.elapsedMilliseconds ~/ 1000);
            milliSeconds = (watch.elapsedMilliseconds % 1000) ~/ 10;
          }
          if (randomSeconds == seconds) {
            isRandomEqual = true;
            timer.cancel();
            playerTimer();
          }
        });
      });
    }
  }

  playerTimer() {
    watch.reset();
    watch.start();
    timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
      seconds = (watch.elapsedMilliseconds ~/ 1000);
      milliSeconds = (watch.elapsedMilliseconds % 1000) ~/ 10;
      if (seconds == aiSeconds && milliSeconds == aiMilliseconds) {
        timer.cancel();
        timerOne.cancel();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Przegrałeś!"),
                  content: Text(
                      "Przeciwnik strzelił w: $seconds:$milliSeconds sekundy."),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Wróć"))
                  ],
                ));
      } else if (playerPressedButton) {
        timer.cancel();
        timerOne.cancel();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: const Text("Wygrałeś!"),
                  content: Text(
                      "Strzeliłeś w: $seconds:$milliSeconds sekundy. Gratulacje!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Wróć"))
                  ],
                ));
      }
    });
  }

  Color getColor() {
    if (isRandomEqual) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String getCountDown() {
    if (x == 3) {
      return 'assets/images/3.png';
    } else if (x == 2) {
      return 'assets/images/2.png';
    } else if (x == 1) {
      return 'assets/images/1.png';
    } else {
      return 'assets/images/0.png';
    }
  }

  playerPress() {
    if (isRandomEqual) {
      playerPressedButton = true;
    } else {
      timer.cancel();
      timerOne.cancel();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: const Text("Przegrałeś!"),
                content: const Text(
                    "Zbyt szybko wcisnales przycisk przez co przegrales!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("Wróć"))
                ],
              ));
    }
  }

  returned() {
    timerOne.cancel();
    timer.cancel();
    watch.stop();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  appBar: AppBar(title: Text('First screen')),
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pojedynek.png'),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          alignment: Alignment(-1, 0),
          child: Container(
            color: getColor(),
            height: 100,
            width: 100,
          ),
        ),
        Visibility(
            visible: !gameStarted,
            child: Container(
              alignment: Alignment(0, -0.5),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black.withOpacity(0.05),
                  ),
                  onPressed: startTimer,
                  child: Image.asset('assets/images/start.png',
                      height: 200, scale: 2.5)),
            )),
        Container(
          alignment: Alignment(-0.8, 0.8),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: playerPress,
              child: Image.asset('assets/images/strzal.png',
                  height: 200, scale: 2.5)),
        ),
        Visibility(
            visible: gameStartCount,
            child: Container(
              alignment: Alignment(0, -0.5),
              child: Image.asset(getCountDown(), height: 200, scale: 2.5),
            )),
        Container(
          alignment: Alignment(1, 0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: returned,
              child: Image.asset('assets/images/cofnij.png',
                  height: 30, scale: 2.5)),
        )
      ],
    ));
  }
}

class CoopScreen extends StatefulWidget {
  const CoopScreen({super.key, required this.title});

  final String title;

  @override
  State<CoopScreen> createState() => _CoopScreenState();
}

class _CoopScreenState extends State<CoopScreen> {
  Stopwatch watch = Stopwatch();
  int seconds = 0;
  int milliSeconds = 0;
  int randomSeconds = 0;
  bool isRandomEqual = false;
  bool gameStarted = false;
  bool gameStartCount = false;
  String countDownDisplay = "";
  bool playerPressedButton = false;
  int winnerPlayer = 0;
  int x = 3;

  Timer timerOne = Timer.periodic(const Duration(seconds: 1), (_) {});
  Random rng = Random();
  Timer timer = Timer.periodic(const Duration(seconds: 1), (_) {});

  void startTimer() {
    setState(() {
      gameStarted = true;
      gameStartCount = true;
    });
    timerOne = Timer.periodic(const Duration(seconds: 1), (_) {
      if (x == 0) {
        setState(() {
          gameStartCount = false;
          timerOne.cancel();
          listed();
        });
      } else {
        setState(() {
          countDownDisplay = x.toString();
          x = x - 1;
        });
      }
    });
  }

  listed() {
    randomSeconds = rng.nextInt(5) + 1;
    if (!watch.isRunning) {
      watch.start();
      timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
        setState(() {
          if (watch.isRunning) {
            seconds = (watch.elapsedMilliseconds ~/ 1000);
            milliSeconds = (watch.elapsedMilliseconds % 1000) ~/ 10;
          }
          if (randomSeconds == seconds) {
            isRandomEqual = true;
            timer.cancel();
            playerTimer();
          }
        });
      });
    }
  }

  playerTimer() {
    watch.reset();
    watch.start();
    timer = Timer.periodic(const Duration(milliseconds: 1), (_) {
      seconds = (watch.elapsedMilliseconds ~/ 1000);
      milliSeconds = (watch.elapsedMilliseconds % 1000) ~/ 10;
      if (playerPressedButton) {
        timer.cancel();
        timerOne.cancel();
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Wygrywa gracz $winnerPlayer!"),
                  content: Text(
                      "Gracz $winnerPlayer strzelił w: $seconds:$milliSeconds sekundy. Gratulacje!"),
                  actions: [
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                          Navigator.pop(context);
                        },
                        child: const Text("Wróć"))
                  ],
                ));
      }
    });
  }

  Color getColor() {
    if (isRandomEqual) {
      return Colors.green;
    } else {
      return Colors.red;
    }
  }

  String getCountDown() {
    if (x == 3) {
      return 'assets/images/3.png';
    } else if (x == 2) {
      return 'assets/images/2.png';
    } else if (x == 1) {
      return 'assets/images/1.png';
    } else {
      return 'assets/images/0.png';
    }
  }

  playerPress(int id) {
    if (isRandomEqual) {
      playerPressedButton = true;
      winnerPlayer = id;
    } else {
      timer.cancel();
      timerOne.cancel();
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text("Przegrał gracz $id!"),
                content: Text(
                    "Gracz $id zbyt szybko wcisnal przycisk! Wygrywa przeciwny gracz!"),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: const Text("Wróć"))
                ],
              ));
    }
  }

  returned() {
    timerOne.cancel();
    timer.cancel();
    watch.stop();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        //  appBar: AppBar(title: Text('First screen')),
        body: Stack(
      children: [
        Container(
          height: double.infinity,
          width: double.infinity,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/pojedynek.png'),
                fit: BoxFit.cover),
          ),
        ),
        Container(
          alignment: Alignment(0.8, -0.95),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                playerPress(2);
              },
              child: Image.asset('assets/images/strzal.png',
                  height: 150, scale: 2.5)),
        ),
        Container(
          alignment: Alignment(-1, 0),
          child: Container(
            color: getColor(),
            height: 100,
            width: 100,
          ),
        ),
        Visibility(
            visible: !gameStarted,
            child: Container(
              alignment: Alignment(0, -0.5),
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black.withOpacity(0.05),
                  ),
                  onPressed: startTimer,
                  child: Image.asset('assets/images/start.png',
                      height: 200, scale: 2.5)),
            )),
        Container(
          alignment: Alignment(-0.8, 0.95),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: () {
                playerPress(1);
              },
              child: Image.asset('assets/images/strzal.png',
                  height: 150, scale: 2.5)),
        ),
        Visibility(
            visible: gameStartCount,
            child: Container(
              alignment: Alignment(0, -0.5),
              child: Image.asset(getCountDown(), height: 200, scale: 2.5),
            )),
        Container(
          alignment: Alignment(1, 0),
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.black.withOpacity(0.05),
              ),
              onPressed: returned,
              child: Image.asset('assets/images/cofnij.png',
                  height: 30, scale: 2.5)),
        )
      ],
    ));
  }
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 1),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeIn,
  );

  @override
  void initState() {
    final player = AudioCache();
    player.play('assets/sounds/rdrtheme.mp3');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void menuChanger() {
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const SecondScreen()));
    }

    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/images/rdrBackground.png'),
                  fit: BoxFit.cover),
            ),
          ),
          Container(
              alignment: const Alignment(0, -1),
              child: Image.asset('assets/images/ImageTitle.png',
                  height: 200, scale: 2.5)),
          FadeTransition(
              opacity: _animation,
              child: Container(
                  alignment: Alignment(0, 0.9),
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.black.withOpacity(0.05),
                      ),
                      onPressed: menuChanger,
                      child: Image.asset('assets/images/menuScreen.png')))),
        ],
      ),
    );
  }
}
