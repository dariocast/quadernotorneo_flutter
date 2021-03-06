import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_fonts/google_fonts.dart';
import '../blocs/blocs.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../models/models.dart';
import 'style_helpers.dart';

class PartitaWidget extends StatelessWidget {
  PartitaWidget();

  @override
  Widget build(BuildContext context) {
    final partita = context.select((DettaglioBloc bloc) => bloc.state.partita!);
    final eventi = context.select((DettaglioBloc bloc) => bloc.state.eventi!);
    final authStatus =
        context.select((AuthenticationBloc bloc) => bloc.state.status);
    final giocatoriSquadraUno =
        context.select((DettaglioBloc bloc) => bloc.state.giocatoriSquadraUno!);
    final giocatoriSquadraDue =
        context.select((DettaglioBloc bloc) => bloc.state.giocatoriSquadraDue!);
    return Container(
      height: Size.infinite.height,
      width: Size.infinite.width,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/blocnotes.png'),
              fit: BoxFit.fill)),
      child: Column(
        children: [
          authStatus == AuthenticationStatus.authenticated
              ? Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Gol',
                                  message: 'Chi ha segnato?',
                                  actions: giocatoriSquadraUno
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioAggiungiGol(Giocatore(
                                          choice, partita.squadraUno)));
                                }
                              },
                              child: Text('Gol'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Autogol',
                                  message: 'Chi l\'ha fatto?',
                                  actions: giocatoriSquadraUno
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioAggiungiAutogol(Giocatore(
                                          choice, partita.squadraUno)));
                                }
                              },
                              child: Text('Autogol'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Ammonito',
                                  message: 'Chi è stato ammonito?',
                                  actions: giocatoriSquadraUno
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioAmmonisci(Giocatore(
                                          choice, partita.squadraUno)));
                                }
                              },
                              child: Text('Ammonisci'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Espulso',
                                  message: 'Chi è stato espulso?',
                                  actions: giocatoriSquadraUno
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioEspelli(Giocatore(
                                          choice, partita.squadraUno)));
                                }
                              },
                              child: Text('Espelli'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Falli'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 10,
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<DettaglioBloc>()
                                        .add(DettaglioAggiungiFallo(
                                            partita.squadraUno)),
                                    child: Text('+'),
                                    style: elevatedButtonStyle,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 10,
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<DettaglioBloc>()
                                        .add(DettaglioRimuoviFallo(
                                            partita.squadraUno)),
                                    child: Text('-'),
                                    style: elevatedButtonStyle,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  partita.falliSquadraUno.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: Align(
                          alignment: Alignment.center,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 100.0),
                            child: Text(
                                '${partita.golSquadraUno}:${partita.golSquadraDue}',
                                style: TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                )),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Gol',
                                  message: 'Chi ha segnato?',
                                  actions: giocatoriSquadraDue
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioAggiungiGol(Giocatore(
                                          choice, partita.squadraDue)));
                                }
                              },
                              child: Text('Gol'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Autogol',
                                  message: 'Chi l\'ha fatto?',
                                  actions: giocatoriSquadraDue
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioAggiungiAutogol(Giocatore(
                                          choice, partita.squadraDue)));
                                }
                              },
                              child: Text('Autogol'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Ammonito',
                                  message: 'Chi è stato ammonito?',
                                  actions: giocatoriSquadraDue
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioAmmonisci(Giocatore(
                                          choice, partita.squadraDue)));
                                }
                              },
                              child: Text('Ammonisci'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.5,
                            child: ElevatedButton(
                              onPressed: () async {
                                final choice = await showConfirmationDialog(
                                  context: context,
                                  title: 'Espulso',
                                  message: 'Chi è stato espulso?',
                                  actions: giocatoriSquadraDue
                                      .map((e) =>
                                          AlertDialogAction(key: e, label: e))
                                      .toList(),
                                );
                                if (choice != null) {
                                  context.read<DettaglioBloc>().add(
                                      DettaglioEspelli(Giocatore(
                                          choice, partita.squadraDue)));
                                }
                              },
                              child: Text('Espelli'),
                              style: elevatedButtonStyle,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text('Falli'),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 10,
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<DettaglioBloc>()
                                        .add(DettaglioAggiungiFallo(
                                            partita.squadraDue)),
                                    child: Text('+'),
                                    style: elevatedButtonStyle,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: SizedBox(
                                  width: MediaQuery.of(context).size.width / 10,
                                  child: ElevatedButton(
                                    onPressed: () => context
                                        .read<DettaglioBloc>()
                                        .add(DettaglioRimuoviFallo(
                                            partita.squadraDue)),
                                    child: Text('-'),
                                    style: elevatedButtonStyle,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  partita.falliSquadraDue.toString(),
                                  style: TextStyle(fontSize: 20),
                                ),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                )
              : Expanded(
                  child: Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 60.0,
                          left: 50.0,
                        ),
                        child: Text(
                            '${partita.golSquadraUno}:${partita.golSquadraDue}',
                            style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20.0,
                bottom: 25.0,
                right: 20.0,
              ),
              child: ListView.builder(
                itemCount: eventi.length,
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(1.5),
                  child: Align(
                    alignment: eventi[index].squadra == partita.squadraUno
                        ? Alignment.centerLeft
                        : Alignment.centerRight,
                    child: Text(
                      '${eventi[index].nome} - ${eventi[index].tipo.toString().split('.').last}',
                      style: GoogleFonts.lato(
                        textStyle: TextStyle(fontSize: 25),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
