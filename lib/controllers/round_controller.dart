import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:word_game_web/constraints/colors.dart';
import 'dart:html' as html;
import '../models/question.dart';

class RoundController extends GetxController
    with GetSingleTickerProviderStateMixin, StateMixin {
  static String emptySign = ' ';

  late PageController _pageController;
  late AnimationController _shakeController;
  late AnimationController _colorController;
  late RxList<Question> _questions;

  PageController get pageController => _pageController;
  RxInt get questionNumber => _questionNumber;
  RxInt get qNumToDisplay => _questionNumberToDisplay;
  List<Question> get questions => _questions;

  final RxInt _questionNumber = 0.obs;
  final RxInt _questionNumberToDisplay = 1.obs;
  int _finishedLevels = 0;

  String locale = 'en';

  RxBool isSoundOn = true.obs;
  bool wideKeyDialog = false;
  bool isWinSnackbarOpen = false;

  @override
  void onClose() {
    super.onClose();
    _pageController.dispose();
  }

  @override
  void onInit() async {
    super.onInit();

    updateTheQnNum(0);
    _pageController = PageController(initialPage: 0);

    change(null, status: RxStatus.loading());
    await loadQuestionsDbData();
    change(null, status: RxStatus.success());
  }

  loadQuestionsDbData() async {
    _finishedLevels = 0;
    _questions = questionsData
        .map(
          (question) => Question(
            id: question['id'],
            answer: question['answer'],
            description: question['description'],
            finished: false,
            isHintUsed: false,
            hintIndex: -1,
            userInput:
                List.generate(question['answer'].length, (index) => emptySign),
          ),
        )
        .toList()
        .obs;

    _questions.refresh();
  }

  void nextQuestion() {
    if (_questionNumber.value != _questions.length) {
      _pageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }
  }

  void previousQuestion() {
    if (_questionNumber.value != 0) {
      _pageController.previousPage(
          duration: const Duration(milliseconds: 250), curve: Curves.ease);
    }
  }

  void updateTheQnNum(int index) {
    _questionNumber.value = index;
    _questionNumberToDisplay.value = index + 1;
  }

  void keyboardPress(BuildContext context, String letter) async {
    Question question = _questions[_questionNumber.value];
    if (question.finished) {
      return;
    }
    if (letter == 'ENTER') {
      String userInput = question.userInput.join("").toLowerCase();
      String answer = question.answer.toLowerCase();
      if (userInput == answer) {
        question.finished = true;
        _finishedLevels += 1;
        _colorController
            .forward(from: 0.0)
            .then((value) => _colorController.reverse());

        if (question.id == 10) {
          gameFinishedDialog(context);
        } else {
          winSnackbar(context);
        }
      } else {
        _shakeController.forward(from: 0.0);
        _colorController
            .forward(from: 0.0)
            .then((value) => _colorController.reverse());
      }
    } else if (letter == 'DEL' || letter == 'BACKSPACE') {
      deleteLetter(question);
    } else {
      inputLetter(question, letter);
    }
    _questions.refresh();
  }

  SnackbarController winSnackbar(BuildContext context) {
    double margin = MediaQuery.of(context).size.width > 600
        ? MediaQuery.of(context).size.width * 0.2
        : 15;
    isWinSnackbarOpen = true;
    return Get.snackbar(
      'Correct answer!',
      'Move to the next question?',
      icon: Icon(Icons.check, color: snackbarText),
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: snackbarBackground,
      borderRadius: 10,
      margin: EdgeInsets.only(bottom: 15, left: margin, right: margin),
      colorText: Colors.white,
      duration: const Duration(days: 365),
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutBack,
      reverseAnimationCurve: Curves.fastOutSlowIn,
      mainButton: TextButton(
        onPressed: () {
          Get.closeCurrentSnackbar();
          isWinSnackbarOpen = false;
          nextQuestion();
        },
        child: Text(
          'Next',
          style: TextStyle(fontSize: 20, color: snackbarText),
        ),
      ),
    );
  }

  gameFinishedDialog(BuildContext context) {
    Get.dialog(
      Container(
        margin: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: dialogBackground,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Column(
          children: [
            Expanded(
              flex: 3,
              child: SizedBox(
                width: 300,
                height: 300,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(18.0),
                    child: Hero(
                      tag: 'app-icon',
                      child: Image.asset(
                        'assets/app_icon.png',
                        // fit: BoxFit.fill,
                      ),
                    )),
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                child: Text(
                  'AI Word Guess',
                  style: GoogleFonts.righteous(
                    textStyle: TextStyle(
                        fontSize: 50,
                        color: dialogText,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                child: Text(
                  'Thanks for playing',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        fontSize: 40,
                        color: dialogText,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: FittedBox(
                child: Text(
                  'If you like the game, please check full game version',
                  style: GoogleFonts.oswald(
                    textStyle: TextStyle(
                        fontSize: 40,
                        color: dialogText,
                        decoration: TextDecoration.none),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: GestureDetector(
                onTap: () {
                  html.window.open(
                      'https://play.google.com/store/apps/details?id=com.pawik.word_game',
                      'new tab');
                },
                child: Image.asset(
                  'assets/google-play-badge.png',
                  // fit: BoxFit.fill,
                ),
              ),
            ),
            Spacer(),
            Expanded(
              flex: 2,
              child: SizedBox(
                width: double.infinity,
                child: MaterialButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: FittedBox(
                    child: Text('Back',
                        style: GoogleFonts.oswald(
                          textStyle: TextStyle(color: dialogText, fontSize: 50),
                        )),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void inputLetter(Question question, String letter) {
    if (letter.length > 1) {
      return;
    }
    for (int i = 0; i < question.answer.length; i++) {
      if (_questions[_questionNumber.value].userInput[i] == emptySign) {
        _questions[_questionNumber.value].userInput[i] = letter;
        break;
      }
    }
  }

  void deleteLetter(Question question) {
    for (int i = (question.answer.length - 1); i >= 0; i--) {
      if (question.userInput[i] != emptySign) {
        if (question.hintIndex != i) {
          question.userInput[i] = emptySign;
          break;
        }
      }
    }
  }

  String getLetter({required int questionIndex, required int letterIndex}) {
    return _questions[questionIndex].userInput[letterIndex];
  }

  String finishedLevelsText() {
    return ' $_finishedLevels / ${_questions.length}';
  }

  void moveToQuestion(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(seconds: 2), curve: Curves.fastOutSlowIn);
  }

  void setAnimationControllers(AnimationController shakeController,
      AnimationController colorController) {
    _shakeController = shakeController;
    _colorController = colorController;
  }

  void useHint() {
    Question question = _questions[_questionNumber.value];
    if (question.isHintUsed != true && question.finished == false) {
      int length = question.answer.length;
      int letterIndex = Random().nextInt(length);
      question.userInput[letterIndex] =
          question.answer[letterIndex].toUpperCase();
      question.isHintUsed = true;
      question.hintIndex = letterIndex;
      _questions.refresh();
    }
  }
}
