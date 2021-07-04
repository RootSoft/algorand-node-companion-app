import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/circle_action_button.dart';
import 'package:nodex_companion_app/ui/components/icons/icon_container.dart';
import 'package:nodex_companion_app/ui/components/loaders/loader.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:nodex_companion_app/ui/screens/accounts/accounts.dart';
import 'package:nodex_companion_app/ui/screens/accounts/import/import_account.dart';
import 'package:nodex_companion_app/utils/string_utils.dart';
import 'package:provider/provider.dart';

class AccountsPage extends StatelessWidget {
  static String routeName = '/accounts';

  const AccountsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar(
        title: 'Accounts',
        actions: [
          CircleActionButton(
            backgroundColor: Palette.primaryColor,
            onPressed: () {
              router.navigateTo(context, ImportAccountScreen.routeName);
            },
          ),
          HorizontalSpacing(of: paddingSizeDefault / 2),
        ],
      ),
      body: Builder(
        builder: (_) {
          final state = context.watch<AccountsBloc>().state;

          if (state is AccountsInProgress) {
            return Loader();
          }

          if (state is! AccountsSuccess) {
            return Loader();
          }

          if (state.accounts.isEmpty) {
            return EmptyAccountsPage();
          }

          return Container(
            color: Palette.backgroundNavigationColor,
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<AccountsBloc>().refresh();
              },
              child: ListView.separated(
                addAutomaticKeepAlives: true,
                itemCount: state.accounts.length,
                itemBuilder: (_, index) {
                  final account = state.accounts[index];
                  return Padding(
                    padding: EdgeInsets.all(0),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: paddingSizeDefault,
                        vertical: paddingSizeDefault / 2,
                      ),
                      leading: IconContainer(
                        icon: HeroIcons.user,
                        size: 44.0,
                        iconPadding: 10.0,
                        backgroundColor: const Color(0xFFF3F3F5),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            account.publicAddress.toShortenedAddress(),
                            style: mediumTextStyle,
                            maxLines: 1,
                          ),
                          VerticalSpacing(of: 4),
                          Text(
                            account.registered ? 'Online' : 'Offline',
                            style: semiBoldTextStyle.copyWith(
                              fontSize: fontSizeSmall,
                              color: account.registered
                                  ? const Color(0xFF1DAD98)
                                  : Palette.errorColor,
                            ),
                            maxLines: 1,
                          ),
                        ],
                      ),
                      trailing: IconContainer(
                        icon: HeroIcons.qrcode,
                        size: 44.0,
                        iconPadding: 10.0,
                        backgroundColor: const Color(0xFFF3F3F5),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) {
                  return VerticalSpacing(of: 0);
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
