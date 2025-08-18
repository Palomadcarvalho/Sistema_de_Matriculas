import java.util.List;

public class Professor {
    private int id;
    private String nome;
    private String siape;
    private List<Disciplina> disciplinas;
    private List<Curso> cursos;

    public List<Disciplina> getDisciplinas() {
        return disciplinas;
    }

    public List<Curso> getCursos() {
        return cursos;
    }
}
