package selirMovieWeb;


public class Film {

    public int id;
    public String denumire;
    public int durata; // minute
    public int anAparitie;
    public String imagine;

    public Film(int id, String denumire, int durata, int anAparitie) {
        super();
        this.id = id;
        this.denumire = denumire;
        this.durata = durata;
        this.anAparitie = anAparitie;
    }

    public Film(int id, String denumire, int durata, int anAparitie, String imagine) {
        this(id, denumire, durata, anAparitie);
        this.imagine = imagine;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDenumire() {
        return denumire;
    }

    public void setDenumire(String denumire) {
        this.denumire = denumire;
    }

    public int getDurata() {
        return durata;
    }

    public void setDurata(int durata) {
        this.durata = durata;
    }

    public int getAnAparitie() {
        return anAparitie;
    }

    public void setAnAparitie(int anAparitie) {
        this.anAparitie = anAparitie;
    }

    public String getImagine() {
        return imagine;
    }

    public void setImagine(String imagine) {
        this.imagine = imagine;
    }

}
