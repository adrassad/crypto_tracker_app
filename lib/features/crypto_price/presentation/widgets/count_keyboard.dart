import 'package:flutter/material.dart';

class CountKeyboard extends StatelessWidget {
  final void Function(String) onTextInput;
  final VoidCallback onBackspace;
  final VoidCallback onDone;

  const CountKeyboard({
    super.key,
    required this.onTextInput,
    required this.onBackspace,
    required this.onDone,
  });

  void _textInputHandler(String text) => onTextInput(text);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      color: Colors.grey[100],
      child: Column(
        children: [
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              childAspectRatio: 2,
              children: [
                for (var i = 1; i <= 9; i++)
                  _KeyboardButton(
                    label: '$i',
                    onTap: () => _textInputHandler('$i'),
                  ),
                _KeyboardButton(
                  label: '0',
                  onTap: () => _textInputHandler('0'),
                ),
                _KeyboardButton(
                  label: '.',
                  onTap: () => _textInputHandler('.'),
                ),

                _KeyboardButton(icon: Icons.backspace, onTap: onBackspace),
              ],
            ),
          ),
          SafeArea(
            child: SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: onDone,
                style: TextButton.styleFrom(
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text("Готово", style: TextStyle(fontSize: 18)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _KeyboardButton extends StatelessWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onTap;

  const _KeyboardButton({this.label, this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Center(
        child:
            icon != null
                ? Icon(icon, size: 26)
                : Text(label!, style: const TextStyle(fontSize: 22)),
      ),
    );
  }
}
