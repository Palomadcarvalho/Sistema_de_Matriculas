import java.util.List;

public class Disciplina {
    private String codigo;
    private String nome;
    private int creditos;
    private int vagasMax = 60;
    private boolean ativa;
    private List<Aluno> alunosMatriculados;

    public boolean verificarAtivacao() {

        return false;
    }

    public List<Aluno> getAlunos() {
        return alunosMatriculados;
    }
}

