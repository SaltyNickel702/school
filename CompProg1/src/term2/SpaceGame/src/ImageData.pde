class ImageData {
    PImage img;
    String name;

    ImageData (String rel, String name) {
        img = loadImage(rel);
        if (img == null) {
            img = loadImage("NA.png");
        }
        this.name = name;
    }
}
