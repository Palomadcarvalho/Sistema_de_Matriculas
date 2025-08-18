import java.util.List;

public class Curso {
    private int id;
    private String nome;
    private int cargaHoraria;
    private List<Disciplina> disciplinas;

    public String getNome() {
        return nome;
    }

    public int getCargaHoraria() {
        return cargaHoraria;
    }

    public List<Disciplina> getDisciplinas() {
        return disciplinas;
    }
}
