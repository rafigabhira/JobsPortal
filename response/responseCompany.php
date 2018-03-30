<?php
session_start();

include '../connect.php';
if (!$dbconnection) {
    echo "Not Connected !";
}


$akta_error = $company_error = $telepon_error = $jalan_error = $kota_error = $provinsi_error = $kodePos_error = "";


$akta = $_POST['noAkta'];
$company = $_POST['namaCompany'];
$telepon = $_POST['nomorTelepon'];
$jalan = $_POST['namaJalan'];
$kota = $_POST['kota'];
$provinsi = $_POST['provinsi'];
$kodePos = $_POST['kodePos'];
$deskripsi = $_POST['deskripsi'];
$flag = true;


if (empty($akta)) {
    $akta_error = "Nomor Akta harus diisi";
    $flag = false;
} else {

    $cekAkta = "SELECT * FROM siloker.company WHERE no_akta = '$akta'";
    $query = pg_query($dbconnection, $cekAkta);
    if (pg_fetch_row($query) > 0) {
        $akta_error = "No Akta sudah ada, ganti yang lain";
        $flag = false;
    }
}

if (empty($company)) {
    $company_error = "Nama Company harus diisi";
    $flag = false;
}

if (empty($telepon)) {
    $telepon_error = "Nomor Telepon harus diisi";
    $flag = false;
} else {
    if (!preg_match("/^[0-9]{8,12}$/", $telepon)) {
        $telepon_error = "Nomor Telepon tidak sesuai";
        $flag = false;
    }
}

if (empty($jalan)) {
    $jalan_error = "Nama Jalan harus diisi";
    $flag = false;
}

if (empty($kota)) {
    $kota_error = "Nama Kota harus diisi";
    $flag = false;
}

if (empty($provinsi)) {
    $provinsi_error = "Nama Provinsi harus diisi";
    $flag = false;
}

if (empty($kodePos)) {
    $kodePos_error = "Kode Pos harus diisi";
    $flag = false;
} else {
    if (!preg_match("/^[0-9]{5}$/", $kodePos)) {
        $kodePos_error = "Kode Pos tidak sesuai";
        $flag = false;
    }
}

if ($flag) {

    $_SESSION['data'] = $_POST;
    echo json_encode(['code' => 200]);

} else {
    echo json_encode(['code' => 404, 'akta_error' => $akta_error, 'company_error' => $company_error, 'telepon_error' =>
        $telepon_error, 'jalan_error' => $jalan_error, 'kota_error' => $kota_error, 'provinsi_error' => $provinsi_error,
        'kodePos_error' => $kodePos_error]);
}



