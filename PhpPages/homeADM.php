<!DOCTYPE html>
<html>
<head>
	<title>Exemplo de consulta com botão</title>
	<style>
		table, th, td {
			border: 1px solid black;
			border-collapse: collapse;
			padding: 5px;
		}
	</style>
</head>
<body>
	<h1>Exemplo de consulta com botão</h1>
	<form method="post">
		<input type="submit" name="submit" value="Mostrar todas as experiências">
	</form>
	<?php
//Passa os dados da conexão da página anterior
session_start();
$servername = $_SESSION['servername'];
$username = $_SESSION['username'];
$password = $_SESSION['password'];
$dbname = $_SESSION['dbname'];


		// Realizar a consulta 
		if(isset($_POST["submit"])) {
			// Informações de conexão com a base de dados
			// Cria a conexão
			$conn = new mysqli($servername, $username, $password, $dbname);

			// Verifica a conexão
			if ($conn->connect_error) {
			    die("Conexão falhou: " . $conn->connect_error);
			}

			// Consulta através de sql
			$sql = "SELECT * FROM experiencia;";
			$result = $conn->query($sql);

			// Se a consulta retornar resultados, mostrar numa tabela
			if ($result->num_rows > 0) {
				echo "<table>";
				echo "<tr><th>IDExperiencia</th><th>Descricao</th><th>EmailInvestigador</th><th>Data e Hora</th><th>Número de Ratos</th><th>Limite de Ratos por Sala</th><th>Segundos Sem Movimento</th><th>Temperatura Ideal</th><th>Variação Máxima de Temperatura</th><th>Ativa</th></tr>";
				while($row = $result->fetch_assoc()) {
					echo "<tr><td>" . $row["IDexperiência"] . "</td><td>" . $row["Descricao"] . "</td><td>" . $row["Investigador"] . "</td><td>".  $row["DataHora"] . "</td><td>" . $row["NumeroRatos"] . "</td><td>" . $row["LimiteRatosSala"] . "</td><td>" . $row["SegundosSemMovimento"] . "</td><td>" . $row["TemperaturaIdeal"] . "</td><td>" . $row["VariacaoTemperaturaMaxima"] . "</td><td>" . $row["Ativa"] . "</tr>";
				}
				echo "</table>";
			} else {
				echo "Não foram encontrados resultados.";
			}

			// Fecha a conexão
			$conn->close();
		}
	?>
</body>
</html>
