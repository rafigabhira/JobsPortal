<?php
session_start();
$output = "";
include '../connect.php';

$username = $_SESSION['username'];
$posisi_id = $_POST['posisi_id'];
$jml_now = $_POST['jml_now'];
$max_jml = $_POST['max_jml'];
$diterima = $_POST['diterima'];
$lowongan_id = $_POST['lowongan_id'];

function lamar($username, $posisi_id, $lowongan_id)
{
    global $dbconnection;
    pg_query($dbconnection, "INSERT INTO siloker.pelamaran(username, lowongan_id, posisi_id, status, user_rating) VALUES ('$username', '$lowongan_id', '$posisi_id', 1, NULL)");
}

if (!isset($_SESSION['username']) || !isset($_SESSION['password'])) {
    echo json_encode(['code' => 'mustLogin']);
    exit();
} else if (isset($_SESSION['tipe'])) {
    echo json_encode(['code' => 'errorAdmin']);
    exit();
} else if ($diterima == 'yes') {
    echo json_encode(['code' => 'sudahDiterima']);
    exit();
} else if ($jml_now >= $max_jml) {
    echo json_encode(['code' => 'overload']);
    exit();
} else {
    echo json_encode(['code' => 'success']);
    lamar($username, $posisi_id, $lowongan_id);
}

