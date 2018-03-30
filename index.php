<?php
session_start();

include 'navigationBar.php';
?>
<!DOCTYPE html>
<html>
<head>
    <title>SILOKER</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link rel="stylesheet" href="src/css/index.css">
</head>
<body>
<div class="container" style="margin-top: 40px;">
    <div class="jumbotron">
        <h1 class="display-4" style="color: dimgrey">Welcome to Loker Kerja<span
                    style="color: #21D4FD"><?php if (isset($_SESSION["username"])) {
                    echo '<span style="color: dimgrey;">, </span>';
                    echo $_SESSION["username"];
                } ?></span> !</h1>
        <p class="lead" style="color: cornflowerblue">Your Portal to Find Job</p>
        <hr class="my-4">
        <p style="color: #979A9A">Semua yang Anda butuhkan untuk mempermudah pencarian pekerjaan, ada dalam satu tempat.
            Pencari kerja dapat menemukan pekerjaan dari berbagai portal lowongan dan perusahaan dapat mendistribusikan
            informasi lowongan ke berbagai portal lowongan dalam satu waktu.</p>
        <p class="lead">
            <a class="btn btn-primary btn-lg" href="daftarPerusahaan.php" role="button">Lihat Perusahaan</a>
        </p>
    </div>
</div>
</body>


