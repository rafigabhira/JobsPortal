<?php
session_start();

include '../connect.php';
if (!$dbconnection) {
    echo "Not Connected !";
}

$companyadmin = $_SESSION['data']['namaCompany'];
$akta = $_SESSION['data']['noAkta'];
$company = $_SESSION['data']['namaCompany'];
$telepon = $_SESSION['data']['nomorTelepon'];
$jalan = $_SESSION['data']['namaJalan'];
$kota = $_SESSION['data']['kota'];
$provinsi = $_SESSION['data']['provinsi'];
$kodePos = $_SESSION['data']['kodePos'];
$deskripsi = $_SESSION['data']['deskripsi'];

$username_error = $password_error = $namaLengkap_error = $noktp_error = $tgllahir_error = $nomorhp_error = $jalanadmin_error = $kotaadmin_error = $provinsiadmin_error = $posadmin_error = $admincompany_error = "";

$username = $_POST['username'];
$password = $_POST['password'];
$namaLengkap = $_POST['namaLengkap'];
$noktp = $_POST['noktp'];
$tgllahir = $_POST['tgllahir'];
$nomorhp = $_POST['nomorhp'];
$jalanadmin = $_POST['jalanadmin'];
$kotaadmin = $_POST['kotaadmin'];
$provinsiadmin = $_POST['provinsiadmin'];
$posadmin = $_POST['posadmin'];
$admincompany = $_POST['admincompany'];
$flag = true;


if (empty($username)) {
    $flag = false;
    $username_error = "Username harus diisi";
} else {
    $cekusername = "SELECT username FROM siloker.pengguna_admin WHERE username = '$username'";
    $cekusername2 = "SELECT username FROM siloker.pengguna_userumum WHERE username = '$username'";

    $query = pg_query($dbconnection, $cekusername);
    $query2 = pg_query($dbconnection, $cekusername2);
    if (pg_fetch_row($query) > 0 || pg_fetch_row($query2) > 0) {
        $flag = false;
        $username_error = "Username sudah ada, ganti yang lain";
    }
}

if (empty($password)) {
    $flag = false;
    $password_error = "Password harus diisi";
}

if (empty($namaLengkap)) {
    $flag = false;
    $namaLengkap_error = "Nama Lengkap harus diisi";
}

if (empty($noktp)) {
    $flag = false;
    $noktp_error = "Nomor KTP harus diisi";
} else {
    $ktpCek = "SELECT * FROM siloker.pengguna_admin WHERE no_ktp = '$noktp'";
    $query = pg_query($dbconnection, $ktpCek);
    if (pg_fetch_row($query) > 0) {
        $flag = false;
        $noktp_error = "Nomor KTP sudah ada, ganti yang lain";
    }

    if (!preg_match("/^[0-9\-]{10,16}$/", $noktp)) {
        $flag = false;
        $noktp_error = "Format Nomor KTP salah";
    }
}

if (empty($tgllahir)) {
    $flag = false;
    $tgllahir_error = "Tanggal harus diisi";
}

if (empty($nomorhp)) {
    $flag = false;
    $nomorhp_error = "Nomor HP harus diisi";
} else {
    if (!preg_match("/^[0-9]{8,12}$/", $nomorhp)) {
        $flag = false;
        $nomorhp_error = "Nomor HP tidak sesuai";
    }
}

if (empty($jalanadmin)) {
    $flag = false;
    $jalanadmin_error = "Nama Jalan harus diisi";
}

if (empty($kotaadmin)) {
    $flag = false;
    $kotaadmin_error = "Nama Kota harus diisi";
}

if (empty($provinsiadmin)) {
    $flag = false;
    $provinsiadmin_error = "Nama Provinsi harus diisi";
}

if (empty($posadmin)) {
    $flag = false;
    $posadmin_error = "Kode Pos harus diisi";
} else {
    if (!preg_match("/^[0-9]{5}$/", $posadmin)) {
        $flag = false;
        $posadmin_error = "Kode Pos tidak sesuai";
    }
}

if ($admincompany != "True") {
    $flag = false;
    $admincompany_error = "Harap pilih True";
}

if ($flag) {
    $companyQuery = "INSERT INTO siloker.company (no_akta, namacompany, no_telp, nama_jalan, provinsi, kota,
                         kodepos, deskripsi, verified_by) VALUES ('$akta','$companyadmin','$telepon','$jalan',
                        '$provinsi','$kota','$kodePos','$deskripsi', NULL )";
    $result = pg_query($dbconnection, $companyQuery);

    $timestamp = date('G:i:s');
    $tgllahir = $tgllahir . " " . $timestamp;

    $adminQuery = "INSERT INTO siloker.pengguna_admin (username, password, nama, no_ktp, tgl_lahir, no_hp,
                       nama_jalan, provinsi, kota, kodepos, flagadmincompany, company_pendaftar) VALUES ('$username',
                       '$password','$namaLengkap','$noktp','$tgllahir','$nomorhp','$jalanadmin','$provinsiadmin',
                       '$kotaadmin','$posadmin','$admincompany','$akta')";
    $result = pg_query($dbconnection, $adminQuery);

    unset($_SESSION['data']);
    pg_close();
    echo json_encode(['code' => 200]);
} else {
    echo json_encode(['code' => 404, 'username_error' => $username_error, 'password_error' => $password_error, 'namaLengkap_error' =>
        $namaLengkap_error, 'noktp_error' => $noktp_error, 'tgllahir_error' => $tgllahir_error, 'nomorhp_error' => $nomorhp_error,
        'jalanadmin_error' => $jalanadmin_error, 'kotaadmin_error' => $kotaadmin_error, 'provinsiadmin_error' => $provinsiadmin_error,
        'posadmin_error' => $posadmin_error, 'admincompany_error' => $admincompany_error]);
}

