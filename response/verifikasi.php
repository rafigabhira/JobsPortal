<?php
session_start();

include '../connect.php';

//Nanti harus pake Session PHP
$user_id = $_SESSION['username'];

$no_akta = $_POST['akta'];
$tipe = $_POST['tipe'];

if ($tipe == 'btn-verifikasi') {
    $query = "UPDATE siloker.company SET verified_by = '$user_id' WHERE no_akta = '$no_akta'";
    if (pg_query($dbconnection, $query)) {
    } else {
        echo "Error updating record: " . pg_errormessage($dbconnection);
    }
} else {
    $query = "UPDATE siloker.company SET verified_by = NULL WHERE no_akta = '$no_akta'";
    if (pg_query($dbconnection, $query)) {
    } else {
        echo "Error updating record: " . pg_errormessage($dbconnection);
    }
}
pg_close();

