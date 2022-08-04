import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:posts_app_with_test/posts/Ui/view/posts_page.dart';

import '../../helpers/helpers.dart';

void main(){
  group('post page test', () {
    testWidgets('appbar title text test', (widgetTester) async{
      await widgetTester.pumpApp(const PostsPage());
      await widgetTester.pumpAndSettle();
      expect(find.text('Posts'), findsOneWidget);
    });

    testWidgets('appbar title text test', (widgetTester) async{
      await widgetTester.pumpApp(const PostsPage());
      await widgetTester.pump(const Duration(milliseconds: 100));
      expect(find.byWidget(const CircularProgressIndicator()), findsOneWidget);
    });
    
  });
}

