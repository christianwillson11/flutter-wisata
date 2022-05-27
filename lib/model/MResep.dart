class MResep {
  String namamenu;
  String alamatURL;
  String gambarURL;
  
  MResep(this.namamenu, this.alamatURL, this.gambarURL);
  
  static List<MResep> isiResep = [
    MResep("Gulai Ayam rasa Tongseng ", "https://cookpad.com/id/resep/16170702-gulai-ayam", "https://img-global.cpcdn.com/recipes/3300e52377e6e354/1280x1280sq70/photo.webp"),
    MResep("Rendang Ayam Minang Padang Pariaman", "https://cookpad.com/id/resep/12628390-resep-rendang-ayam-minang-padang-pariaman-sumatera-barat?via=premium_page_recipe_teaser", "https://img-global.cpcdn.com/recipes/4b4055be894a3350/1280x1280sq70/photo.webp"),
  ];
}