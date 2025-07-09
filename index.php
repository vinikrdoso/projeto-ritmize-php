<?php
/**
 * RITMIZE - Dashboard Principal
 */

session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'vendor/autoload.php';
require_once 'system/core/Database.php';
require_once 'system/controllers/DashboardController.php';

// Configurar timezone
date_default_timezone_set('Europe/Lisbon');

// Simulação de autenticação para teste
if (!isset($_SESSION['aluno_id'])) {
    $_SESSION['aluno_id'] = 1; // João para teste
}

try {
    // Carregar dashboard diretamente
    $controller = new DashboardController();
    $controller->index();
    
} catch (Exception $e) {
    echo "<h2>❌ Erro no Sistema</h2>";
    echo "<p><strong>Mensagem:</strong> " . $e->getMessage() . "</p>";
    echo "<p><strong>Arquivo:</strong> " . $e->getFile() . "</p>";
    echo "<p><strong>Linha:</strong> " . $e->getLine() . "</p>";
    echo "<hr>";
    echo "<h3>🔧 Debug Info:</h3>";
    echo "<p><strong>PHP Version:</strong> " . phpversion() . "</p>";
    echo "<p><strong>Working Directory:</strong> " . getcwd() . "</p>";
    echo "<p><strong>Include Path:</strong> " . get_include_path() . "</p>";
    
    // Verificar se arquivos existem
    echo "<h4>📁 Arquivos necessários:</h4>";
    $files = [
        'vendor/autoload.php',
        'system/core/Database.php', 
        'system/controllers/DashboardController.php',
        'templates/base.twig',
        'templates/dashboard.twig'
    ];
    
    foreach($files as $file) {
        $exists = file_exists($file) ? "✅" : "❌";
        echo "<p>$exists $file</p>";
    }
}
?> 