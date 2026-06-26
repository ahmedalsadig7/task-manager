import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/error_handler.dart';
import '../../models/task_model.dart';
import '../../view_models/tasks_providers.dart';

class AddTaskBottomSheet extends ConsumerStatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  ConsumerState<AddTaskBottomSheet> createState() =>
      _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends ConsumerState<AddTaskBottomSheet> {
  final _titleCtrl = TextEditingController();
  TaskPriority _priority = TaskPriority.medium;
  bool _isLoading = false;

  @override
  void dispose() {
    _titleCtrl.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final title = _titleCtrl.text.trim();
    if (title.isEmpty) return;

    setState(() => _isLoading = true);
    try {
      await ref
          .read(tasksNotifierProvider.notifier)
          .addTask(title, _priority);
      if (mounted) Navigator.of(context).pop();
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(formatError(e)), backgroundColor: Colors.red),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        24,
        24,
        24,
        MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Add New Task', style: theme.textTheme.titleLarge),
          const SizedBox(height: 16),
          TextField(
            controller: _titleCtrl,
            autofocus: true,
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submit(),
            decoration: const InputDecoration(
              labelText: 'Task title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          Text('Priority', style: theme.textTheme.labelLarge),
          const SizedBox(height: 8),
          SegmentedButton<TaskPriority>(
            segments: const [
              ButtonSegment(
                value: TaskPriority.low,
                label: Text('Low'),
                icon: Icon(Icons.arrow_downward, size: 16),
              ),
              ButtonSegment(
                value: TaskPriority.medium,
                label: Text('Medium'),
                icon: Icon(Icons.remove, size: 16),
              ),
              ButtonSegment(
                value: TaskPriority.high,
                label: Text('High'),
                icon: Icon(Icons.arrow_upward, size: 16),
              ),
            ],
            selected: {_priority},
            onSelectionChanged: (s) => setState(() => _priority = s.first),
          ),
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _isLoading ? null : _submit,
            child: _isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Add Task'),
          ),
        ],
      ),
    );
  }
}
