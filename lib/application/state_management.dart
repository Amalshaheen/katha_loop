import 'package:flutter/material.dart';
import 'package:katha_loop/models/history.dart';

final ValueNotifier<List<HistoryModel>> currentChat = ValueNotifier([]);
final ValueNotifier<List<List<HistoryModel>>> chatHistory = ValueNotifier([]);
