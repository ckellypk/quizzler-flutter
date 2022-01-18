import 'package:flutter/material.dart';
import 'quiz_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
/*
*
* We should abstract our code and make it more modular. Lets take our quiz app
* question generation logic out of the UI and stick it in its own file called
* quiz_brain.dart. We then create a List of questions here and can now access
* that question list in this page while removing the logic that generated it.
*
* We don't want to allow the answers to be updated from this file though. We
* need to restrict its access. By adding an underscore (_) to the front of a
* property in Dart you make the field private. We make our questionBank private
* and need to refactor to access the values
*
* We make our own getter that gets the string and bool properties from each
* question depending in the quiz_brain file. We then update this
* file to know where the values are coming from by accessing the getters.
*
*Now that the quiz brain is in its own file lets move the question counter to
* that file as well. This makes sense because we don't want any outside code
* dictating what question we are on in our quiz, and our quiz brain will be
* completely self contained.
*
* We crate a private field for this and access it using the nextQuestion method
* which also validates if there is another question available before updating
* the question counter and updating the screen.
*
* Let's also refactor to put the answer checking in a function, that also
* updates the questions and the score tracker.* Now we have a functioning
* application that updates based on user inputs and correct and incorrect
* answers.
*
* Now lets add a package that alerts the user to the end of the quiz. We will
* use package rFlutter_Alert. I added this to the pubspec.yaml and ran pub get
* to place it in my project.
*
*
* */

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {

  QuizBrain quizBrain = QuizBrain();
  List<Icon> scoreKeeper = [];

  void answerChecker(bool answer)  {
    bool currentCorrectAnswer = quizBrain.getQuestionAnswer();

    if(currentCorrectAnswer == answer){
      scoreKeeper.add(greenIcon());
    } else {
      scoreKeeper.add(redIcon());
    }

    if(!quizBrain.continueQuiz()){
      continueAlert().show();
      setState(() {
        scoreKeeper = [];
      });
    } else {
      quizBrain.nextQuestion();

    }
  }

 Alert continueAlert () {
    return Alert(
      context: context,
      type: AlertType.warning,
      title: "QUIZ COMPLETE",
      desc: "You have reached the end of the quiz",
      buttons: [
        DialogButton(
          child: Text(
            "CANCEL",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
          onPressed: ()  {
            Navigator.pop(context);

          },
          color: Color.fromRGBO(0, 179, 134, 1.0),
        ),
      ]
    );
 }
  Icon greenIcon () {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Icon redIcon () {
    return Icon(
      Icons.close,
      color: Colors.red,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quizBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.green),
              child: Text(
                'True',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                ),
              ),
              onPressed: () {
                //The user picked true.
                setState( () {
                  answerChecker(true);
                });

              },
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: TextButton(
              style: TextButton.styleFrom(backgroundColor: Colors.red),
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
              onPressed: () {
                //The user picked false.
                setState( () {
                  answerChecker(false);
                });
              },
            ),
          ),
        ),
        Row(
          children: scoreKeeper
        )

      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
