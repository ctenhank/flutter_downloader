import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

class DownloadTaskListPage extends StatefulWidget {
  const DownloadTaskListPage({super.key});

  @override
  State<DownloadTaskListPage> createState() => _DownloadTaskListPageState();
}

class _DownloadTaskListPageState extends State<DownloadTaskListPage> {
  final List<DownloadTask> tasks = [];

  _init() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      tasks.clear();
      tasks.addAll((await FlutterDownloader.loadTasks()) ?? []);
      setState(() {});
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Download Task List Page"),
        actions: [TextButton(onPressed: _init, child: Text("Refresh"))],
      ),
      body: tasks.isEmpty
          ? Center(
              child: Text("No items"),
            )
          : ListView.separated(
              itemBuilder: (_, index) {
                return Text(tasks[index].toString());
              },
              separatorBuilder: (_, __) => const SizedBox(height: 8),
              itemCount: tasks.length,
            ),
    );
  }
}
