
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../../config/api_keys.dart';
import '../../services/user_service.dart';

class ChatbotScreen extends StatefulWidget {
  const ChatbotScreen({super.key});

  @override
  State<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends State<ChatbotScreen> {
  final TextEditingController _messageController =
      TextEditingController();
  final ScrollController _scrollController = ScrollController();

  List<ChatMessage> _messages = [];
  bool _isTyping = false;

  @override
  void initState() {
    super.initState();
    _initializeChat();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _initializeChat() {
    setState(() {
      _messages = [
        ChatMessage(
          text: "Hello! I'm your AI diabetes assistant.\n\n"
              "I can create personalized meal plans, exercise routines, "
              "and sleep schedules based on your profile and glucose readings.",
          isUser: false,
          timestamp: DateTime.now(),
        ),
        ChatMessage.quickOptions([
          'Generate Meal Plan',
          'Generate Exercise Plan',
          'Generate Sleep Plan',
          'General Health Tips',
        ]),
      ];
    });
  }

  void _sendMessage(String text) {
    if (text.trim().isEmpty) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    final lowerText = text.toLowerCase();

    if (lowerText.contains('meal plan') ||
        lowerText.contains('diet') ||
        lowerText.contains('generate meal')) {
      _generateMealPlan();
      return;
    }

    if (lowerText.contains('exercise') ||
        lowerText.contains('workout') ||
        lowerText.contains('generate exercise')) {
      _generateExercisePlan();
      return;
    }

    if (lowerText.contains('sleep') ||
        lowerText.contains('generate sleep')) {
      _generateSleepPlan();
      return;
    }

    _sendToGroq();
  }

  Future<void> _generateMealPlan() async {
    final userService = Provider.of<UserService>(
      context,
      listen: false,
    );

    final profile = userService.userProfile;
    final readings = userService.sugarReadings;

    if (profile == null || profile.isEmpty) {
      _addAssistantMessage(
        'Unable to generate a meal plan. Please complete your profile first.',
      );
      return;
    }

    if (readings.isEmpty) {
      _addAssistantMessage(
        'No glucose readings found. Please add a glucose reading first.',
      );
      return;
    }

    final prompt = _buildMealPlanPrompt(profile, readings);

    setState(() {
      _messages.add(
        ChatMessage(
          text: prompt,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    await _sendToGroq();
  }

  Future<void> _generateExercisePlan() async {
    final userService = Provider.of<UserService>(
      context,
      listen: false,
    );

    final profile = userService.userProfile;
    final readings = userService.sugarReadings;

    if (profile == null || profile.isEmpty) {
      _addAssistantMessage(
        'Unable to generate an exercise plan. Please complete your profile first.',
      );
      return;
    }

    if (readings.isEmpty) {
      _addAssistantMessage(
        'No glucose readings found. Please add glucose readings first.',
      );
      return;
    }

    final prompt = _buildExercisePlanPrompt(profile, readings);

    setState(() {
      _messages.add(
        ChatMessage(
          text: prompt,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    await _sendToGroq();
  }

  Future<void> _generateSleepPlan() async {
    final userService = Provider.of<UserService>(
      context,
      listen: false,
    );

    final profile = userService.userProfile;
    final readings = userService.sugarReadings;

    if (profile == null || profile.isEmpty) {
      _addAssistantMessage(
        'Unable to generate a sleep plan. Please complete your profile first.',
      );
      return;
    }

    if (readings.isEmpty) {
      _addAssistantMessage(
        'No glucose readings found. Please add glucose readings first.',
      );
      return;
    }

    final prompt = _buildSleepPlanPrompt(profile, readings);

    setState(() {
      _messages.add(
        ChatMessage(
          text: prompt,
          isUser: true,
          timestamp: DateTime.now(),
        ),
      );
    });

    await _sendToGroq();
  }

  void _addAssistantMessage(String text) {
    if (!mounted) return;

    setState(() {
      _messages.add(
        ChatMessage(
          text: text,
          isUser: false,
          timestamp: DateTime.now(),
        ),
      );
      _isTyping = false;
    });

    _scrollToBottom();
  }

  String _buildMealPlanPrompt(
    Map<String, dynamic> profile,
    List<Map<String, dynamic>> readings,
  ) {
    final age = profile['age'] ?? 'unknown';
    final gender = profile['gender'] ?? 'unknown';
    final weight = profile['weight'] ?? 'unknown';
    final healthHistory =
        profile['healthHistory'] ?? 'No history provided';

    final values = readings
        .take(3)
        .map((r) => (r['reading'] as num).toDouble())
        .toList();

    final average = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a + b) / values.length;

    return '''Create a cautious, personalized diabetes meal plan.

Age: $age
Gender: $gender
Weight: $weight kg
Health history: $healthHistory
Average of recent glucose readings: ${average.toStringAsFixed(1)} mg/dL

Include breakfast, lunch, dinner, two snacks, suggested portions, estimated calories, carbohydrates, meal timing, hydration, and general blood-glucose management tips.

Do not diagnose or recommend medication changes. Explain that this plan is informational and should be reviewed with a qualified healthcare professional.''';
  }

  String _buildExercisePlanPrompt(
    Map<String, dynamic> profile,
    List<Map<String, dynamic>> readings,
  ) {
    final age = profile['age'] ?? 'unknown';
    final gender = profile['gender'] ?? 'unknown';
    final weight = profile['weight'] ?? 'unknown';
    final healthHistory =
        profile['healthHistory'] ?? 'No history provided';

    final values = readings
        .take(3)
        .map((r) => (r['reading'] as num).toDouble())
        .toList();

    final average = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a + b) / values.length;

    return '''Suggest a cautious exercise routine for a person managing diabetes.

Age: $age
Gender: $gender
Weight: $weight kg
Health history: $healthHistory
Average of recent glucose readings: ${average.toStringAsFixed(1)} mg/dL

Include a weekly activity schedule, low-impact options, warm-ups, cool-downs, rest days, and general glucose-monitoring precautions.

Do not assume glucose readings alone establish exercise safety. Recommend professional advice, especially for people using insulin or glucose-lowering medication.''';
  }

  String _buildSleepPlanPrompt(
    Map<String, dynamic> profile,
    List<Map<String, dynamic>> readings,
  ) {
    final age = profile['age'] ?? 'unknown';
    final gender = profile['gender'] ?? 'unknown';
    final healthHistory =
        profile['healthHistory'] ?? 'No history provided';

    final values = readings
        .take(3)
        .map((r) => (r['reading'] as num).toDouble())
        .toList();

    final average = values.isEmpty
        ? 0.0
        : values.reduce((a, b) => a + b) / values.length;

    return '''Suggest a practical sleep-improvement plan for a person managing diabetes.

Age: $age
Gender: $gender
Health history: $healthHistory
Average of recent glucose readings: ${average.toStringAsFixed(1)} mg/dL

Include a sleep schedule, bedtime routine, sleep hygiene, stress management, and general information about the relationship between sleep and glucose.

Do not diagnose or recommend medication changes. Encourage professional advice for overnight glucose concerns.''';
  }

  Future<void> _sendToGroq() async {
    final apiKey = ApiKeysWeb.groq;

    if (apiKey.isEmpty) {
      _addAssistantMessage(
        'AI assistant configuration is missing. '
        'Configure GROQ_API_KEY before running the app.',
      );
      return;
    }

    try {
      final recentMessages = _messages
          .where((m) => !m.isQuickOptions && m.text.isNotEmpty)
          .toList();

      final history = recentMessages.length > 10
          ? recentMessages.sublist(recentMessages.length - 10)
          : recentMessages;

      final messages = history.map((m) {
        return {
          'role': m.isUser ? 'user' : 'assistant',
          'content': m.text,
        };
      }).toList();

      final body = {
        'model': 'llama-3.1-8b-instant',
        'messages': [
          {
            'role': 'system',
            'content':
                'You are a cautious diabetes information assistant. '
                    'Give concise general information about diet, exercise, '
                    'sleep, glucose monitoring, and healthy habits. '
                    'Do not diagnose, prescribe, or recommend medication '
                    'changes. Encourage professional care for individual '
                    'medical decisions.',
          },
          ...messages,
        ],
        'temperature': 0.7,
        'max_tokens': 1200,
      };

      final response = await http.post(
        Uri.parse(
          'https://api.groq.com/openai/v1/chat/completions',
        ),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $apiKey',
        },
        body: jsonEncode(body),
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final result =
            data['choices']?[0]?['message']?['content'];

        _addAssistantMessage(
          result is String && result.isNotEmpty
              ? result
              : 'I received an empty response. Please try again.',
        );
      } else {
        String errorMessage = 'Unknown error';

        try {
          final data = jsonDecode(response.body);
          errorMessage =
              data['error']?['message'] ?? errorMessage;
        } catch (_) {}

        _addAssistantMessage(
          'The AI request failed (${response.statusCode}). '
          '$errorMessage',
        );
      }
    } catch (e) {
      if (!mounted) return;

      _addAssistantMessage(
        'Something went wrong while contacting the AI service. '
        'Please try again.',
      );
    }
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!_scrollController.hasClients) return;

      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.all(16),
              itemCount:
                  _messages.length + (_isTyping ? 1 : 0),
              itemBuilder: (context, index) {
                if (index == _messages.length && _isTyping) {
                  return _buildTypingIndicator();
                }

                final message = _messages[index];

                if (message.isQuickOptions) {
                  return _buildQuickOptions(message.options!);
                }

                return _buildMessageBubble(message);
              },
            ),
          ),
          _buildInputArea(),
        ],
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: const EdgeInsets.all(16),
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _messageController,
              decoration: const InputDecoration(
                hintText: 'Type a message...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(30),
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 10,
                ),
              ),
              onSubmitted: _sendMessage,
            ),
          ),
          const SizedBox(width: 8),
          CircleAvatar(
            backgroundColor: Colors.blue,
            child: IconButton(
              icon: const Icon(
                Icons.send,
                color: Colors.white,
              ),
              onPressed: () =>
                  _sendMessage(_messageController.text),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickOptions(List<String> options) {
    return Wrap(
      spacing: 8,
      children: options.map((option) {
        return ActionChip(
          label: Text(option),
          onPressed: () => _sendMessage(option),
        );
      }).toList(),
    );
  }

  Widget _buildMessageBubble(ChatMessage message) {
    if (message.text.contains('Create a cautious') ||
        message.text.contains('Suggest a cautious') ||
        message.text.contains('Suggest a practical')) {
      return const SizedBox.shrink();
    }

    return Align(
      alignment: message.isUser
          ? Alignment.centerRight
          : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        decoration: BoxDecoration(
          color: message.isUser ? Colors.blue : Colors.grey[200],
          borderRadius: BorderRadius.circular(12),
        ),
        child: message.isUser
            ? Text(
                message.text,
                style: const TextStyle(color: Colors.white),
              )
            : MarkdownBody(data: message.text),
      ),
    );
  }

  Widget _buildTypingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(16),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          'Thinking...',
          style: TextStyle(color: Colors.grey),
        ),
      ),
    );
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;
  final bool isQuickOptions;
  final List<String>? options;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
    this.isQuickOptions = false,
    this.options,
  });

  ChatMessage.quickOptions(List<String> opts)
      : text = '',
        isUser = false,
        timestamp = DateTime.now(),
        isQuickOptions = true,
        options = opts;
}
