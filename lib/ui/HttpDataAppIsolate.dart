import 'dart:isolate';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';

/// 这里的 dataLoader() 就是运行在自己独立执行线程内的 Isolate。在 Isolate 中你可以执行更多的 CPU 密集型操作（例如解析一个大的 JSON 数据），
/// 或者执行计算密集型的数学运算，例如加密或信号处理。
/// 这就是你一般应该如何执行网络和数据库操作，它们都属于 I/O 操作。
///
///如何将任务转移到后台线程？
/// 在 Android 中，当你想要访问一个网络资源却又不想阻塞主线程并避免 ANR 的时候，你一般会将任务放到一个后台线程中运行。例如，你可以使用一个 AsyncTask、一个 LiveData、一个 IntentService、一个 JobScheduler 任务或者通过 RxJava 的管道用调度器将任务切换到后台线程中。
///
/// 由于 Flutter 是单线程并且运行一个事件循环（类似 Node.js），你无须担心线程的管理以及后台线程的创建。如果你在执行和 I/O 绑定的任务，例如存储访问或者网络请求，那么你可以安全地使用 async/await，并无后顾之忧。再例如，你需要执行消耗 CPU 的计算密集型工作，那么你可以将其转移到一个 Isolate 上以避免阻塞事件循环，就像你在 Android 中会将任何任务放到主线程之外一样。
///
/// 对于和 I/O 绑定的任务，将方法声明为 async 方法，并在方法内 await 一个长时间运行的任务：

// /在 Android 中，当你继承 AsyncTask 的时候，你一般会覆写三个方法： onPreExecute()、doInBackground() 和 onPostExecute()。 Flutter 中没有对应的 API，你只需要 await 一个耗时方法调用， Dart 的事件循环就会帮你处理剩下的事情。
///
/// 然而，有时候你可能需要处理大量的数据并挂起你的 UI。在 Flutter 中，可以通过使用 Isolate 来利用多核处理器的优势执行耗时或计算密集的任务。
///
/// Isolate 是独立执行的线程，不会和主执行内存堆分享内存。这意味着你无法访问主线程的变量，或者调用 setState() 更新 UI。不同于 Android 中的线程，Isolate 如其名所示，它们无法分享内存（例如通过静态变量的形式）。
//
// 下面的例子展示了一个简单的 Isolate 是如何将数据分享给主线程来更新 UI 的。
class HttpDataAppIsolate extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
      return MaterialApp(
        title: "网络数据异步获取",
        theme: ThemeData(primarySwatch: Colors.blue),
        home: HttpDataPage(),
      );
  }

}

class HttpDataPage extends StatefulWidget{
  const HttpDataPage({Key? key}):super(key: key);
  @override
  State<StatefulWidget> createState() => _HttpDataPageState();

}

class _HttpDataPageState extends State<HttpDataPage> with WidgetsBindingObserver{
  List widgets = [];
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addObserver(this);
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('网络数据异步获取'),
      ),
      body: getBody()
    );
  }

  Widget getBody(){
    bool showLoadingDialog = widgets.isEmpty;
    if(showLoadingDialog){
      return  getProgressDialog();
    } else {
      return getListView();
    }
  }

  Widget getProgressDialog(){
    return const Center(child: CircularProgressIndicator());
  }

  Widget getListView(){
    return ListView.builder(
        itemCount: widgets.length,
        itemBuilder: (BuildContext context, int position) {
          return getRow(position);
        });
  }



    Widget getRow(int i){
      return Padding(padding: EdgeInsets.all(10.0),
      child: Text("Row ${widgets[i]["title"]}"),
      );
    }

    Future<void> loadData() async {

      ReceivePort receivePort = ReceivePort();
      await Isolate.spawn(dataLoader, receivePort.sendPort);

      SendPort sendPort = await receivePort.first;
      List msg = await sendReceive(
        sendPort,
        'https://jsonplaceholder.typicode.com/posts'
      );

      setState(() {
        widgets = msg;

      });
    }

    static Future<void> dataLoader(SendPort sendPort) async{
        // Open the ReceivePort for incoming messages.
         ReceivePort port= ReceivePort();

         // Notify any other isolates what port this isolate listens to.
         sendPort.send(port.sendPort);

         await for(var msg in port){
           String data = msg[0];
           SendPort replyTo = msg[1];

           String dataUrl = data;
           http.Response response = await http.get(dataUrl);
           replyTo.send(jsonDecode(response.body));
         }
    }

    Future sendReceive(SendPort port,msg){
        ReceivePort response = ReceivePort();
        port.send([msg,response.sendPort]);
        return response.first;
    }
  }

