<?php

require_once __DIR__ . '/../core/Database.php';

use Ritmize\core\Database;

class PerfilController {
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
            
            // Buscar dados completos do aluno
            $aluno = $this->db->query(
                "SELECT * FROM alunos WHERE id = ?", 
                [$aluno_id]
            )->fetch();
            
            // Buscar estatísticas do aluno
            $stats = [];
            
            // Total de turmas ativas
            $stats['turmas_ativas'] = $this->db->query(
                "SELECT COUNT(*) as total FROM inscricoes WHERE aluno_id = ? AND status = 'ativa'",
                [$aluno_id]
            )->fetch()['total'];
            
            // Total de presenças
            $stats['total_presencas'] = $this->db->query(
                "SELECT COUNT(*) as total FROM presencas p
                 INNER JOIN inscricoes i ON p.turma_id = i.turma_id
                 WHERE i.aluno_id = ?",
                [$aluno_id]
            )->fetch()['total'];
            
            // Data de cadastro formatada (usar created_at se data_matricula não existir)
            $dataCadastro = $aluno['data_matricula'] ?? $aluno['created_at'];
            $aluno['data_cadastro_formatada'] = date('d/m/Y', strtotime($dataCadastro));
            
            echo $this->twig->render('perfil.twig', [
                'aluno' => $aluno,
                'stats' => $stats,
                'page' => 'perfil'
            ]);
            
        } catch (Exception $e) {
            echo "<h2>❌ Erro no Perfil</h2>";
            echo "<p>" . $e->getMessage() . "</p>";
        }
    }
}
?> 