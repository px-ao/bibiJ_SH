<?php
$host="localhost";
$port=3306;
$socket="";
$user="root";
$password="1212";
$dbname="dbbibj";

$con = new mysqli($host, $user, $password, $dbname, $port, $socket)
    or die ('Could not connect to the database server' . mysqli_connect_error());

$testamento = isset($_GET['testamento']) ? $_GET['testamento'] : 'A';

$sql = "SELECT id, nome, abreviaturanome FROM tlivros WHERE testamento = ? ORDER BY ordemlivros";
$stmt = $con->prepare($sql);
$stmt->bind_param("s", $testamento);
$stmt->execute();
$result = $stmt->get_result();

$livros = [];
while ($row = $result->fetch_assoc()) {
    $livros[] = $row;
}
$stmt->close();
$con->close();

header('Content-Type: application/json; charset=utf-8');
echo json_encode($livros);
?>