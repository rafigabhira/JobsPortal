<?php
session_start();
include 'connect.php';
include 'navigationBar.php';


$akta = $_SESSION['company_pendaftar'];

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
    $output .= "<br><h4 id='h4lowongan'>Lowongan<span><button data-toggle='modal' data-target='#exampleModal' class='btn btn-dark btn-sm' style='float: right; cursor: pointer;'><span class='oi oi-plus'></span> Tambah Lowongan</button></span></h4>
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
            $output .= "<div class='row d-flex justify-content-center'><a href='DaftarPosisiByAdmin.php?lowongan-id=" . $row['lowongan_id'] . "&akta=" . $akta . "' class='btn btn-info' style='border-radius: 3px; '>Lihat Posisi</a></div>";
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
    <link href="src/open-iconic/font/css/open-iconic-bootstrap.css" rel="stylesheet">
    <link rel="stylesheet" href="src/css/index.css">
    <style>
        .error {
            font-size: 12px;
            color: red;
        }

        .error_lain {
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <div id="detail-company">
        <?php
        if (!$dbconnection) {
            echo "Not Connected !";
        } else {
            fetchDetail();
        }
        ?>
    </div>
</div>


<div class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
     aria-hidden="true">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel" style="font-weight: bold; color: dimgray">Tambah Lowongan
                    Baru</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form method="POST" id="companyRegistration">
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label for="idlowongan" class="label-form">ID Lowongan<span
                                        class="error_lain">*</span></label>
                            <input class="form-control" id="idlowongan" name="idlowongan">
                            <span class="error" id="idlowongan_error"></span>
                        </div>

                    </div>
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label for="namalowongan" class="label-form">Nama Lowongan<span class="error_lain">*</span></label>
                            <input class="form-control" id="namalowongan" name="namalowongan">
                            <span class="error" id="namalowongan_error"></span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label for="tglbuka" class="label-form">Tanggal Buka<span
                                        class="error_lain">*</span></label>
                            <input type="date" class="form-control" id="tglbuka" name="tglbuka">
                            <span class="error" id="tglbuka_error"></span>
                        </div>
                    </div>
                    <div class="form-group row">
                        <div class="col-sm-12">
                            <label for="tgltutup" class="label-form">Tanggal Tutup<span
                                        class="error_lain">*</span></label>
                            <input type="date" class="form-control" id="tgltutup" name="tgltutup">
                            <span class="error" id="tgltutup_error"></span>
                        </div>
                    </div>
                </form>
                <p class="wajib-diisi" style="font-size: 13px;"><span class="error_lain">*</span> Wajib Diisi<span><button
                                id="tambahlowongan" type="button" class="btn btn-primary" style="float: right"><span
                                    class='oi oi-plus'></span> Tambah</button></span></p>
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
        $(document).on('click', '#tambahlowongan', function () {
            var idlowongan = $('#idlowongan').val();
            var namalowongan = $('#namalowongan').val();
            var tglbuka = $('#tglbuka').val();
            var tgltutup = $('#tgltutup').val();
            $.ajax({
                url: "response/addlowongan.php",
                type: "POST",
                dataType: "json",
                data: {idlowongan: idlowongan, namalowongan: namalowongan, tglbuka: tglbuka, tgltutup: tgltutup},
                success: function (data) {
                    if (data.code === 404) {
                        $("#idlowongan_error").html(data.idlowongan_error);
                        $("#namalowongan_error").html(data.namalowongan_error);
                        $("#tglbuka_error").html(data.tglbuka_error);
                        $("#tgltutup_error").html(data.tgltutup_error);
                    } else {
                        $('#idlowongan').val('');
                        $('#idlowongan_error').html('');
                        $('#namalowongan').val('');
                        $('#namalowongan_error').html('');
                        $('#tglbuka').val('');
                        $('#tglbuka_error').html('');
                        $('#tgltutup').val('');
                        $('#tgltutup_error').html('');
                        $('#exampleModal').modal('hide');
                        $('#lowongan').html(data.output);
                    }
                }
            });
        });
    });
</script>
</html>
