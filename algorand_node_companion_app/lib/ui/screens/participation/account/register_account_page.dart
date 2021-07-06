import 'package:algorand_node_companion_app/models/models.dart';
import 'package:algorand_node_companion_app/themes/themes.dart';
import 'package:algorand_node_companion_app/ui/components/buttons/button.dart';
import 'package:algorand_node_companion_app/ui/components/loaders/loader.dart';
import 'package:algorand_node_companion_app/ui/components/sheets/faq_bottom_sheet.dart';
import 'package:algorand_node_companion_app/ui/components/spacing/spacing.dart';
import 'package:algorand_node_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/account/bloc/register_account_bloc.dart';
import 'package:algorand_node_companion_app/ui/screens/participation/account/bloc/register_account_state.dart';
import 'package:algorand_node_companion_app/utils/dialogs.dart';
import 'package:algorand_node_companion_app/utils/string_utils.dart';
import 'package:flow_builder/flow_builder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';

class RegisterAccountPage extends StatelessWidget {
  RegisterAccountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterAccountBloc, RegisterAccountState>(
      listener: (_, state) {
        if (state is RegisterAccountSuccess && state.submitted) {
          context.flow<ParticipationProfile>().update(
                (profile) => profile.copyWith(
                  address: state.address,
                  step: ParticipationStep.accountCompleted,
                ),
              );
        }
      },
      child: Scaffold(
        appBar: Toolbar(
          title: 'Register account',
          style: ToolbarStyle.DEFAULT,
          actions: [
            IconButton(
              icon: HeroIcon(
                HeroIcons.informationCircle,
                color: Palette.accentColor,
              ),
              onPressed: () {
                _showFAQBottomSheet(context);
              },
            ),
            HorizontalSpacing(of: paddingSizeDefault / 2),
          ],
          onBackTapped: () {
            _onBackTapped(context);
          },
        ),
        body: SafeArea(
          child: Container(
            padding: EdgeInsets.all(paddingSizeDefault),
            child: Builder(builder: (_) {
              final state = context.watch<RegisterAccountBloc>().state;
              if (state is! RegisterAccountSuccess) {
                return Loader();
              }

              final initialAddress = state.address;
              final accounts = state.accounts;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Account',
                    style: labelTextStyle,
                  ),
                  DropdownButton<String>(
                    value: initialAddress != null
                        ? initialAddress.encodedAddress
                        : null,
                    hint: Text(
                      'Import an account first',
                      style: hintTextStyle,
                    ),
                    isExpanded: true,
                    iconSize: 24,
                    icon: HeroIcon(HeroIcons.chevronDown),
                    style: regularTextStyle,
                    underline: Container(
                      height: 2,
                      color: Palette.accentColor,
                    ),
                    onChanged: (String? newValue) {
                      if (newValue == null) {
                        return;
                      }

                      context
                          .read<RegisterAccountBloc>()
                          .change(address: newValue);
                    },
                    items: accounts.map<DropdownMenuItem<String>>(
                      (String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value.toShortenedAddress(10),
                            style: mediumTextStyle,
                          ),
                        );
                      },
                    ).toList(),
                  ),
                  VerticalSpacing(of: 8),
                  Spacer(),
                  Button(
                    text: 'Register account',
                    onTap: state.accounts.isNotEmpty
                        ? () {
                            context.read<RegisterAccountBloc>().register();
                          }
                        : null,
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }

  void _showFAQBottomSheet(BuildContext context) {
    showAlgorandBottomSheet(
      context: context,
      builder: (_) => FAQBottomSheet(
        question: 'Why do I have to register an account?',
        answer:
            '''In order for an account to participate in consensus, it must first mark itself online. Marking an account online requires the account to have a valid participation key, which has been registered with the network by way of an online key registration transaction, authorized by the participating account.
                          \nYou can import an account to sign the online key registration transaction or add a watch account to sign the transaction offline. 
                          \n''',
      ),
    );
  }

  void _onBackTapped(BuildContext context) {
    context.flow<ParticipationProfile>().update(
          (profile) => profile.copyWith(
            address: null,
            step: ParticipationStep.initial,
          ),
        );
  }
}
