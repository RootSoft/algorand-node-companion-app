import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/repositories/repositories.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/account/bloc/register_account_bloc.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/account/register_account_page.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/confirmation/confirm_participation_page.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/round/consensus_round_page.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/success/participation_success_page.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/welcome/consensus_welcome_page.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ParticipationScreen extends StatelessWidget {
  static String routeName = '/participation';

  const ParticipationScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FlowBuilder<ParticipationProfile>(
      state: const ParticipationProfile(
        step: ParticipationStep.initial,
      ),
      onGeneratePages: (profile, pages) {
        return [
          MaterialPage(child: ConsensusWelcomePage()),
          if (profile.step == ParticipationStep.welcomeCompleted)
            MaterialPage(
              child: BlocProvider<RegisterAccountBloc>(
                create: (_) => RegisterAccountBloc(
                  accountRepository: sl.get<AccountRepository>(),
                )..start(),
                child: RegisterAccountPage(),
              ),
            ),
          if (profile.step == ParticipationStep.accountCompleted)
            MaterialPage(child: ConsensusRoundPage()),
          if (profile.step == ParticipationStep.roundCompleted)
            MaterialPage(child: ConfirmParticipationPage()),
          if (profile.step == ParticipationStep.participationCompleted)
            MaterialPage(child: ParticipationSuccessPage()),
        ];
      },
    );
  }
}
