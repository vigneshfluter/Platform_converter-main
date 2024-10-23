import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../providers/month_provider.dart';

class Settings extends StatelessWidget {
  const Settings({super.key});

  @override
  Widget build(BuildContext context) {
    var monthProvider = Provider.of<MonthProvider>(context);
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 30),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Date',
                      style: TextStyle(fontSize: 18),
                    ),
                    const Spacer(),
                    Text(
                      (monthProvider.dateChecked)
                          ? monthProvider.dateModel.date
                          : monthProvider.dateFind(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                FilledButton(
                  onPressed: () {
                    monthProvider.dateFind1(context);
                  },
                  child: const Text(
                    'Change Date',
                    style: TextStyle( fontSize: 25),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Row(
                children: [
                  const Text(
                    'Time',
                    style: TextStyle(fontSize: 18),
                  ),
                  const Spacer(),
                  Text(
                    (monthProvider.timeChecked)
                        ? monthProvider.timeModel.timeOfDay
                        : monthProvider.timeFind(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              FilledButton(
                onPressed: () async {
                  monthProvider.timeFind1(context);
                },
                child: const Text(
                  'Change Time',
                  style: TextStyle( fontSize: 25),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
