<?php

require_once __DIR__ . '/../core/Database.php';

use Ritmize\core\Database;

class LoginController {
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
        // Se já está logado, redirecionar para dashboard
        if (isset($_SESSION['aluno_id'])) {
            header('Location: /');
            exit;
        }

        $erro = '';

        // Processar login
        if ($_POST) {
            $email = $_POST['email'] ?? '';
            $senha = $_POST['senha'] ?? '';
            
            if (empty($email) || empty($senha)) {
                $erro = 'Por favor, preencha todos os campos.';
            } else {
                try {
                    // Buscar aluno por email
                    $aluno = $this->db->query(
                        "SELECT * FROM alunos WHERE email = ? AND status = 'ativo'",
                        [$email]
                    )->fetch();
                    
                    if ($aluno && $aluno['senha'] === $senha) { // Comparação simples por enquanto
                        $_SESSION['aluno_id'] = $aluno['id'];
                        $_SESSION['aluno_nome'] = $aluno['nome'];
                        
                        header('Location: /');
                        exit;
                    } else {
                        $erro = 'Email ou senha incorretos.';
                    }
                    
                } catch (Exception $e) {
                    $erro = 'Erro interno do sistema. Tente novamente.';
                }
            }
        }

        // Renderizar template
        echo $this->twig->render('login.twig', [
            'erro' => $erro,
            'email' => $_POST['email'] ?? '',
            'page' => 'login'
        ]);
    }
} 