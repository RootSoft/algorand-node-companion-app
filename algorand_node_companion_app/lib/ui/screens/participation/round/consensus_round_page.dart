import 'package:flow_builder/flow_builder.dart';
import 'package:heroicons/heroicons.dart';
import 'package:jiffy/jiffy.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/button.dart';
import 'package:nodex_companion_app/ui/components/sheets/faq_bottom_sheet.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/ui/components/textfield/edit_text.dart';
import 'package:nodex_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:nodex_companion_app/utils/date_formatters.dart';
import 'package:nodex_companion_app/utils/dialogs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class ConsensusRoundPage extends StatefulWidget {
  ConsensusRoundPage({Key? key}) : super(key: key);

  @override
  _ConsensusRoundPageState createState() => _ConsensusRoundPageState();
}

class _ConsensusRoundPageState extends State<ConsensusRoundPage> {
  DateTime _endDate = DateTime.now();
  final DateTime _initialDate = Jiffy().add(months: 5, days: 4).dateTime;

  TextEditingController _dateController = TextEditingController();

  final form = FormGroup({
    'account': FormControl<String>(
      validators: [
        Validators.required,
      ],
    ),
  });

  @override
  void initState() {
    super.initState();
    _endDate = _initialDate;
    _dateController.text = formatDate(_endDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: 'Validity period',
        style: ToolbarStyle.DEFAULT,
        actions: [
          IconButton(
            icon: HeroIcon(
              HeroIcons.informationCircle,
              color: Palette.accentColor,
            ),
            onPressed: () {
              showAlgorandBottomSheet(
                context: context,
                builder: (_) => FAQBottomSheet(
                  question: 'What is a validity period?',
                  answer:
                      '''A user account must be online to participate in the consensus protocol. To reduce exposure, online users do not use their spending keys (i.e., the keys they use to sign transactions) for consensus. Instead, a user generates and registers a participation key for a certain number of rounds.
                      \nUsing participation keys ensures that a user's tokens are secure even if their participating node is compromised. 
                      \nThere is no theoretical limit to the range you can specify for a partkey validity period. A recommended range is 3,000,000 rounds.
                      \n''',
                ),
              );
            },
          ),
          HorizontalSpacing(of: paddingSizeDefault / 2),
        ],
        onBackTapped: () {
          context.flow<ParticipationProfile>().update(
                (profile) => profile.copyWith(
                  rounds: null,
                  endDate: null,
                  step: ParticipationStep.welcomeCompleted,
                ),
              );
          //Navigator.of(context).pop();
        },
      ),
      body: SafeArea(
        child: ReactiveForm(
          formGroup: form,
          child: Container(
            padding: EdgeInsets.all(paddingSizeDefault),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacer(),
                Text(
                  'Start date',
                  style: semiBoldTextStyle,
                ),
                SizedBox(
                  width: 120,
                  child: EditText(
                    enabled: false,
                    text: DateTime.now().format(),
                  ),
                ),
                VerticalSpacing(of: paddingSizeDefault),
                _buildIcon(),
                VerticalSpacing(of: paddingSizeLarge),
                Text(
                  'End date',
                  style: semiBoldTextStyle,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HorizontalSpacing(of: 24),
                    HorizontalSpacing(of: marginSizeDefault),
                    SizedBox(
                      width: 120,
                      child: EditText(
                        enabled: false,
                        textEditingController: _dateController,
                      ),
                    ),
                    HorizontalSpacing(of: marginSizeDefault),
                    InkWell(
                      onTap: () async {
                        final dateTime = await showDatePicker(
                          context: context,
                          initialDate: _endDate,
                          firstDate: Jiffy().add(days: 1).dateTime,
                          lastDate: Jiffy().add(years: 2).dateTime,
                        );

                        if (dateTime == null) return;
                        setState(() {
                          _endDate = dateTime;
                          _dateController.text = formatDate(dateTime);
                        });
                      },
                      child: HeroIcon(
                        HeroIcons.calendar,
                        color: Palette.primaryIconTintColor,
                      ),
                    ),
                  ],
                ),
                Text(
                  '${differenceInDays(_endDate)} days ≈ ${differenceInRounds(_endDate)} rounds',
                  style: regularTextStyle,
                ),
                Spacer(
                  flex: 2,
                ),
                Container(
                  width: double.infinity,
                  child: Button(
                    text: 'Confirm date',
                    onTap: () {
                      context.flow<ParticipationProfile>().update(
                            (profile) => profile.copyWith(
                              step: ParticipationStep.roundCompleted,
                              rounds: differenceInRounds(_endDate),
                              endDate: _endDate,
                            ),
                          );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon() {
    return Container(
      width: 80.0,
      height: 80.0,
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Palette.backgroundOnPrimary,
        shape: BoxShape.circle,
      ),
      child: HeroIcon(
        HeroIcons.chevronDown,
        size: 80.0,
        color: const Color(0xFF1DAD98),
      ),
    );
  }
}
