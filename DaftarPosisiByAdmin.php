<?php

session_start();
include 'connect.php';
include 'navigationBar.php';

$lowongan_id = $_GET['lowongan-id'];

function fetchPendaftar($posisi_id, $lowonganid)
{
    global $dbconnection;
    $query = "SELECT pu.username, pu.nama, pu.no_ktp, pu.nama_jalan,pu.provinsi,pu.kota,pu.kodepos, pu.no_hp, pu.cv, p.status FROM siloker.pengguna_userumum pu, siloker.pelamaran p
              WHERE pu.username = p.username AND p.lowongan_id = '$lowonganid' AND p.posisi_id = '$posisi_id'";
    $result = pg_query($dbconnection, $query);
    $output = "";
    $output .= '<p id="arrow">
              <a class="btn btn-link btn-block"  data-toggle="collapse" href="#collapseExample-' . $lowonganid . $posisi_id . '" aria-expanded="false" aria-controls="collapseExample" style="color: #21D4FD; font-weight: bold;">
               <span class="oi oi-chevron-bottom"></span> Lihat Pendaftar
              </a></p>';
    $output .= '<div class="collapse" id="collapseExample-' . $lowonganid . $posisi_id . '">';
    $output .= '<table class="table table-responsive-xl" style="font-size: 13px;">
                  <thead class="thead-light">
                    <tr>
                      <th scope="col">Username</th>
                      <th scope="col">Nama</th>
                      <th scope="col">No. KTP</th>
                      <th scope="col">Alamat</th>
                      <th scope="col">Kode Pos</th>
                      <th scope="col">No. HP</th>
                      <th scope="col">Link CV</th>
                      <th scope="col" style="text-align: center;">Status</th>
                    </tr>
                  </thead>
                  <tbody>';

    if (pg_num_rows($result) < 1) {
        $output .= "<tr><td colspan='8'><p align='center' style='color: #979A9A; font-size: 14px;'>Tidak ada yang mendaftar pada posisi ini</p></td></tr>";
        $output .= "</tbody></table>";

        $output .= "</div>";
    } else {
        while ($row = pg_fetch_array($result)) {

            $output .= ' <tr >
                      <td>' . $row['username'] . '</td>
                      <td>' . $row['nama'] . '</td>
                      <td>' . $row['no_ktp'] . '</td>
                      <td><p>Jalan : ' . $row['nama_jalan'] . '</p> <p>Provinsi : ' . $row['provinsi'] . '</p><p>Kota : ' . $row['kota'] . ' </p></td>
                      <td>' . $row['kodepos'] . '</td>
                      <td>' . $row['no_hp'] . '</td>
                      <td><a href="' . $row['cv'] . '">CV</a></td>
                      ';

            if ($row['status'] == '2') {
                $output .= '<td><button class="btn btn-success btn-sm" style="border-color:transparent;border-radius: 3px; display: block; margin: auto; cursor: initial;" disabled>Sudah Diterima</button></td>';
            } else {
                $output .= '<td><button id="terimapelamar" data-detilpelamar="' . $row['username'] . ' ' . $posisi_id . ' ' . $lowonganid . '" class="btn btn-info btn-sm" style="border-radius: 3px; display: block; margin: auto;"><span class="oi oi-check"></span> Terima</button></td>';
            }
            $output .= '</tr>';
        }
        $output .= "</tbody></table>";

        $output .= "</div>";

    }
    return $output;
}

function fectPosisi()
{
    global $lowongan_id;
    global $dbconnection;

    $query = "SELECT * FROM siloker.posisi WHERE lowongan_id = '$lowongan_id' ";
    $result = pg_query($dbconnection, $query);
    $output = "";
    $output .= "<div class='row d-flex justify-content-center' id='posisi' style='margin-bottom: 30px; margin-top: -20px;'>";
    if (pg_num_rows($result) < 1) {
        $output .= "<h5 style='color: ghostwhite; margin-top: 20px;'>Belum ada Posisi</h5>";
    } else {
        while ($row = pg_fetch_array($result)) {
            $output .= "<div class='card' style='width:100%; margin-bottom: 1px;'>
                <div class='card-body' style='padding-bottom: inherit;'>";
            $output .= "<p style='font-weight: bold; color: dimgrey'>" . $row['namaposisi'] . "</p>";

            $output .= "<p class='detilposisi'><span>Gaji</span> : Rp " . $row['gaji'] . " / bulan</p>";
            $output .= "<p class='detilposisi'><span>HRD</span> : " . $row['email_hrd'] . "</p>";

            if ($row['jml_penerima_saatini'] >= $row['max_jml_penerima']) {
                $output .= "<p class='detilposisi'><span>Diterima saat ini</span> : <span id='diterimasaatini" . $row['posisi_id'] . "' class='jmlpenerimalebih'>" . $row['jml_penerima_saatini'] . "/" . $row['max_jml_penerima'] . "</span></p>";
            } else {
                $output .= "<p class='detilposisi'><span>Diterima saat ini</span> : <span id='diterimasaatini" . $row['posisi_id'] . "' class='jmlpenerima'>" . $row['jml_penerima_saatini'] . "/" . $row['max_jml_penerima'] . "</span></p>";
            }

            $output .= fetchPendaftar($row['posisi_id'], $lowongan_id);
            $output .= "</div>";
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
    $output .= "<br><h4 id='h4lowongan'>Posisi<button data-toggle='modal' data-target='#exampleModal' class='btn btn-dark btn-sm' style='float: right; cursor: pointer;'><span class='oi oi-plus'></span> Tambah Posisi</button></span></h4>
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
    <style>
        .error {
            color: red;
            font-size: 12px;
        }

        .error_lain {
            color: red;
        }
    </style>
</head>
<body>
<div class="container">
    <h4></h4>
    <a href='profileCompany.php' class='btn btn-link' style='color: white; padding: 0; margin-bottom: 20px;'>&lt;
        Kembali ke Profile</a>
    <div id="data-lowongan">
        <?php
        if (!$dbconnection) {
            echo "Not Connected !";
        } else {
            fectLowongan();
        }
        ?>
    </div>

    <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel"
         aria-hidden="true">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel" style="font-weight: bold; color: dimgray">Tambah
                        Posisi Baru</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <form method="POST" id="companyRegistration">
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <label for="idposisi" class="label-form">ID Posisi
                                    <span class="error_lain">*</span></label>
                                <input class="form-control" id="idposisi" name="idposisi">
                                <span class="error" id="idposisi_error"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <label for="namaposisi" class="label-form">Nama Posisi
                                    <span class="error_lain">*</span></label>
                                <input class="form-control" id="namaposisi" name="namaposisi">
                                <span class="error" id="namaposisi_error"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <label for="gaji" class="label-form">Gaji
                                    <span class="error_lain">*</span></label>
                                <input class="form-control" id="gaji" name="gaji">
                                <span class="error" id="gaji_error"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <label for="emailhrd" class="label-form">Email HRD
                                    <span class="error_lain">*</span></label>
                                <input class="form-control" id="emailhrd" name="emailhrd">
                                <span class="error" id="emailhrd_error"></span>
                            </div>
                        </div>
                        <div class="form-group row">
                            <div class="col-sm-12">
                                <label for="maxjml" class="label-form">Jumlah Penerimaan Maksimal
                                    <span class="error_lain">*</span></label>
                                <input class="form-control" id="maxjml" name="maxjml">
                                <span class="error" id="maxjml_error"></span>
                            </div>
                        </div>
                    </form>
                    <p class="wajib-diisi" style="font-size: 13px;"><span class="error_lain">*</span> Wajib Diisi<span>
                            <button id="tambahposisi" data-idlowongan="<?php echo $lowongan_id; ?>" type="button"
                                    class="btn btn-primary" style="float: right"><span class="oi oi-plus"></span> Tambah Posisi</button></span>
                    </p>
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

        $(document).on('click', '#arrow', function () {
            $('span', this).toggleClass('oi oi-chevron-bottom oi oi-chevron-top');
        });

        $(document).on('click', '#terimapelamar', function () {
            var button = $(this);
            var detilpelamar = $(this).data('detilpelamar');
            var split = detilpelamar.split(" ");
            var username = split[0];
            var posisi_id = split[1];
            var lowongan_id = split[2];

            var jmlpenerima = $('span#diterimasaatini' + posisi_id).html();
            var splitjml = jmlpenerima.split("/");
            var jml_saat_ini = parseInt(splitjml[0]) + 1;
            var jml_max = parseInt(splitjml[1]);

            $.ajax({
                url: "response/terimapelamar.php",
                type: "POST",
                dataType: "json",
                data: {
                    username: username,
                    posisi_id: posisi_id,
                    lowongan_id: lowongan_id
                },
                success: function (data) {
                    if (data.code === 200){
                        button.removeClass('')
                            .addClass('btn btn-success btn-sm')
                            .attr('style', 'border-color:transparent;border-radius: 3px; display: block; margin: auto; cursor: initial;')
                            .prop("disabled", true)
                            .html('Sudah Diterima');
                        if (jml_saat_ini >= jml_max){
                            $('span#diterimasaatini' + posisi_id)
                                .removeClass('')
                                .addClass('jmlpenerimalebih')
                                .html(jml_saat_ini+ "/" + jml_max);
                        } else {
                            $('span#diterimasaatini' + posisi_id)
                                .html(jml_saat_ini+ "/" + jml_max);
                        }
                    } else {
                        console.log('error');
                    }
                }
            });
        });


        $(document).on('click', '#tambahposisi', function () {
            var idlowongan = $(this).data('idlowongan');
            var idposisi = $('#idposisi').val();
            var namaposisi = $('#namaposisi').val();
            var gaji = $('#gaji').val();
            var emailhrd = $('#emailhrd').val();
            var maxjml = $('#maxjml').val();
            $.ajax({
                url: "response/addPosisi.php",
                type: "POST",
                dataType: "json",
                data: {
                    idlowongan: idlowongan,
                    idposisi: idposisi,
                    namaposisi: namaposisi,
                    gaji: gaji,
                    emailhrd: emailhrd,
                    maxjml: maxjml
                },
                success: function (data) {
                    if (data.code === 404) {
                        $("#idposisi_error").html(data.idposisi_error);
                        $("#namaposisi_error").html(data.namaposisi_error);
                        $("#gaji_error").html(data.gaji_error);
                        $("#emailhrd_error").html(data.emailhrd_error);
                        $("#maxjml_error").html(data.maxjml_error);
                    } else {
                        $('#exampleModal').modal('hide');
                        $('#posisi').html('').html(data.output);
                    }
                }, error: function () {
                    console.log('error');
                }
            });
        });
    });
</script>
</html>
