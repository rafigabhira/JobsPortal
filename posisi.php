<?php
/**
 * Created by PhpStorm.
 * User: rafiagabhira
 * Date: 17/12/17
 * Time: 02.01
 */
session_start();
include 'connect.php';
include 'navigationBar.php';

$lowongan_id = $_GET['lowongan-id'];


function fectPosisi()
{
    global $lowongan_id;
    global $dbconnection;

    //cek username udh diterima apa belum di perusahaan lain
    $query = "SELECT 1 FROM siloker.pelamaran WHERE status = '2' AND username = '" . $_SESSION['username'] . "' ";
    $result = pg_query($dbconnection, $query);
    $diterima = "";
    $sudahditerima = pg_num_rows($result);
    if ($sudahditerima) {
        $diterima = 'yes';
    }
    echo "<script>console.log($sudahditerima)</script>";

    $query = "SELECT * FROM siloker.posisi WHERE lowongan_id = '$lowongan_id' ";
    $result = pg_query($dbconnection, $query);
    $output = "";
    if (pg_num_rows($result) < 1) {
        $output .= "<h5 style='color: ghostwhite; text-align: center; '>Belum ada Posisi</h5>";
    } else {
        $output .= "<div class='row d-flex justify-content-start' id='lowongan' style='margin-top: -20px;'>";

        while ($row = pg_fetch_array($result)) {
            $output .= "<div class='card' style='width: 300px;'>
                <div class='card-body'>";
            $output .= "<p style='font-weight: bold; color: dimgrey'>" . $row['namaposisi'] . "</p>";

            $output .= "<p class='detilposisi'><span>Gaji</span> : Rp " . $row['gaji'] . " / bulan</p>";
            $output .= "<p class='detilposisi'><span>HRD</span> : " . $row['email_hrd'] . "</p>";

            if ($row['jml_penerima_saatini'] >= $row['max_jml_penerima']) {
                $output .= "<p class='detilposisi'><span>Diterima saat ini</span> : <span class='jmlpenerimalebih'>" . $row['jml_penerima_saatini'] . "/" . $row['max_jml_penerima'] . "</span></p>";
            } else {
                $output .= "<p class='detilposisi'><span>Diterima saat ini</span> : <span class='jmlpenerima'>" . $row['jml_penerima_saatini'] . "/" . $row['max_jml_penerima'] . "</span></p>";
            }

            $output .= "</div>";

            $query = "SELECT * FROM siloker.pelamaran WHERE posisi_id = '" . $row['posisi_id'] . "' AND username = '" . $_SESSION['username'] . "'";
            $result = pg_query($dbconnection, $query);

            if (pg_fetch_array($result) > 1) {
                $output .= "<button class='btn btn-danger'  style='border-radius: 0 0 3px 3px;' disabled>Sudah Melamar</button>";
            } else {
                $output .= "<button class='btn btn-warning' data-lamar='" . $row['posisi_id'] . " " . $row['jml_penerima_saatini'] . " " . $row['max_jml_penerima'] . " " . $diterima . " " . $lowongan_id . "' id='melamar' style='border-radius: 0 0 3px 3px;'>Lamar</button>";
            }

            $output .= "</div>";
        }
    }
    $output .= "</div>";
    return $output;
}

function fectLowongan()
{

    global $lowongan_id;
    global $dbconnection;
    $query = "SELECT * FROM siloker.lowongan WHERE lowongan_id = '$lowongan_id' ";
    $result = pg_query($dbconnection, $query);
    $output = "";
    while ($row = pg_fetch_array($result)) {

        $output .= "<div style='background-color: white; padding: 20px; border-radius: 3px;'>";
        $output .= "<h2 style='font-weight: bold; text-align: center; color: dimgray;'>Lowongan : " . $row['namalowongan'] . "</h2><br>";
        $output .= "<p class='detilperusahaan'><span>ID Lowongan</span>: " . $row['lowongan_id'] . "</p>";
        $output .= "<p class='detilperusahaan'><span>Nama Lowongan</span>: " . $row['namalowongan'] . "</p>";
        $tgl_buka = explode(" ", $row['tgl_buka']);
        $tgl_tutup = explode(" ", $row['tgl_tutup']);

        $output .= "<p class='detilperusahaan'><span>Tanggal Buka</span>: " . $tgl_buka[0] . "</p>";
        $output .= "<p class='detilperusahaan'><span>Tanggal Tutup</span>: " . $tgl_tutup[0] . "</p>";
        $output .= "</div>";
    }
    $output .= "<br><h4 id='h4lowongan'>Posisi<span></span></h4>
        <hr class='hr-title'>";

    $output .= fectPosisi();
    echo $output;
}

?>

<!DOCTYPE html>
<html>
<head>
    <title>Posisi</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link href="src/open-iconic/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="src/css/index.css">
</head>
<body>
<div class="container">
    <h4></h4>
    <?php
    if (isset($_GET['akta'])) {
        echo "<a href='detailPerusahaan.php?akta=" . $_GET['akta'] . "' class='btn btn-link' style='color: white; padding: 0; margin-bottom: 20px;'>&lt; Kembali ke Perusahaan</a>";
    } else {
        echo "<a href='Lowongan.php' class='btn btn-link' style='color: white; padding: 0; margin-bottom: 20px;'>&lt; Kembali ke Daftar</a>";
    }
    ?>

    <div id="data-lowongan">
        <?php
        if (!$dbconnection) {
            echo "Not Connected !";
        } else {
            fectLowongan();
        }
        ?>
    </div>
    <div class="modal fade" id="modalerror" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" style="color: red"><span
                                class="oi oi-circle-x"></span> Error</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div id="isimodal" class="modal-body" style="font-weight: bold;">
                </div>
                <div id="loginmodal">

                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="modalsuccess" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" style="color: green"><span
                                class="oi oi-circle-check"></span> Success</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" style="font-weight: bold;">
                    Selamat ! Anda telah berhasil melamar
                </div>

            </div>
        </div>
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
<script>
    $(document).ready(function () {
        $(document).on('click', '#melamar', function () {
            var data = $(this).data('lamar');
            var split = data.split(" ");
            var posisi_id = split[0];
            var jml_now = split[1];
            var max_jml = split[2];
            var diterima = split[3];
            var lowongan_id = split[4];
            $.ajax({
                url: "response/lamar.php",
                method: "POST",
                data: {
                    posisi_id: posisi_id,
                    jml_now: jml_now,
                    max_jml: max_jml,
                    diterima: diterima,
                    lowongan_id: lowongan_id
                },
                dataType: "JSON",
                success: function (data) {
                    if (data.code === "mustLogin") {
                        $('#loginmodal').html('<div class="modal-footer"><a href="login.php" class="btn btn-secondary" style="border-radius: 3px;">Login</a></div>');
                        $('#isimodal').html('Anda harus login terlebih dahulu');
                        $('#modalerror').modal('toggle');
                    } else if (data.code === "errorAdmin") {
                        $('#isimodal').html('Admin tidak dapat melakukan pelamaran !');
                        $('#modalerror').modal('toggle');
                    } else if (data.code === "sudahDiterima") {
                        $('#isimodal').html('Anda tidak dapat melakukan pelamaran karena sudah diterima di Perusahaan lain !');
                        $('#modalerror').modal('toggle');
                    } else if (data.code === "overload") {
                        $('#isimodal').html('Jumlah penerimaan sudah penuh ! Cari lowongan lain');
                        $('#modalerror').modal('toggle');
                    } else if (data.code === "success") {
                        $('#modalsuccess').modal('toggle');
                        $('#melamar').removeClass('btn btn-warning').addClass('btn btn-danger').attr("disabled", "disabled").html('Sudah Melamar');
                    }
                }
            });
        });
    });
</script>
</html>
