package selirMovieWeb;

import java.util.Date;

public class Actor {

    public int id;
    public String nume;
    public String prenume;
    public Date dataNastere;

    public Actor(int id, String nume, String prenume, Date dataNastere) {
        super();
        this.id = id;
        this.nume = nume;
        this.prenume = prenume;
        this.dataNastere = dataNastere;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNume() {
        return nume;
    }

    public void setNume(String nume) {
        this.nume = nume;
    }

    public String getPrenume() {
        return prenume;
    }

    public void setPrenume(String prenume) {
        this.prenume = prenume;
    }

    public Date getDataNastere() {
        return dataNastere;
    }

    public void setDataNastere(Date dataNastere) {
        this.dataNastere = dataNastere;
    }

}
