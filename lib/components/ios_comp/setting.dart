import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/month_provider.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

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
                      (monthProvider.iDateChecked)
                          ? monthProvider.dateModel.date
                          : monthProvider.iDate(),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                SizedBox(height: 10,),
                CupertinoButton(
                  color: CupertinoColors.secondarySystemFill,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  onPressed: () {
                    monthProvider.iDateFind(context);
                  },
                  child: const Text(
                    'Change Date',
                    style:
                    TextStyle(color: CupertinoColors.black, fontSize: 23),
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
                    (monthProvider.iTimeChecked)
                        ? monthProvider.timeModel.timeOfDay
                        : monthProvider.iTime(),
                    style: const TextStyle(fontSize: 18),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              CupertinoButton(
                color: CupertinoColors.secondarySystemFill,
                borderRadius: BorderRadius.all(Radius.circular(10)),
                onPressed: () {
                  monthProvider.iTimeFind(context);
                },
                child: const Text(
                  'Change Time',
                  style:
                  TextStyle(color: CupertinoColors.black, fontSize: 23),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
