<?php

session_start();
include 'connect.php';
include 'navigationBar.php';
function fetchLowongan()
{
    $output = "";
    $query = "SELECT * FROM siloker.lowongan, siloker.company WHERE verified_by NOTNULL AND lowongan.company = company.no_akta ORDER BY lowongan.tgl_buka DESC ";

    global $dbconnection;
    $result = pg_query($dbconnection, $query);
    while ($row = pg_fetch_array($result)) {
        $output .= "<div class='card' style='width: 280px;'>
                    <div class='card-body'>";
        $output .= "<p style='font-weight: bold; color: dimgrey'>" . $row['namalowongan'] . "</p>";

        $tgl_buka = explode(" ", $row['tgl_buka']);
        $tgl_tutup = explode(" ", $row['tgl_tutup']);

        $output .= "<p class='detillowongan'><span>Tanggal Buka</span> : <span style='color: #2FBB7B;'>" . $tgl_buka[0] . "</span></p>";
        $output .= "<p class='detillowongan'><span>Tanggal Tutup</span>: <span style='color: orangered;'>" . $tgl_tutup[0] . "</span></p>";
        $output .= "<hr>";
        $output .= "<div class='row d-flex justify-content-center'><a href='detailPerusahaan.php?akta=" . $row['no_akta'] . "' class='detillowongan' style='font-weight: bold; color: black; text-align: center;'>" . $row['namacompany'] . "</a></div><br>";
        $output .= "<div class='row d-flex justify-content-center'><a href='posisi.php?lowongan-id=" . $row['lowongan_id'] . "' class='btn btn-info' data-lowongan='" . $row['lowongan_id'] . "' id='lihatposisi' style='border-radius: 3px; color: white;'>Lihat Posisi</a></div>";
        $output .= "</div></div>";
    }
    echo $output;
    pg_close();
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
    <h4>Lowongan</h4>
    <hr class="hr-title">
    <div class="row d-flex justify-content-center" id="data-lowongan">
        <?php
        if (!$dbconnection) {
            echo "Not Connected !";
        } else {
            fetchLowongan();
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
