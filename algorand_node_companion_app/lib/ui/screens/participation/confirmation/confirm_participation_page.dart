import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/models/models.dart';
import 'package:nodex_companion_app/shared/node_network.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/button.dart';
import 'package:nodex_companion_app/ui/components/loaders/loader.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:nodex_companion_app/ui/screens/participation/bloc/participation_bloc.dart';
import 'package:nodex_companion_app/ui/screens/participation/bloc/participation_state.dart';
import 'package:nodex_companion_app/utils/date_formatters.dart';
import 'package:nodex_companion_app/utils/dialogs.dart';
import 'package:provider/provider.dart';

class ConfirmParticipationPage extends StatelessWidget {
  const ConfirmParticipationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ParticipationBloc, ParticipationState>(
      listener: (_, state) {
        if (state is ParticipationFailure) {
          showSnackbar(context: context, text: state.errorMessage);
        }

        if (state is ParticipationSuccess) {
          context.flow<ParticipationProfile>().update(
                (profile) => profile.copyWith(
                  step: ParticipationStep.participationCompleted,
                ),
              );
        }
      },
      child: Scaffold(
        appBar: Toolbar(
          title: 'Confirm participation',
          style: ToolbarStyle.DEFAULT,
          onBackTapped: () {
            context.flow<ParticipationProfile>().update(
                  (profile) => profile.copyWith(
                    step: ParticipationStep.accountCompleted,
                  ),
                );
            //Navigator.of(context).pop();
          },
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(paddingSizeDefault),
            child: Builder(
              builder: (_) {
                final state = context.watch<ParticipationBloc>().state;
                final profile = context.flow<ParticipationProfile>().state;

                if (state is ParticipationInProgress) {
                  return Loader();
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    /// Display the address
                    Text('Account', style: semiBoldTextStyle),
                    VerticalSpacing(of: marginSizeSmall),
                    Text(
                      profile.address?.encodedAddress ?? '',
                      style: regularTextStyle,
                    ),

                    VerticalSpacing(of: marginSizeDefault),

                    /// Display the start date
                    Text('Start date', style: semiBoldTextStyle),
                    VerticalSpacing(of: marginSizeSmall),
                    Text(DateTime.now().format(), style: regularTextStyle),

                    VerticalSpacing(of: marginSizeDefault),

                    /// Display the end date
                    Text('End date', style: semiBoldTextStyle),
                    VerticalSpacing(of: marginSizeSmall),
                    Text(profile.endDate?.format() ?? '',
                        style: regularTextStyle),
                    VerticalSpacing(of: marginSizeDefault),

                    /// Display the network
                    Text('Network', style: semiBoldTextStyle),
                    VerticalSpacing(of: marginSizeSmall),
                    Text(
                        BlocProvider.of<ParticipationBloc>(context)
                            .node
                            .network
                            .name,
                        style: regularTextStyle),

                    Spacer(),
                    Button(
                      text: 'Participate',
                      onTap: () {
                        final profile =
                            context.flow<ParticipationProfile>().state;
                        final address = profile.address;
                        final rounds = profile.rounds;
                        if (address == null || rounds == null) return;

                        context.read<ParticipationBloc>().registerOnline(
                              address: address,
                              rounds: rounds,
                            );
                      },
                    )
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
