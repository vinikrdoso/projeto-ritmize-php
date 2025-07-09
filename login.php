<?php
session_start();
error_reporting(E_ALL);
ini_set('display_errors', 1);

require_once 'vendor/autoload.php';
require_once 'system/core/Database.php';
require_once 'system/controllers/LoginController.php';

// Configurar timezone
date_default_timezone_set('Europe/Lisbon');

try {
    $controller = new LoginController();
    $controller->index();
    
} catch (Exception $e) {
    echo "<h2>❌ Erro no Login</h2>";
    echo "<p>" . $e->getMessage() . "</p>";
    echo "<p><a href='/'>← Voltar ao Dashboard</a></p>";
}
?> 