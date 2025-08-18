import java.util.List;

public class Aluno {
    private int id;
    private String nome;
    private String matricula;
    private List<Disciplina> disciplinasObrigatorias;
    private List<Disciplina> disciplinasOptativas;
    private List<Curso> cursos;

    public void inscreverDisciplina(Disciplina d) {

    }

    public void cancelarInscricao(Disciplina d) {

    }

    public List<Curso> getCursos() {
        return cursos;
    }
}

