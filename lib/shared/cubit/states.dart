abstract class newsStates {

}
class intialSate extends newsStates{

}
class BottomNavigationBarSate extends newsStates{

}
class loadingState extends newsStates{

}
class businessGetState extends newsStates{

}
class sportsGetState extends newsStates{

}
class scienceGetState extends newsStates{

}
class businessGetErrorState extends newsStates{
  final error;
  businessGetErrorState(this.error);
}
class sportsGetErrorState extends newsStates{
  final error;
  sportsGetErrorState(this.error);
}
class scienceGetErrorState extends newsStates{
  final error;
  scienceGetErrorState(this.error);
}