

class ApiPaths{
  static const mainPath = "https://api.magicthegathering.io/v1/";

  static String allCard() => mainPath + "cards/";
  static card({id}){
    return allCard() + id;
  }

  static sets() => mainPath + 'sets';
  static set({id}){
    return sets() + id;
  }

  static setBooster({id}){
    return sets() + id + 'booster';
  }

  static types() => mainPath + "types";
  static  type({id}){
    return types() + id;
  }

  static subTypes() => mainPath + "types";
  static superTypes() => mainPath + "types";
  static formats() => mainPath + "formats";

}