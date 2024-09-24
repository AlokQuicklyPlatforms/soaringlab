import 'package:flutter/material.dart';
import 'package:soaring_lab/main.dart';
import 'package:soaring_lab/src/themes/app_theme.dart';
import 'package:soaring_lab/src/widgets/common_button.dart';

class Instructionpage extends StatefulWidget {
  const Instructionpage({super.key});

  @override
  State<Instructionpage> createState() => _InstructionpageState();
}

class _InstructionpageState extends State<Instructionpage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<EdgeInsets> _paddingAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 700),
      vsync: this,
    );
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );
    _paddingAnimation = Tween<EdgeInsets>(
      begin: const EdgeInsets.only(top: 100.0),
      end: const EdgeInsets.only(top: 5.0),
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.secondaryColor,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CommonButton(
          text: 'Back',
          onPressed: () {
            Navigator.pop(context);
            // Navigator.of(context).pushReplacementNamed('/login');
          },
          backgroundColor: AppTheme.primaryColor,
          textColor: Theme.of(context).colorScheme.onPrimary,
          width: mq.width * 0.47,
          fontSize: mq.width * 0.045,
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppTheme.secondaryColor,
        surfaceTintColor: AppTheme.secondaryColor,
        title: const Text(
          'Practice Test Matches Instructions',
        ),
      ),
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return Opacity(
            opacity: _opacityAnimation.value,
            child: Padding(
              padding: _paddingAnimation.value,
              child: ListView(
                padding: const EdgeInsets.all(16.0),
                children: [
                  _buildSection(
                    context,
                    title: 'Instructions / Scoring Overview',
                    content:
                        'This scoring app is designed to track your launch height, landing accuracy, and flight time. There are two methods available for tracking your flight time:',
                  ),
                  const SizedBox(height: 5),
                  _buildSection(
                    context,
                    title: '1. Traditional Timing Method',
                    content: '''For precise timing:
	•	Use a stopwatch to measure your flight time accurately.
	•	Ensure the flight window is set to zero.
	•	Manually enter your exact flight time in seconds in the "Flight Time" field.''',
                  ),
                  const SizedBox(height: 5),
                  _buildSection(
                    context,
                    title: 'Average Timing Method',
                    content:
                        '''This method offers an alternative when precise timing devices are unavailable. It calculates an average flight time based on the time window in which you land.
Example: If the countdown starts at 10 minutes and you land with 3 minutes remaining, enter "3" in the flight window. The app will automatically calculate your flight time as 7 minutes and 30 seconds.
In cases where multiple participants land within the same time window, additional factors such as landing points and launch height will determine their final scores. Generally, if everyone lands within the last five seconds, the winner is determined by launch height and landing points. Therefore, it's crucial to aim for the last window and achieve a flight time of 9:30 to maximize your score.''',
                  ),
                  const SizedBox(height: 5),
                  _buildSection(
                    context,
                    title: 'After Signing Up',
                    content:
                        '''Once you sign up, you will be directed to the "Start Contest" screen. You have two options:
	•	Create a New Contest: Follow the prompts in the app to set up a new contest. You can then share the contest code with others you want to join.
	•	Join an Existing Contest: Enter the contest code shared by the host to join an ongoing contest.
After joining or creating a contest, start entering your scores as the match progresses.''',
                  ),

                  // _buildSection(
                  //   context,
                  //   title: '1. Sign up:',
                  //   content:
                  //       'After you download scoring, you will have to sign up. After signing in, you will see the start contest screen. You can start a contest by creating a new contest or by entering the contest code that you get shared. Follow the instructions of the app and then play and get your score.',
                  // ),
                  // const SizedBox(height: 5),
                  // _buildSection(
                  //   context,
                  //   title: '2. Traditional Timing Method:',
                  //   content:
                  //       '1. Use a stopwatch to time your flight.\n2. Keep the flight window at zero.\n3. Enter the exact flight time in seconds.',
                  // ),
                  // const SizedBox(height: 5),
                  // _buildSection(
                  //   context,
                  //   title: '2. Average Timing Method:',
                  //   content:
                  //       '1. This method provides an average time when a timer is not available.\n2. The flight window represents the minute in which you land.\n3. For example, if the countdown starts from 10 minutes and you land with 3 minutes remaining, enter "3" in the flight window.\n4. This will automatically set your flight time to 7 minutes and 30 seconds.\n5. If two people land within the same window, both will have a flight time of 7:30. The deciding factors will be their landing points and launch height.',
                  // ),
                  // const SizedBox(height: 5),
                  // _buildSection(
                  //   context,
                  //   title: '4. Your launch height:',
                  //   content: 'Manually put in your launch height.',
                  // ),
                  // const SizedBox(height: 5),
                  // _buildSection(
                  //   context,
                  //   title: '5. Your landings:',
                  //   content: 'Manually put in your landings.',
                  // ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSection(BuildContext context,
      {required String title, required String content}) {
    return Card(
      color: Colors.white,
      elevation: 4.0,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 10),
            Text(
              content,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
