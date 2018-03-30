<?php
session_start();
$output = "";
include '../connect.php';

$output = "";
if (!$dbconnection) {
    $output = "Not Connected !";
}

if ($_SESSION['tipe'] == 'admin') {
    $query = "SELECT * FROM siloker.company ORDER BY namacompany ASC, kota ASC";
} else {
    $query = "SELECT * FROM siloker.company WHERE verified_by NOTNULL ORDER BY namacompany ASC, kota ASC";
}
$queryAkta = "SELECT company_pendaftar FROM siloker.pengguna_admin WHERE username = '" . $_SESSION['username'] . "'";
$aktaUser = pg_fetch_array(pg_query($dbconnection, $queryAkta));


$result = pg_query($dbconnection, $query);
$no = 1;
while ($row = pg_fetch_array($result)) {

    $output .= "<div class='card'";
    if ($row['no_akta'] == $aktaUser[0]) {
        $output .= "style='background-color: #FFFB7D;'";
    }
    $output .= "><div class='card-body'>
                    <p class='card-text' style='font-size:15px;color: lightblue; margin-bottom: -20px; margin-right: 0; text-align:right;'>" . $no++ . "</p>
                    <h5 class='card-title'><span></span>" . $row['namacompany'] . "</h5>";

    if ($row['no_akta'] == $aktaUser[0]) {
        $output .= " <p class='card-text' style='color: black; margin-bottom: 30px'>" . $row['kota'] . " <span class='badge badge-success'>My Company</span></p>";
    } else {
        $output .= " <p class='card-text' style='color: silver; margin-bottom: 30px'>" . $row['kota'] . "</p>";
    }

    if ($_SESSION['tipe'] == 'admin') {

        if ($row["verified_by"] == null) {
            $output .= "<button data-akta='" . $row['no_akta'] . "' id='btn-verifikasi' class='btn btn-success btn-sm' style='position:absolute; bottom:0;  margin-bottom:0; left: 0; width: 112px;'>Verifikasi</button>";
        } else {
            $output .= "<button data-akta='" . $row['no_akta'] . "' id='btn-unverifikasi' class='btn btn-warning btn-sm' style='position:absolute; bottom:0;  margin-bottom:0; left: 0; width: 112px;'>Unverifikasi</button>";
        }
        $output .= "<a href='detailPerusahaan.php?akta=" . $row['no_akta'] . "' class='btn btn-info btn-sm' style='position:absolute; bottom:0;  margin-bottom:0; right: 0; width: 112px;'>Lihat</a> </div> </div>";
    } else {

        if ($row['no_akta'] == $aktaUser[0]) {
            $output .= "<a href='profileCompany.php' class='btn btn-info btn-sm' style='position:absolute; bottom:0;  margin-bottom:0; right: 0; width: 224px; border-radius: 0 0 3px 3px;'>Lihat</a> </div> </div>";
        } else {
            $output .= "<a href='detailPerusahaan.php?akta=" . $row['no_akta'] . "' class='btn btn-info btn-sm' style='position:absolute; bottom:0;  margin-bottom:0; right: 0; width: 224px; border-radius: 0 0 3px 3px;'>Lihat</a> </div> </div>";
        }
    }
}
pg_close();

echo $output;
