
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_workout_manager/presentation/controller/event_state_notifier.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CountPage extends HookConsumerWidget {
  const CountPage({Key? key, required this.data}) : super(key: key);
  final User data;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventStateNotifier = ref.watch(eventStateNotifierProvider.notifier);
    var weeklyEventCount = useState(0);
    var monthlyEventCount = useState(0);
    var yearlyEventCount = useState(0);
    var isWeeklyLoading = useState(false);
    var isMonthlyLoading = useState(false);
    var isYearlyLoading = useState(false);

    void fetchWeeklyData() async {
      // get weekly event count
      var eventWeeklyDays =  await eventStateNotifier.checkWeeklyEventCount(data.uid, 'weekly');
      weeklyEventCount.value =  eventWeeklyDays;
      isWeeklyLoading.value = true;
    }

    void fetchMonthlyData() async {
      // get monthly event count
      var eventMonthlyDays =  await eventStateNotifier.checkWeeklyEventCount(data.uid, 'monthly');
      monthlyEventCount.value =  eventMonthlyDays;
      isMonthlyLoading.value = true;
    }

    void fetchYearlyData() async {
      // get yearly event count
      var eventYearlyDays =  await eventStateNotifier.checkWeeklyEventCount(data.uid, 'yearly');
      yearlyEventCount.value =  eventYearlyDays;
      isYearlyLoading.value = true;
    }

    useEffect(() {
      fetchWeeklyData();
      fetchMonthlyData();
      fetchYearlyData();
      return () {};
    }, const []);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for(int i = 0; i < 3; i++)
          InkWell(
            onTap: ()  async {
            },
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: const Offset(0, 3),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Center(
                    child: weeklyEventCount.value == 0 && i == 0 ? const Text("No Fitness Dates") :
                    monthlyEventCount.value == 0 && i == 1 ? const Text("No Fitness Dates") :
                    yearlyEventCount.value == 0 && i == 2 ? const Text("No Fitness Dates") :
                    Text(
                        i == 0 ? "This Week's Fitness Dates:  ${weeklyEventCount.value}" :
                        i == 1 ? "This Month's Fitness Dates:  ${monthlyEventCount.value}" :
                        i == 2 ? "This Year's Fitness Dates:  ${yearlyEventCount.value}" :
                        "This Week's Fitness Dates",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                    ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
