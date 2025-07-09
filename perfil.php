<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'vendor/autoload.php';
require_once 'system/core/Database.php';
require_once 'system/controllers/PerfilController.php';

// Configurar timezone
date_default_timezone_set('Europe/Lisbon');

// Simulação de autenticação para teste
if (!isset($_SESSION['aluno_id'])) {
    $_SESSION['aluno_id'] = 1; // João para teste
}

try {
    $controller = new PerfilController();
    $controller->index();
    
} catch (Exception $e) {
    echo "<h2>❌ Erro no Perfil</h2>";
    echo "<p>" . $e->getMessage() . "</p>";
    echo "<p><a href='/'>← Voltar ao Dashboard</a></p>";
}
?> 