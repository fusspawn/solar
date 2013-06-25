library GameObject;

class GameObject {
    String Tag;
    double ID;
    static double __LastID;
    static double GetNextID() {
        return GameObject.__LastID++;
    }
}