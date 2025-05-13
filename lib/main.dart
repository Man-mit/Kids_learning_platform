import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kids Learning App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Comic Sans MS',
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.blue,
          primary: Colors.blue,
          secondary: Colors.orange,
        ),
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ScaleTransition(
              scale: _animation,
              child: Container(
                width: 200,
                height: 200,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [Colors.blue, Colors.purple],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Center(
                  child: Lottie.asset(
                    'assets/animations/owl_wave.json',
                    width: 150,
                    height: 150,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 30),
            const Text(
              "Kids Learning App",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              "Learn Numbers & Alphabets",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Lottie.asset(
              'assets/animations/owl_wave.json',
              width: 40,
              height: 40,
            ),
            const SizedBox(width: 10),
            const Text(
              'Kids Learning App',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          tabs: const [
            Tab(
              icon: Icon(Icons.book),
              text: 'Lessons',
            ),
            Tab(
              icon: Icon(Icons.quiz),
              text: 'Quiz',
            ),
            Tab(
              icon: Icon(Icons.leaderboard),
              text: 'Leaders',
            ),
            Tab(
              icon: Icon(Icons.person),
              text: 'Profile',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          LessonsTab(),
          QuizTab(),
          LeaderboardTab(),
          ProfileTab(),
        ],
      ),
    );
  }
}

class LessonsTab extends StatelessWidget {
  const LessonsTab({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          Container(
            color: Colors.blue[100],
            child: const TabBar(
              labelColor: Colors.blue,
              unselectedLabelColor: Colors.grey,
              indicatorColor: Colors.blue,
              tabs: [
                Tab(text: 'ALPHABETS'),
                Tab(text: 'NUMBERS'),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              children: [
                _buildAlphabetsGrid(),
                _buildNumbersGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAlphabetsGrid() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 26,
        itemBuilder: (context, index) {
          final letter = String.fromCharCode(65 + index); // A-Z
          return _buildLessonCard(
            context,
            letter,
            Colors.primaries[index % Colors.primaries.length],
          );
        },
      ),
    );
  }

  Widget _buildNumbersGrid() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: 20,
        itemBuilder: (context, index) {
          final number = (index + 1).toString();
          return _buildLessonCard(
            context,
            number,
            Colors.primaries[(index + 10) % Colors.primaries.length],
          );
        },
      ),
    );
  }

  Widget _buildLessonCard(BuildContext context, String content, Color color) {
    return InkWell(
      onTap: () {
        _showDetailDialog(context, content);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: color.withOpacity(0.7),
        child: Center(
          child: Text(
            content,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 40,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }

  void _showDetailDialog(BuildContext context, String content) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text(
          content,
          style: const TextStyle(fontSize: 50, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 200,
              child: Lottie.asset(
                'assets/animations/owl_wave.json',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.volume_up),
              label: const Text("Hear Sound"),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("Playing sound for $content"),
                    action: SnackBarAction(
                      label: 'Yay!',
                      onPressed: () {
                        Navigator.pop(context);
                        _showCelebration(context);
                      },
                    ),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
        ],
      ),
    );
  }

  void _showCelebration(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Stack(
          children: [
            Lottie.asset(
              'assets/animations/owl_celebrate.json',
              repeat: false,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Great Job!',
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 20,
              right: 0,
              left: 0,
              child: TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text(
                  'Continue',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizTab extends StatefulWidget {
  const QuizTab({super.key});

  @override
  _QuizTabState createState() => _QuizTabState();
}

class _QuizTabState extends State<QuizTab> {
  final List<String> quizTypes = [
    'Alphabet Recognition',
    'Number Recognition',
    'Matching Quiz',
    'Sequence Quiz'
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Choose a Quiz",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: quizTypes.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: _buildQuizCard(quizTypes[index], index),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuizCard(String title, int index) {
    final List<Color> colors = [
      Colors.red,
      Colors.green,
      Colors.purple,
      Colors.orange
    ];
    final List<IconData> icons = [
      Icons.abc,
      Icons.numbers,
      Icons.compare_arrows,
      Icons.sort
    ];

    return InkWell(
      onTap: () {
        _startQuiz(title);
      },
      child: Card(
        elevation: 5,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              colors: [colors[index], colors[index].withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Icon(
                  icons[index],
                  size: 60,
                  color: Colors.white,
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "Test your knowledge of ${title.toLowerCase()}",
                        style: const TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startQuiz(String quizType) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => QuizScreen(quizType: quizType),
      ),
    );
  }
}

class QuizScreen extends StatefulWidget {
  final String quizType;

  const QuizScreen({super.key, required this.quizType});

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int score = 0;
  bool answered = false;
  late List<Map<String, dynamic>> questions;

  @override
  void initState() {
    super.initState();
    if (widget.quizType == 'Alphabet Recognition') {
      questions = _generateAlphabetQuestions();
    } else if (widget.quizType == 'Number Recognition') {
      questions = _generateNumberQuestions();
    } else if (widget.quizType == 'Matching Quiz') {
      questions = _generateMatchingQuestions();
    } else {
      questions = _generateSequenceQuestions();
    }
  }

  List<Map<String, dynamic>> _generateAlphabetQuestions() {
    return [
      {
        'question': 'What letter is this?',
        'image': 'A',
        'options': ['A', 'B', 'C', 'D'],
        'correctAnswer': 'A',
      },
      {
        'question': 'What letter is this?',
        'image': 'M',
        'options': ['N', 'M', 'W', 'H'],
        'correctAnswer': 'M',
      },
      {
        'question': 'What letter is this?',
        'image': 'Z',
        'options': ['X', 'Y', 'Z', 'W'],
        'correctAnswer': 'Z',
      },
    ];
  }

  List<Map<String, dynamic>> _generateNumberQuestions() {
    return [
      {
        'question': 'What number is this?',
        'image': '5',
        'options': ['2', '3', '5', '7'],
        'correctAnswer': '5',
      },
      {
        'question': 'What number is this?',
        'image': '9',
        'options': ['6', '9', '8', '4'],
        'correctAnswer': '9',
      },
      {
        'question': 'What number is this?',
        'image': '3',
        'options': ['3', '8', '1', '5'],
        'correctAnswer': '3',
      },
    ];
  }

  List<Map<String, dynamic>> _generateMatchingQuestions() {
    return [
      {
        'question': 'How many apples are there?',
        'image': '3 apples',
        'options': ['2', '3', '4', '5'],
        'correctAnswer': '3',
      },
      {
        'question': 'Which letter starts the word "Dog"?',
        'image': 'Dog',
        'options': ['C', 'D', 'B', 'G'],
        'correctAnswer': 'D',
      },
    ];
  }

  List<Map<String, dynamic>> _generateSequenceQuestions() {
    return [
      {
        'question': 'What comes next? A, B, C, ...',
        'image': 'A, B, C, ...',
        'options': ['E', 'D', 'F', 'G'],
        'correctAnswer': 'D',
      },
    ];
  }

  void _checkAnswer(String selectedAnswer) {
    if (answered) return;

    final correctAnswer = questions[currentQuestion]['correctAnswer'];
    final isCorrect = selectedAnswer == correctAnswer;

    if (isCorrect) {
      score++;
    }

    setState(() {
      answered = true;
    });

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        content: Lottie.asset(
          isCorrect
              ? 'assets/animations/owl_celebrate.json'
              : 'assets/animations/owl_sad.json',
          width: 200,
          height: 200,
        ),
      ),
    );

    Future.delayed(const Duration(seconds: 2), () {
      Navigator.pop(context);
      if (currentQuestion < questions.length - 1) {
        setState(() {
          currentQuestion++;
          answered = false;
        });
      } else {
        _showResults();
      }
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Text(
          'Quiz Results',
          style: TextStyle(fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Lottie.asset(
              score >= questions.length / 2
                  ? 'assets/animations/owl_celebrate.json'
                  : 'assets/animations/owl_sad.json',
              width: 150,
              height: 150,
            ),
            const SizedBox(height: 20),
            Text(
              '$score/${questions.length}',
              style: TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
                color:
                    score >= questions.length / 2 ? Colors.green : Colors.red,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              score >= questions.length / 2 ? 'Great job!' : 'Keep practicing!',
              style: const TextStyle(fontSize: 20),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              Navigator.pop(context);
            },
            child: const Text('Done'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                currentQuestion = 0;
                score = 0;
                answered = false;
              });
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.quizType),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (currentQuestion + 1) / questions.length,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                'Question ${currentQuestion + 1}/${questions.length}',
                style: TextStyle(color: Colors.grey[600]),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Text(
                    question['question'],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 20),
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        question['image'],
                        style: const TextStyle(
                          fontSize: 56,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: question['options'].length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () => _checkAnswer(question['options'][index]),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Colors.white,
                      child: Center(
                        child: Text(
                          question['options'][index],
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class LeaderboardTab extends StatelessWidget {
  const LeaderboardTab({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> leaderboardData = [
      {'name': 'Radha', 'score': 950, 'avatar': 'avatar1'},
      {'name': 'Rohit', 'score': 875, 'avatar': 'avatar2'},
      {'name': 'Jasminder', 'score': 820, 'avatar': 'avatar3'},
      {'name': 'Chaitanya', 'score': 780, 'avatar': 'avatar4'},
      {'name': 'Anant', 'score': 760, 'avatar': 'avatar5'},
    ];

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: const BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          child: Column(
            children: [
              const Text(
                'Leaderboard',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTopPlayer(leaderboardData[1], '2'),
                  _buildTopPlayer(leaderboardData[0], '1', isWinner: true),
                  _buildTopPlayer(leaderboardData[2], '3'),
                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: leaderboardData.length - 3,
            itemBuilder: (context, index) {
              final player = leaderboardData[index + 3];
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: ListTile(
                  leading: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${index + 4}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    player['name'],
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: const Text('Learning Champion'),
                  trailing: Text(
                    '${player['score']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: Colors.blue,
                    ),
                  ),
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTopPlayer(Map<String, dynamic> player, String position,
      {bool isWinner = false}) {
    return Column(
      children: [
        Text(
          position,
          style: TextStyle(
            fontSize: isWinner ? 22 : 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 8),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              width: isWinner ? 80 : 60,
              height: isWinner ? 80 : 60,
              decoration: BoxDecoration(
                color: isWinner ? Colors.amber : Colors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: isWinner ? Colors.orange : Colors.grey,
                  width: 2,
                ),
              ),
              child: Center(
                child: Text(
                  player['name'][0],
                  style: TextStyle(
                    fontSize: isWinner ? 28 : 22,
                    fontWeight: FontWeight.bold,
                    color: isWinner ? Colors.white : Colors.blue,
                  ),
                ),
              ),
            ),
            if (isWinner)
              Positioned(
                top: -5,
                child: Icon(
                  Icons.star,
                  color: Colors.amber[700],
                  size: 30,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          player['name'],
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          '${player['score']} pts',
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Lottie.asset(
            'assets/animations/owl_wave.json',
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 20),
          const Text(
            'Anant',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 5),
          const Text(
            'Age: 5 years',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 30),
          _buildProfileCard(
            icon: Icons.star,
            color: Colors.amber,
            title: 'Total Points',
            value: '1,250',
          ),
          _buildProfileCard(
            icon: Icons.quiz,
            color: Colors.green,
            title: 'Quizzes Completed',
            value: '24',
          ),
          _buildProfileCard(
            icon: Icons.emoji_events,
            color: Colors.purple,
            title: 'Badges Earned',
            value: '5',
          ),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            icon: const Icon(Icons.settings),
            label: const Text('Settings'),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 15),
          TextButton(
            onPressed: () {},
            child: const Text(
              'Log Out',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileCard({
    required IconData icon,
    required Color color,
    required String title,
    required String value,
  }) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 50,
              height: 50,
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: color,
                size: 30,
              ),
            ),
            const SizedBox(width: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                  ),
                ),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
