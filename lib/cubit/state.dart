part of 'cubit.dart';

class FullContactState extends Equatable {
  final Contact? contact;

  const FullContactState({this.contact});

  @override
  List<Object> get props => [contact!];
}
