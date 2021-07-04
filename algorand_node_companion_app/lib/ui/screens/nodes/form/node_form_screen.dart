import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nodex_companion_app/themes/themes.dart';
import 'package:nodex_companion_app/ui/components/buttons/argon_button_dart.dart';
import 'package:nodex_companion_app/ui/components/buttons/progress_button.dart';
import 'package:nodex_companion_app/ui/components/spacing/spacing.dart';
import 'package:nodex_companion_app/ui/components/textfield/edit_text.dart';
import 'package:nodex_companion_app/ui/components/toolbar/toolbar.dart';
import 'package:nodex_companion_app/ui/screens/nodes/form/node_form.dart';
import 'package:nodex_companion_app/utils/dialogs.dart';
import 'package:reactive_forms/reactive_forms.dart';

class NodeFormScreen extends StatelessWidget {
  static String routeName = '/node/form';

  NodeFormScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<NodeFormBloc, NodeFormState>(
      listener: (_, state) {
        if (state is NodeFormFailure) {
          showSnackbar(
              context: context,
              text:
                  'It looks like a connection can\'t be established. Can you check again?');
        }
        if (state is NodeFormSuccess) {
          Navigator.popUntil(context, ModalRoute.withName('/'));
        }
      },
      child: Scaffold(
        appBar: Toolbar(
          title: context.select(
            (NodeFormBloc bloc) => bloc.state.isEditing
                ? 'Edit ${bloc.state.node?.name}'
                : 'Add a node',
          ),
          style: ToolbarStyle.DEFAULT,
          onBackTapped: () {
            router.pop(context);
          },
        ),
        body: SafeArea(
          child: Builder(
            builder: (context) {
              return ReactiveForm(
                formGroup: BlocProvider.of<NodeFormBloc>(context).form,
                child: Container(
                  padding: EdgeInsets.all(paddingSizeDefault),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        EditText(
                          formControlName: 'name',
                          label: 'Name',
                          hintText: 'E.g. Raspberry Pi',
                          validationMessages: (control) => {
                            'required': 'This field is required',
                          },
                          onSubmitted: () => context
                              .read<NodeFormBloc>()
                              .form
                              .focus('ip-address'),
                        ),
                        EditText(
                          formControlName: 'ip-address',
                          label: 'IP Address',
                          hintText: '127.0.0.1',
                          validationMessages: (control) => {
                            'required': 'This field is required',
                          },
                          onSubmitted: () =>
                              context.read<NodeFormBloc>().form.focus('port'),
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: EditText(
                                formControlName: 'port',
                                label: 'Port (optional)',
                                hintText: '4042',
                                validationMessages: (control) => {
                                  'number': 'Add a valid port number',
                                },
                                onSubmitted: () => context
                                    .read<NodeFormBloc>()
                                    .form
                                    .focus('port'),
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                        EditText(
                          formControlName: 'working-directory',
                          label: 'Working directory (optional)',
                          hintText: '/Users/username/node',
                          onSubmitted: () {},
                        ),
                        VerticalSpacing(of: paddingSizeXLarge),
                        BlocBuilder<NodeFormBloc, NodeFormState>(
                          builder: (_, state) => ProgressButton(
                            width: MediaQuery.of(context).size.width,
                            text: state.isEditing ? 'Edit node' : 'Add node',
                            state: state is NodeFormInProgress
                                ? ButtonState.Loading
                                : ButtonState.Idle,
                            onTap: (startLoading, stopLoading, state) {
                              if (state == ButtonState.Loading) return;
                              context.read<NodeFormBloc>().addNode();
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
