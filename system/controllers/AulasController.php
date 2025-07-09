<?php

require_once __DIR__ . '/../core/Database.php';

use Ritmize\core\Database;

class AulasController {
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
            
            // Buscar turmas do aluno
            $turmas = $this->db->query(
                "SELECT t.*, i.data_inscricao
                 FROM turmas t
                 INNER JOIN inscricoes i ON t.id = i.turma_id
                 WHERE i.aluno_id = ? AND i.status = 'ativa'",
                [$aluno_id]
            )->fetchAll();
            
            // Buscar presenças recentes
            $presencas = $this->db->query(
                "SELECT p.*, t.nome
                 FROM presencas p
                 INNER JOIN turmas t ON p.turma_id = t.id
                 INNER JOIN inscricoes i ON t.id = i.turma_id
                 WHERE i.aluno_id = ?
                 ORDER BY p.data_aula DESC
                 LIMIT 10",
                [$aluno_id]
            )->fetchAll();
            
            echo $this->twig->render('aulas.twig', [
                'aluno' => $aluno,
                'turmas' => $turmas,
                'presencas' => $presencas,
                'page' => 'aulas'
            ]);
            
        } catch (Exception $e) {
            echo "<h2>❌ Erro nas Aulas</h2>";
            echo "<p>" . $e->getMessage() . "</p>";
        }
    }
}
?> 