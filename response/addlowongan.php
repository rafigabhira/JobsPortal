<?php
session_start();

include '../connect.php';
if (!$dbconnection) {
    echo "Not Connected !";
}

$idlowongan_error = $namalowongan_error = $tglbuka_error = $tgltutup_error = "";

$akta = $_SESSION['company_pendaftar'];

$idlowongan = $_POST['idlowongan'];
$namalowongan = $_POST['namalowongan'];
$tglbuka = $_POST['tglbuka'];
$tgltutup = $_POST['tgltutup'];

$flag = true;


if (empty($idlowongan)) {
    $idlowongan_error = "ID Lowongan harus diisi";
    $flag = false;
} else {

    if (strlen($idlowongan) > 6 || strlen($idlowongan) < 6 || preg_match('/\s/', $idlowongan)) {
        $idlowongan_error = "ID harus terdiri dari 6 Huruf/Angka";
    }

    $cekID = "SELECT * FROM siloker.lowongan WHERE lowongan_id = '$idlowongan'";
    $query = pg_query($dbconnection, $cekID);
    if (pg_fetch_row($query) > 0) {
        $idlowongan_error = "ID Lowongan sudah ada, ganti yang lain";
        $flag = false;
    }
}

if (empty($namalowongan)) {
    $namalowongan_error = "Nama Lowongan harus diisi";
    $flag = false;
}

if (empty($tglbuka)) {
    $tglbuka_error = "Tanggal Buka harus diisi";
    $flag = false;
} else {
    if (!preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $tglbuka)) {
        $flag = false;
        $tglbuka_error = "Format Tanggal salah &nbsp";
    }
}

if (empty($tgltutup)) {
    $tgltutup_error = "Tanggal Tutup harus diisi";
    $flag = false;
} else {
    if (!preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $tgltutup)) {
        $flag = false;
        $tgltutup_error = "Format Tanggal salah &nbsp";
    } else if (preg_match("/^[0-9]{4}-(0[1-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/", $tgltutup)) {
        $timestamp = date('G:i:s');
        $tglbuka = $tglbuka . " " . $timestamp;
        $tgltutup = $tgltutup . " " . $timestamp;
        if ($tgltutup < $tglbuka) {
            $flag = false;
            $tgltutup_error = "Tanggal tutup tidak boleh sebelum Tanggal Buka &nbsp";
        }
    }
}


if ($flag) {

    $insertLowongan = "INSERT INTO siloker.lowongan (lowongan_id, namalowongan, tgl_buka, tgl_tutup, company) VALUES  ('$idlowongan','$namalowongan','$tglbuka','$tgltutup','$akta')";
    $result = pg_query($dbconnection, $insertLowongan);


    $query = "SELECT * FROM siloker.lowongan WHERE company = '$akta' ";
    $result = pg_query($dbconnection, $query);
    $output = "";
    if (pg_num_rows($result) < 1) {
        $output .= "<h5 style='color: ghostwhite; margin: auto;'>Belum ada Lowongan</h5>";

    } else {

        while ($row = pg_fetch_array($result)) {
            $output .= "<div class='card'>
                <div class='card-body'>";
            $output .= "<p style='font-weight: bold; color: dimgrey'>" . $row['namalowongan'] . "</p>";

            $tgl_buka = explode(" ", $row['tgl_buka']);
            $tgl_tutup = explode(" ", $row['tgl_tutup']);

            $output .= "<p class='detillowongan'><span>Tanggal Buka</span> : <span style='color: #2FBB7B;'>" . $tgl_buka[0] . "</span></p>";
            $output .= "<p class='detillowongan'><span>Tanggal Tutup</span>: <span style='color: orangered;'>" . $tgl_tutup[0] . "</span></p>";
            $output .= "<div class='row d-flex justify-content-center'><a href='DaftarPosisiByAdmin.php?lowongan-id=" . $row['lowongan_id'] . "&akta=" . $akta . "' class='btn btn-info' style='border-radius: 3px; '>Lihat Posisi</a></div>";
            $output .= "</div></div>";
        }
    }
    $output .= "</div>";

    echo json_encode(['code' => 200, 'output' => $output]);

} else {
    echo json_encode(['code' => 404, 'idlowongan_error' => $idlowongan_error, 'namalowongan_error' => $namalowongan_error, 'tglbuka_error' =>
        $tglbuka_error, 'tgltutup_error' => $tgltutup_error]);
}



