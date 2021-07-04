import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/button.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/ui/components/textfield/word_edit_text.dart';
import 'package:nodex_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:nodex_companion_app/ui/screens/accounts/import/import_account.dart';
import 'package:provider/provider.dart';

class ImportAccountScreen extends StatelessWidget {
  static final routeName = '/accounts/import';

  const ImportAccountScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<ImportAccountBloc, ImportAccountState>(
      listener: (_, state) {
        if (state is ImportAccountSuccess) {
          router.pop(context);
        }

        if (state is ImportAccountFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'It looks like your passphrase is incorrect. Can you check again?',
                style: regularTextStyle.copyWith(
                    color: Palette.primaryButtonTextColor),
              ),
              backgroundColor: Palette.errorColor,
            ),
          );
        }
      },
      child: Scaffold(
        appBar: Toolbar(
          title: 'Enter your passphrase',
          style: ToolbarStyle.DEFAULT,
          actions: [
            IconButton(
              icon: HeroIcon(
                HeroIcons.clipboardList,
                color: Palette.primaryIconTintColor,
              ),
              onPressed: () {
                context.read<ImportAccountBloc>().pasteClipboard();
              },
            ),
            HorizontalSpacing(of: paddingSizeDefault / 2),
          ],
          onBackTapped: () {
            router.pop(context);
          },
        ),
        body: BlocBuilder<ImportAccountBloc, ImportAccountState>(
          buildWhen: (oldState, newState) =>
              newState.pasted && newState is! ImportAccountFailure,
          builder: (_, state) {
            return Padding(
              padding: EdgeInsets.all(paddingSizeDefault),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: GridView.count(
                      physics: ClampingScrollPhysics(),
                      crossAxisCount: 2,
                      childAspectRatio: 2.6,
                      addAutomaticKeepAlives: true,
                      children: List.generate(
                        25,
                        (index) => WordEditText(
                          index: index + 1,
                          focus: index == 0,
                          text: state.words[index],
                          onChanged: (value) {
                            print('$index. $value valid');
                            context.read<ImportAccountBloc>().updateWord(
                                  index: index,
                                  word: value,
                                );
                          },
                        ),
                      ),
                    ),
                  ),
                  Button(
                    text: 'Import',
                    onTap: state.areWordsFilledIn
                        ? () {
                            context.read<ImportAccountBloc>().importAccount();
                          }
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
