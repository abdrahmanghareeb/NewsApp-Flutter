abstract class News_State {

}
class intialSate extends News_State{

}
class IconState extends News_State{
}
class SetDropDownState extends News_State{
}
class setCasheState extends News_State{

}
class getCasheState extends News_State{

}
class appThemeModeState extends News_State{

}
class BottomNavigationBarSate extends News_State{

}
class loadingState extends News_State{

}
class businessGetState extends News_State{

}
class sportsGetState extends News_State{

}
class scienceGetState extends News_State{

}
class businessGetErrorState extends News_State{
  final error;
  businessGetErrorState(this.error);
}
class sportsGetErrorState extends News_State{
  final error;
  sportsGetErrorState(this.error);
}
class scienceGetErrorState extends News_State{
  final error;
  scienceGetErrorState(this.error);
}
class searchGetState extends News_State{

}
class searchGetErrorState extends News_State{
  final error;
  searchGetErrorState(this.error);
}