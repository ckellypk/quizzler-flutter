import 'package:flutter/material.dart';


/*
* The starter code just creates a column with containers ot hold the questions
* We will be adding all of the functionality including a score keeper based on
* inputs provided by the user button clicks.
*
* The scorekeeper will display the answers selected as the user moves through
* the quiz at the bottom of the screen. We can hard code this now just to see
* how it will render
*
* Looks good there, now we need to add functionality that keeps track of the
* answers as well as ask the questions for the quiz. We need to write a function
* that writes the correct questions to the screen and then processes the
* answer when one of the true or false buttons are clicked.
*
* First lets be able to show the answer provided when the user clicks a button.
* So we need a row that can hold a list of icons. But we don't want to create
* that list in the UI as we want to set the state of this list separately so
* we can update the state easily
*
* Now that he have our list we can fill it. we can pass in the icons we need but
* how do we get th screen to update?
*
* The Row widget can take that list and render it to the screen so lets drop our
* list in there and then update our answer list with the answer input.
*
* Wee need to add the logic of what needs to happen when each button is pressed
* here using the onClick property on our button to set the state. We want to add
* the correct icon with each click
*
* We also want to display questions based on where they are in the quiz. We need
* another list of questions that will be referenced when the button is pressed
* to display a different question to the user. We create the list and update
* its state in the onPressed property for each button by incrementing the list
* value displayed by 1.
*
* At this point our app updates with the user input as desired, but we still
* need to set bounds of the application to run only as long as there are
* questions in the list to ask.
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

  List<Icon> scoreKeeper = [];
  List<String> questions= [
    'You can lead a cow down stairs but not up stairs.',
    'Approximately one quarter of human bones are in the feet.',
    'A slug\'s blood is green.',
  ];

  int questionNumber = 0;

  Icon greenIcon () {
    return Icon(
      Icons.check,
      color: Colors.green,
    );
  }

  Icon redIcon () {
    return Icon(
      Icons.check,
      color: Colors.red,
    );
  }

  String currentQuestion = '';



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
                questions[questionNumber],
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
                  scoreKeeper.add( greenIcon() );
                  questionNumber++;
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
                  scoreKeeper.add(redIcon());
                  questionNumber++;
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
