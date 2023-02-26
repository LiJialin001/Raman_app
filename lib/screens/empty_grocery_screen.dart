import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/models.dart';

class EmptyGroceryScreen extends StatelessWidget {
  const EmptyGroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(
              child: AspectRatio(
                aspectRatio: 1 / 1,
                child: Image.asset('assets/img/empty_list.png'),
              ),
            ),
            Text(
              '暂无记录',
              style: Theme.of(context).textTheme.headline6,
            ),
            const SizedBox(height: 16.0),
            const Text(
              '还没有检测记录\n'
              '按下加号可以手动添加信息！',
              textAlign: TextAlign.center,
            ),
            MaterialButton(
              textColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0),
              ),
              color: Colors.green,
              onPressed: () {
                context.goNamed(
                  'home',
                  params: {
                    'tab': '${RamanAppTab.explore}',
                  },
                );
              },
              child: const Text('去检测'),
            ),
          ],
        ),
      ),
    );
  }
}
