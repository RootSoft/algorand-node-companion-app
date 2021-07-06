import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/buttons/button.dart';
import 'package:algorand_node_companion_app/ui/components/lists/information_tile.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';
import 'package:algorand_node_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:flow_builder/flow_builder.dart';

class ConsensusWelcomePage extends StatelessWidget {
  static String routeName = '/consensus/welcome';

  const ConsensusWelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: '',
        style: ToolbarStyle.CLOSE,
        onBackTapped: () {
          context.flow<ParticipationProfile>().complete();
        },
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Participate in consensus',
                style: titleTextStyle,
              ),
              VerticalSpacing(of: paddingSizeMedium),
              Text(
                'An account that participates in the Algorand consensus protocol is eligible and available to be selected to propose and vote on new blocks in the Algorand blockchain. Participating in consensus helps to secure the network.',
                style: regularTextStyle.copyWith(
                  fontSize: fontSizeMedium,
                  color: Palette.tertiaryTextColor,
                ),
              ),
              Spacer(),
              Text(
                'What to expect:',
                style: regularTextStyle.copyWith(
                  fontSize: 16,
                  color: Palette.tertiaryTextColor,
                ),
              ),
              VerticalSpacing(of: paddingSizeSmall),
              InformationTile(
                text:
                    'Accounts participate in the Algorand consensus protocol by generating a valid participation key.',
              ),
              VerticalSpacing(of: paddingSizeSmall),
              InformationTile(
                text:
                    'Accounts mark themselves online by submitting an online key registration transaction for a valid participation key.',
              ),
              VerticalSpacing(of: paddingSizeSmall),
              InformationTile(
                text:
                    'It is important to mark your account offline if it is not participating. ',
              ),
              Spacer(flex: 2),
              SizedBox(
                width: double.infinity,
                child: Button(
                  text: 'Start process',
                  onTap: () {
                    context.flow<ParticipationProfile>().update(
                          (profile) => profile.copyWith(
                            step: ParticipationStep.welcomeCompleted,
                          ),
                        );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  DateTime getLastDate() {
    final now = DateTime.now();
    return new DateTime(now.year, now.month + 6, now.day);
  }
}
