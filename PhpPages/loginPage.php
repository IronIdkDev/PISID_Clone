<!DOCTYPE html>
<html>
  <head>
    <title>Página de login</title>
    <link rel="stylesheet" type="text/css" href="style.css">
    <script src="script.js"></script>
  </head>
  <body>
    <?php
      session_start(); // inicia a sessão
      if (isset($_SESSION["error"])) { // verifica se a variável de sessão existe
        echo "<p style='color:red'>" . $_SESSION["error"] . "</p>"; // mostra a mensagem de erro em vermelho
        unset($_SESSION["error"]); // remove a variável de sessão
      }
    ?>
    <h2>Login</h2>
    <form method="post" action="login.php">
      <label for="username">Nome de usuário:</label>
      <input type="text" id="username" name="username">
      <label for="password">Senha:</label>
      <input type="password" id="password" name="password">
      <input type="submit" value="Login">
    </form>
  </body>
</html>
