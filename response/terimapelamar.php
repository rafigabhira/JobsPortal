<?php

include "../connect.php";
if (!$dbconnection) {
    echo "Not Connected !";
}

$posisi_id = $_POST['posisi_id'];
$lowongan_id = $_POST['lowongan_id'];
$username = $_POST['username'];

$query = "UPDATE siloker.pelamaran SET status = 2 WHERE  username = '$username' AND lowongan_id = '$lowongan_id'
          AND posisi_id = '$posisi_id'";
if (pg_query($dbconnection,$query)){
    echo json_encode(['code' => 200]);
} else {
    echo json_encode(['code' => 404]);
}


