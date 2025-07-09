<?php

require_once __DIR__ . '/../core/Database.php';

use Ritmize\core\Database;

class FinanceiroController {
    private $twig;
    private $db;
    
    public function __construct() {
        // Configurar Twig
        $loader = new \Twig\Loader\FilesystemLoader('templates');
        $this->twig = new \Twig\Environment($loader);
        
        // Conectar banco
        $this->db = Database::getInstance();
    }
    
    public function index() {
        try {
            $aluno_id = $_SESSION['aluno_id'] ?? 1;
            
            // Buscar dados do aluno
            $aluno = $this->db->query(
                "SELECT * FROM alunos WHERE id = ?", 
                [$aluno_id]
            )->fetch();
            
            // Buscar mensalidade atual (mês atual)
            $mesAtual = date('Y-m-01');
            $mensalidadeAtual = $this->db->query(
                "SELECT * FROM mensalidades 
                 WHERE aluno_id = ? AND mes_referencia = ?
                 ORDER BY created_at DESC
                 LIMIT 1",
                [$aluno_id, $mesAtual]
            )->fetch();
            
            // Buscar mensalidades do aluno
            $mensalidades = $this->db->query(
                "SELECT m.*, 
                        GROUP_CONCAT(t.nome SEPARATOR ', ') as turmas
                 FROM mensalidades m
                 LEFT JOIN mensalidades_turmas mt ON m.id = mt.mensalidade_id
                 LEFT JOIN turmas t ON mt.turma_id = t.id
                 WHERE m.aluno_id = ?
                 GROUP BY m.id
                 ORDER BY m.mes_referencia DESC",
                [$aluno_id]
            )->fetchAll();
            
            echo $this->twig->render('financeiro.twig', [
                'aluno' => $aluno,
                'mensalidade_atual' => $mensalidadeAtual,
                'mensalidades' => $mensalidades,
                'page' => 'financeiro'
            ]);
            
        } catch (Exception $e) {
            echo "<h2>❌ Erro no Financeiro</h2>";
            echo "<p>" . $e->getMessage() . "</p>";
        }
    }
}
?> 