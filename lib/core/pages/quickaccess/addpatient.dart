import 'package:flutter/material.dart';
import 'package:oncoguide_frontend/core/utils/common_app_bar.dart';
import 'package:oncoguide_frontend/core/widgets/feilds/medical_slide_picer.dart';
import '../../conts/colors.dart';
import '../../widgets/Sectiontitle.dart';
import '../../widgets/app_text_feild.dart';
import '../../widgets/buttons/animated_buttons.dart';
import '../../widgets/step_indicator.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  // Controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController allergiesController = TextEditingController();
  final TextEditingController medicalHistoryController =
      TextEditingController();
  final TextEditingController medicationsController = TextEditingController();
  final TextEditingController commentsController = TextEditingController();

  // Stepper & Page
  int currentStep = 0;
  late PageController _pageController;

  // Number Picker values
  int age = 30;
  int weight = 60;
  int menarcheAge = 12;
  int menopauseAge = 50;
  int firstChildAge = 25;
  int numberOfChildren = 0;
  int breastfeedingMonths = 0;

  // Dropdown / segmented
  String gender = 'Female';

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    [
      nameController,
      allergiesController,
      medicalHistoryController,
      medicationsController,
      commentsController
    ].forEach((c) => c.dispose());
    _pageController.dispose();
    super.dispose();
  }

  void nextStep() {
    if (currentStep < 2) {
      setState(() => currentStep++);
      _pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
      _pageController.previousPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  void savePatient() {
    // You can replace this with actual save logic
    debugPrint('Patient data saved');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CommonTopBar(title: 'Add Patient'),
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: StepIndicator(currentStep: currentStep),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                _BasicInfoStep(
                  nameController: nameController,
                  age: age,
                  onAgeChanged: (val) => setState(() => age = val),
                  weight: weight,
                  onWeightChanged: (val) => setState(() => weight = val),
                  gender: gender,
                  onGenderChanged: (val) => setState(() => gender = val),
                ),
                _CancerInfoStep(
                  menarcheAge: menarcheAge,
                  onMenarcheChanged: (val) => setState(() => menarcheAge = val),
                  menopauseAge: menopauseAge,
                  onMenopauseChanged: (val) =>
                      setState(() => menopauseAge = val),
                  firstChildAge: firstChildAge,
                  onFirstChildChanged: (val) =>
                      setState(() => firstChildAge = val),
                  numberOfChildren: numberOfChildren,
                  onChildrenChanged: (val) =>
                      setState(() => numberOfChildren = val),
                  breastfeedingMonths: breastfeedingMonths,
                  onBreastfeedingChanged: (val) =>
                      setState(() => breastfeedingMonths = val),
                ),
                _MedicalInfoStep(
                  allergiesController: allergiesController,
                  medicalHistoryController: medicalHistoryController,
                  medicationsController: medicationsController,
                  commentsController: commentsController,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (currentStep > 0)
                  AnimatedButton(
                    text: 'Back',
                    onPressed: previousStep,
                    isPrimary: false,
                  ),
                AnimatedButton(
                  text: currentStep == 2 ? 'Save' : 'Next',
                  onPressed: currentStep == 2 ? savePatient : nextStep,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -------------------- Step Widgets -------------------- //

class _BasicInfoStep extends StatelessWidget {
  final TextEditingController nameController;
  final int age;
  final ValueChanged<int> onAgeChanged;
  final int weight;
  final ValueChanged<int> onWeightChanged;
  final String gender;
  final ValueChanged<String> onGenderChanged;

  const _BasicInfoStep({
    required this.nameController,
    required this.age,
    required this.onAgeChanged,
    required this.weight,
    required this.onWeightChanged,
    required this.gender,
    required this.onGenderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Basic Information'),

          AppTextField(
            controller: nameController,
            hintText: 'Patient full name',
          ),
          const SizedBox(height: 20),

          // Gender Selector
          Text('Gender', style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 10),
          Row(
            children: ['Male', 'Female', 'Other'].map((g) {
              final isSelected = g == gender;
              return Expanded(
                child: GestureDetector(
                  onTap: () => onGenderChanged(g),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.primary : Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: AppColors.primary),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      g,
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: isSelected ? Colors.white : AppColors.primary,
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),

          const SizedBox(height: 24),

          MedicalSliderField(
            title: 'Age',
            unit: 'yrs',
            value: age,
            min: 0,
            max: 100,
            onChanged: onAgeChanged,
          ),

          MedicalSliderField(
            title: 'Weight',
            unit: 'kg',
            value: weight,
            min: 30,
            max: 180,
            onChanged: onWeightChanged,
          ),
        ],
      ),
    );
  }
}

class _CancerInfoStep extends StatelessWidget {
  final int menarcheAge;
  final ValueChanged<int> onMenarcheChanged;
  final int menopauseAge;
  final ValueChanged<int> onMenopauseChanged;
  final int firstChildAge;
  final ValueChanged<int> onFirstChildChanged;
  final int numberOfChildren;
  final ValueChanged<int> onChildrenChanged;
  final int breastfeedingMonths;
  final ValueChanged<int> onBreastfeedingChanged;

  const _CancerInfoStep({
    required this.menarcheAge,
    required this.onMenarcheChanged,
    required this.menopauseAge,
    required this.onMenopauseChanged,
    required this.firstChildAge,
    required this.onFirstChildChanged,
    required this.numberOfChildren,
    required this.onChildrenChanged,
    required this.breastfeedingMonths,
    required this.onBreastfeedingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Reproductive & Risk Factors'),
          MedicalSliderField(
            title: 'Menarche Age',
            unit: 'yrs',
            value: menarcheAge,
            min: 8,
            max: 20,
            onChanged: onMenarcheChanged,
          ),
          MedicalSliderField(
            title: 'Menopause Age',
            unit: 'yrs',
            value: menopauseAge,
            min: 35,
            max: 65,
            onChanged: onMenopauseChanged,
          ),
          MedicalSliderField(
            title: 'Age at First Child',
            unit: 'yrs',
            value: firstChildAge,
            min: 12,
            max: 45,
            onChanged: onFirstChildChanged,
          ),
          MedicalSliderField(
            title: 'Number of Children',
            unit: '',
            value: numberOfChildren,
            min: 0,
            max: 10,
            onChanged: onChildrenChanged,
          ),
          MedicalSliderField(
            title: 'Breastfeeding Duration',
            unit: 'months',
            value: breastfeedingMonths,
            min: 0,
            max: 36,
            onChanged: onBreastfeedingChanged,
          ),
        ],
      ),
    );
  }
}

class _MedicalInfoStep extends StatelessWidget {
  final TextEditingController allergiesController;
  final TextEditingController medicalHistoryController;
  final TextEditingController medicationsController;
  final TextEditingController commentsController;

  const _MedicalInfoStep({
    required this.allergiesController,
    required this.medicalHistoryController,
    required this.medicationsController,
    required this.commentsController,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SectionTitle(title: 'Medical Info & Comments'),
          AppTextField(
              controller: allergiesController,
              hintText: 'Enter allergies if any',
              maxLines: 2),
          const SizedBox(height: 12),
          AppTextField(
              controller: medicalHistoryController,
              hintText: 'Enter past medical history',
              maxLines: 3),
          const SizedBox(height: 12),
          AppTextField(
              controller: medicationsController,
              hintText: 'Enter medications',
              maxLines: 2),
          const SizedBox(height: 12),
          AppTextField(
              controller: commentsController,
              hintText: 'Any additional notes',
              maxLines: 3),
        ],
      ),
    );
  }
}
