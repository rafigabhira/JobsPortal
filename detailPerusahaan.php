<?php
session_start();
include 'connect.php';
include 'navigationBar.php';


$akta = $_GET['akta'];

function fetchDetail()
{
    global $dbconnection;
    global $akta;
    $query = "SELECT * FROM siloker.company WHERE no_akta = '$akta' ";
    $result = pg_query($dbconnection, $query);
    $output = "";
    while ($row = pg_fetch_array($result)) {
        $output .= "<div style='background-color: white; padding: 20px; border-radius: 3px;'>";
        $output .= "<h2 style='font-weight: bold; color: dimgray;'>" . $row['namacompany'] . "</h2><br>";
        $output .= "<p class='detilperusahaan'><span>Nomor Akta</span>: " . $row['no_akta'] . "</p>";
        $output .= "<p class='detilperusahaan'><span>Nomor Telepon</span>: " . $row['no_telp'] . "</p>";
        $output .= "<p class='detilperusahaan'><span>Nama Jalan</span>: " . $row['nama_jalan'] . "</p>";
        $output .= "<p class='detilperusahaan'><span>Nama Provinsi</span>: " . $row['provinsi'] . "</p>";
        $output .= "<p class='detilperusahaan'><span>Nama Kota</span>: " . $row['kota'] . "</p>";
        $output .= "<p class='detilperusahaan'><span>Kode Pos</span>: " . $row['kodepos'] . "</p>";
        $output .= "<p class='detilperusahaan'>" . $row['deskripsi'] . "</p>";
        $output .= "</div>";
    }
    $output .= fectLowongan();
    echo $output;
}

function fectLowongan()
{
    global $dbconnection;
    global $akta;
    $query = "SELECT * FROM siloker.lowongan WHERE company = '$akta' ";
    $result = pg_query($dbconnection, $query);
    $output = "";
    $output .= "<br><h4 id='h4lowongan'>Lowongan</h4>
        <hr class='hr-title'>";

    $output .= "<div class='row d-flex justify-content-start' id='lowongan' style='margin-top: -20px;'>";
    if (pg_num_rows($result) < 1) {
        $output .= "<h5 style='color: ghostwhite; margin: auto; margin-top: 20px;'>Belum ada Lowongan</h5>";

    } else {
        while ($row = pg_fetch_array($result)) {
            $output .= "<div class='card'>
                <div class='card-body'>";
            $output .= "<p style='font-weight: bold; color: dimgrey'>" . $row['namalowongan'] . "</p>";

            $tgl_buka = explode(" ", $row['tgl_buka']);
            $tgl_tutup = explode(" ", $row['tgl_tutup']);

            $output .= "<p class='detillowongan'><span>Tanggal Buka</span> : <span style='color: #2FBB7B;'>" . $tgl_buka[0] . "</span></p>";
            $output .= "<p class='detillowongan'><span>Tanggal Tutup</span>: <span style='color: orangered;'>" . $tgl_tutup[0] . "</span></p>";
            $output .= "<div class='row d-flex justify-content-center'><a href='posisi.php?lowongan-id=" . $row['lowongan_id'] . "&akta=" . $akta . "' class='btn btn-info' style='border-radius: 3px;'>Lihat Posisi</a></div>";
            $output .= "</div></div>";
        }
    }
    $output .= "</div>";
    return $output;
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Daftar Lowongan</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link rel="stylesheet" href="src/css/index.css">
</head>
<body>
<div class="container">
    <div id="detail-company">
        <a href="daftarPerusahaan.php" class='btn btn-link' style='color: white; padding: 0; margin-bottom: 20px;'>&lt;
            Kembali ke Daftar</a>
        <?php
        if (!$dbconnection) {
            echo "Not Connected !";
        } else {
            fetchDetail();
        }
        ?>
    </div>
</div>
</body>
<script src="https://code.jquery.com/jquery-3.2.1.js" integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE="
        crossorigin="anonymous"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"
        integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh"
        crossorigin="anonymous"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"
        integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"
        crossorigin="anonymous"></script>
</html>
