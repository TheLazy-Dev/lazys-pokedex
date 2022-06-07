import 'dart:ui';

class ColorFromPokemonType {
  static const Color normal = Color(0xFFA8A878);
  static const Color fire = Color(0xFFF08030);
  static const Color water = Color(0xFF6890F0);
  static const Color electric = Color(0xFFF8D030);
  static const Color grass = Color(0xFF78C850);
  static const Color ice = Color(0xFF98D8D8);
  static const Color fighting = Color(0xFFC03028);
  static const Color poison = Color(0xFFA040A0);
  static const Color ground = Color(0xFFE0C068);
  static const Color flying = Color(0xFFA890F0);
  static const Color psychic = Color(0xFFF85888);
  static const Color bug = Color(0xFFA8B820);
  static const Color rock = Color(0xFFB8A038);
  static const Color ghost = Color(0xFF705898);
  static const Color dragon = Color(0xFFF85888);
  static const Color dark = Color(0xFF705848);
  static const Color steel = Color(0xFFB8B8D0);
  static const Color fairy = Color(0xFFEE99AC);

  static Color? getColor(type) {
    switch (type.type.name) {
      case 'normal':
        return normal;
      case 'fire':
        return fire;
      case 'water':
        return water;
      case 'electric':
        return electric;
      case 'grass':
        return grass;
      case 'ice':
        return ice;
      case 'fighting':
        return fighting;
      case 'poison':
        return poison;
      case 'ground':
        return ground;
      case 'flying':
        return flying;
      case 'psychic':
        return psychic;
      case 'bug':
        return bug;
      case 'rock':
        return rock;
      case 'ghost':
        return ghost;
      case 'dragon':
        return dragon;
      case 'dark':
        return dark;
      case 'steel':
        return steel;
      case 'fairy':
        return fairy;
      default:
        return normal;
    }
  }
}
