part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

class HomeFailure extends HomeState {}

class HomeLoading extends HomeState {}

class HomeSuccess extends HomeState {
  final List<PartitaModel> partite;
  final List<Gruppo> infoGruppi;

  const HomeSuccess({required this.partite, required this.infoGruppi});

  @override
  List<Object> get props => [partite, infoGruppi];

  @override
  String toString() =>
      'HomeSuccess(partite: $partite, infoGruppi: $infoGruppi)';

  HomeSuccess copyWith({
    List<PartitaModel>? partite,
    List<Gruppo>? infoGruppi,
  }) {
    return HomeSuccess(
      partite: partite ?? this.partite,
      infoGruppi: infoGruppi ?? this.infoGruppi,
    );
  }
}
