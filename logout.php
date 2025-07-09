<?php
session_start();

// Destruir todas as variáveis da sessão
$_SESSION = array();

// Se é desejado matar a sessão, então os cookies de sessão também devem ser apagados.
if (ini_get("session.use_cookies")) {
    $params = session_get_cookie_params();
    setcookie(session_name(), '', time() - 42000,
        $params["path"], $params["domain"],
        $params["secure"], $params["httponly"]
    );
}

// Finalmente, destruir a sessão
session_destroy();

// Redirecionar para a página de login
header("Location: login.php");
exit();
?> 