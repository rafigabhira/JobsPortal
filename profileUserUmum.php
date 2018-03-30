<?php
session_start();
include 'navigationBar.php';
include 'connect.php';
?>
<!DOCTYPE HTML>
<html>
<head>
    <title>Profile User Umum
    </title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link rel="stylesheet" href="src/css/index.css">

</head>

<body>


<?php

echo "Username          : $_SESSION[username]<br>";
echo "Nama lengkap      : $_SESSION[nama]<br>";
echo "No. KTP           : $_SESSION[no_ktp]<br>";

$tanggal_lahir = explode(" ", $_SESSION['tgl_lahir']);
echo "Tanggal Lahir 	: $tanggal_lahir[0]<br>";
echo "No. HP			: $_SESSION[no_hp]<br>";
echo "Alamat			: $_SESSION[nama_jalan] , $_SESSION[kota] , $_SESSION[provinsi]<br>";
echo "CV				: $_SESSION[cv]<br>";

echo "<br>History Pelamaran<br>";

$output = "";
$query = "SELECT p.namaPosisi,p.gaji,p.email_hrd,p.jml_penerima_saatini,p.max_jml_penerima,pe.status FROM siloker.posisi p,siloker.pelamaran pe where pe.username='$_SESSION[username]' and pe.posisi_id=p.posisi_id and pe.lowongan_id=p.lowongan_id    ";

$result = pg_query($dbconnection, $query);
while ($row = pg_fetch_array($result)) {

    $output .= "<div class='card'>" . "<h5>" . $row['namaposisi'] . "</h5>" . "Rp." . $row['gaji'] . "/month<br>" . "HRD: " . $row['email_hrd'] . "<br>" . $row['jml_penerima_saatini'] . "/" . $row['max_jml_penerima'] . " orang<br>";

    if ($row['status'] == 1) {
        $output .= "melamar";
    } else if ($row['status'] == 2) {
        $output .= "diterima";
    } else if ($row['status'] == 3) {
        $output .= "ditolak";
    } else if ($row['status'] == 4) {
        $output .= "sudah berhenti bermitra";
    }


    $output .= "</div>";

}

echo $output;
?>


</body>


