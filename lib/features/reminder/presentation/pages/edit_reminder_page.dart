import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:coco/core/constants/app_colors.dart';
import 'package:coco/core/router/app_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:coco/features/reminder/domain/entities/reminder_entity.dart';
import 'package:coco/features/reminder/presentation/providers/reminder_providers.dart';

/// Edit Reminder Page
/// Form to edit an existing reminder
class EditReminderPage extends ConsumerStatefulWidget {
  final String reminderId;

  const EditReminderPage({super.key, required this.reminderId});

  @override
  ConsumerState<EditReminderPage> createState() => _EditReminderPageState();
}

class _EditReminderPageState extends ConsumerState<EditReminderPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;

  DateTime? _selectedDateTime;
  ReminderCategory? _selectedCategory;
  ReminderPriority? _selectedPriority;
  ReminderRepeat? _selectedRepeat;
  bool? _notificationEnabled;
  bool _isLoading = false;
  bool _isInitialized = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    _locationController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  void _initializeFields(ReminderEntity reminder) {
    if (_isInitialized) return;

    _titleController.text = reminder.title;
    _descriptionController.text = reminder.description;
    _locationController.text = reminder.location ?? '';
    _selectedDateTime = reminder.dateTime;
    _selectedCategory = reminder.category;
    _selectedPriority = reminder.priority;
    _selectedRepeat = reminder.repeat;
    _notificationEnabled = reminder.isNotificationEnabled;
    _isInitialized = true;
  }

  Future<void> _selectDateTime() async {
    if (_selectedDateTime == null) return;

    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime!,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.deepPurple,
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: AppColors.textPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (date != null && mounted) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime!),
        builder: (context, child) {
          return Theme(
            data: Theme.of(context).copyWith(
              colorScheme: const ColorScheme.light(
                primary: AppColors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: AppColors.textPrimary,
              ),
            ),
            child: child!,
          );
        },
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  Future<void> _updateReminder(ReminderEntity originalReminder) async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    final updatedReminder = originalReminder.copyWith(
      title: _titleController.text.trim(),
      description: _descriptionController.text.trim(),
      dateTime: _selectedDateTime,
      location: _locationController.text.trim().isEmpty
          ? null
          : _locationController.text.trim(),
      category: _selectedCategory,
      priority: _selectedPriority,
      repeat: _selectedRepeat,
      updatedAt: DateTime.now(),
      isNotificationEnabled: _notificationEnabled,
    );

    await ref
        .read(reminderNotifierProvider.notifier)
        .updateReminder(updatedReminder);

    if (mounted) {
      setState(() => _isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '✨ Reminder updated successfully!',
            style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
          ),
          backgroundColor: AppColors.success,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      AppRouter.goBack(context);
    }
  }

  Future<void> _deleteReminder() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Reminder?',
          style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        ),
        content: Text(
          'Are you sure you want to delete this reminder? This action cannot be undone.',
          style: GoogleFonts.nunito(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('Cancel', style: GoogleFonts.nunito()),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: Text('Delete', style: GoogleFonts.nunito()),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      setState(() => _isLoading = true);
      await ref
          .read(reminderNotifierProvider.notifier)
          .deleteReminder(widget.reminderId);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Reminder deleted successfully',
              style: GoogleFonts.nunito(fontWeight: FontWeight.w600),
            ),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        );
        AppRouter.goBack(context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final reminderAsync = ref.watch(reminderByIdProvider(widget.reminderId));

    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: Text(
          'Edit Reminder',
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: AppColors.textPrimary,
          ),
          onPressed: () => AppRouter.goBack(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete_rounded, color: AppColors.error),
            onPressed: _deleteReminder,
          ),
        ],
      ),
      body: reminderAsync.when(
        data: (reminder) {
          if (reminder == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 80,
                    color: AppColors.error,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Reminder not found',
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            );
          }

          _initializeFields(reminder);

          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                _buildTitleField(),
                const SizedBox(height: 16),
                _buildDescriptionField(),
                const SizedBox(height: 16),
                _buildDateTimeSelector(),
                const SizedBox(height: 16),
                _buildLocationField(),
                const SizedBox(height: 16),
                _buildCategorySelector(),
                const SizedBox(height: 16),
                _buildPrioritySelector(),
                const SizedBox(height: 16),
                _buildRepeatSelector(),
                const SizedBox(height: 16),
                _buildNotificationToggle(),
                const SizedBox(height: 32),
                _buildUpdateButton(reminder),
                const SizedBox(height: 20),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_outline, size: 80, color: AppColors.error),
              const SizedBox(height: 16),
              Text(
                'Error loading reminder',
                style: GoogleFonts.poppins(fontSize: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTitleField() {
    return TextFormField(
      controller: _titleController,
      decoration: InputDecoration(
        labelText: 'Title',
        hintText: 'Enter reminder title',
        prefixIcon: const Icon(
          Icons.title_rounded,
          color: AppColors.deepPurple,
        ),
      ),
      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return 'Please enter a title';
        }
        return null;
      },
    );
  }

  Widget _buildDescriptionField() {
    return TextFormField(
      controller: _descriptionController,
      decoration: InputDecoration(
        labelText: 'Description',
        hintText: 'Enter description (optional)',
        prefixIcon: const Icon(
          Icons.description_rounded,
          color: AppColors.deepPurple,
        ),
        alignLabelWithHint: true,
      ),
      maxLines: 3,
    );
  }

  Widget _buildDateTimeSelector() {
    return InkWell(
      onTap: _selectDateTime,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.divider),
        ),
        child: Row(
          children: [
            const Icon(
              Icons.calendar_today_rounded,
              color: AppColors.deepPurple,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Date & Time',
                    style: GoogleFonts.nunito(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  if (_selectedDateTime != null)
                    Text(
                      '${_selectedDateTime!.day}/${_selectedDateTime!.month}/${_selectedDateTime!.year} • ${_selectedDateTime!.hour.toString().padLeft(2, '0')}:${_selectedDateTime!.minute.toString().padLeft(2, '0')}',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimary,
                      ),
                    ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: AppColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLocationField() {
    return TextFormField(
      controller: _locationController,
      decoration: InputDecoration(
        labelText: 'Location',
        hintText: 'Enter location (optional)',
        prefixIcon: const Icon(
          Icons.location_on_rounded,
          color: AppColors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildCategorySelector() {
    if (_selectedCategory == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Category',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ReminderCategory.values.map((category) {
            final isSelected = _selectedCategory == category;
            return ChoiceChip(
              label: Text(category.displayName),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedCategory = category);
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.deepPurple.withOpacity(0.2),
              labelStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.deepPurple
                    : AppColors.textSecondary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPrioritySelector() {
    if (_selectedPriority == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Priority',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ReminderPriority.values.map((priority) {
            final isSelected = _selectedPriority == priority;
            Color priorityColor = AppColors.priorityMedium;
            if (priority == ReminderPriority.high) {
              priorityColor = AppColors.priorityHigh;
            }
            if (priority == ReminderPriority.low) {
              priorityColor = AppColors.priorityLow;
            }

            return ChoiceChip(
              label: Text(priority.displayName),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedPriority = priority);
              },
              backgroundColor: Colors.white,
              selectedColor: priorityColor.withOpacity(0.2),
              labelStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: isSelected ? priorityColor : AppColors.textSecondary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildRepeatSelector() {
    if (_selectedRepeat == null) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Repeat',
          style: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: ReminderRepeat.values.map((repeat) {
            final isSelected = _selectedRepeat == repeat;
            return ChoiceChip(
              label: Text(repeat.displayName),
              selected: isSelected,
              onSelected: (selected) {
                setState(() => _selectedRepeat = repeat);
              },
              backgroundColor: Colors.white,
              selectedColor: AppColors.pastelTurquoise.withOpacity(0.3),
              labelStyle: GoogleFonts.nunito(
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? AppColors.deepPurple
                    : AppColors.textSecondary,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildNotificationToggle() {
    if (_notificationEnabled == null) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.notifications_active_rounded,
            color: AppColors.deepPurple,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Enable Notification',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  'Get notified when reminder is due',
                  style: GoogleFonts.nunito(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: _notificationEnabled!,
            onChanged: (value) {
              setState(() => _notificationEnabled = value);
            },
            activeColor: AppColors.deepPurple,
          ),
        ],
      ),
    );
  }

  Widget _buildUpdateButton(ReminderEntity reminder) {
    return ElevatedButton(
      onPressed: _isLoading ? null : () => _updateReminder(reminder),
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.deepPurple,
        padding: const EdgeInsets.symmetric(vertical: 18),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: _isLoading
          ? const SizedBox(
              height: 20,
              width: 20,
              child: CircularProgressIndicator(
                color: Colors.white,
                strokeWidth: 2,
              ),
            )
          : Text(
              'Update Reminder',
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
    );
  }
}
