import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/buttons/button.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';
import 'package:algorand_node_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:lottie/lottie.dart';

/// The final screen that is shown when participation in consensus was
/// successful.
class ParticipationSuccessPage extends StatelessWidget {
  const ParticipationSuccessPage({Key? key}) : super(key: key);

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
          child: Builder(
            builder: (_) {
              return Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: Lottie.asset(
                      'assets/animations/nodes.json',
                      repeat: false,
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Spacer(),
                        Padding(
                          padding: EdgeInsets.all(36 - paddingSizeDefault),
                          child: Text(
                            'Participation completed',
                            style: semiBoldTextStyle.copyWith(fontSize: 28.0),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        VerticalSpacing(of: paddingSizeMedium),
                        Text(
                          'You are now participating in consensus!\nOn average, it takes around 320 rounds, or 30 minutes, for the change to take effect.\n\nIf you want to stop participating, make sure to register your account offline.',
                          style: regularTextStyle.copyWith(
                            fontSize: 14,
                            color: Palette.secondaryTextColor,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacer(flex: 3),
                        Button(
                          text: 'Finish setup',
                          onTap: () {
                            context.flow<ParticipationProfile>().complete();
                          },
                        ),
                      ],
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
