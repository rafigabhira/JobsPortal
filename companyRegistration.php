<!-- Muhammad Rafiando Gabhira
1506721775 -->

<?php
session_start();
include 'navigationBar.php';
?>

<!DOCTYPE html>
<html>
<head>
    <title>Registrasi Perusahaan</title>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link rel="stylesheet" href="src/css/companyRegistration.css">
</head>

<body>
<div class="container">
    <h4>Registrasi Perusahaan </h4>
    <hr>

    <div class="container-form" style="margin-bottom: 50px;">
        <form method="POST" id="companyRegistration">
            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="noAkta" class="label-form">Nomor Akta<span>*</span></label>
                    <input class="form-control" id="noAkta" name="noAkta">
                    <span class="error" id="akta_error"></span>
                </div>
                <div class="col-sm-6">
                    <label for="namaCompany" class="label-form">Nama Company<span>*</span></label>
                    <input class="form-control" id="namaCompany" name="namaCompany">
                    <span class="error" id="company_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="nomorTelepon" class="label-form">Nomor Telepon<span>*</span></label>
                    <input class="form-control" id="nomorTelepon" name="nomorTelepon">
                    <span class="error" id="telepon_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="namaJalan" class="label-form">Nama Jalan<span>*</span></label>
                    <input class="form-control" id="namaJalan" name="namaJalan">
                    <span class="error" id="jalan_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-4">
                    <label for="kota" class="label-form">Nama Kota<span>*</span></label>
                    <input class="form-control" id="kota" name="kota">
                    <span class="error" id="kota_error"></span>
                </div>
                <div class="col-sm-4">
                    <label for="provinsi" class="label-form">Nama Provinsi<span>*</span></label>
                    <input class="form-control" id="provinsi" name="provinsi">
                    <span class="error" id="provinsi_error"></span>
                </div>
                <div class="col-sm-4">
                    <label for="kodePos" class="label-form">Kode Pos<span>*</span></label>
                    <input class="form-control" id="kodePos" name="kodePos">
                    <span class="error" id="kodePos_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="deskripsi" class="label-form">Deskripsi</label>
                    <textarea class="form-control" id="deskripsi" name="deskripsi" rows="3"></textarea>
                </div>
            </div>
            <p class="wajib-diisi"><span>*</span> Wajib Diisi</p>
            <div class="form-group row">
                <div class="col-sm-12 d-flex justify-content-end">
                    <button type="submit" id="companysubmit" name="companysumbit" class="btn btn-info">Next</button>
                </div>
            </div>
        </form>

        <form method="POST" id="adminRegistration" style="display: none;">
            <div class="alert alert-success alert-dismissible fade show" id="alertmasuk" role="alert">
                <strong>Registrasi Perusahaan Berhasil !</strong> Silahkan isi form Registrasi Admin Perusahaan
                <button type="button" class="close" data-dismiss="alert" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="username" class="label-form">Username<span>*</span></label>
                    <input class="form-control" id="username" name="username">
                    <span class="error" id="username_error"></span>
                </div>
                <div class="col-sm-6">
                    <label for="password" class="label-form">Password<span>*</span></label>
                    <input type="password" class="form-control" id="password" name="password">
                    <span class="error" id="password_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="namaLengkap" class="label-form">Nama Lengkap<span>*</span></label>
                    <input class="form-control" id="namaLengkap" name="namaLengkap">
                    <span class="error" id="namaLengkap_error"></span>
                </div>
                <div class="col-sm-6">
                    <label for="noktp" class="label-form">Nomor KTP<span>*</span></label>
                    <input class="form-control" id="noktp" name="noktp">
                    <span class="error" id="noktp_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-6">
                    <label for="tgllahir" class="label-form">Tanggal Lahir<span>*</span></label>
                    <input type="date" class="form-control" id="tgllahir" name="tgllahir">
                    <span class="error" id="tgllahir_error"></span>
                </div>
                <div class="col-sm-6">
                    <label for="nomorhp" class="label-form">Nomor Handphone<span>*</span></label>
                    <input class="form-control" id="nomorhp" name="nomorhp">
                    <span class="error" id="nomorhp_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="jalanadmin" class="label-form">Nama Jalan<span>*</span></label>
                    <input class="form-control" id="jalanadmin" name="jalanadmin">
                    <span class="error" id="jalanadmin_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-4">
                    <label for="kotaadmin" class="label-form">Nama Kota<span>*</span></label>
                    <input class="form-control" id="kotaadmin" name="kotaadmin">
                    <span class="error" id="kotaadmin_error"></span>
                </div>
                <div class="col-sm-4">
                    <label for="provinsiadmin" class="label-form">Nama Provinsi<span>*</span></label>
                    <input class="form-control" id="provinsiadmin" name="provinsiadmin">
                    <span class="error" id="provinsiadmin_error"></span>
                </div>
                <div class="col-sm-4">
                    <label for="posadmin" class="label-form">Kode Pos<span>*</span></label>
                    <input type="number" class="form-control" id="posadmin" name="posadmin">
                    <span class="error" id="posadmin_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="admincompany" class="label-form">Menjadi Admin ?<span">*</span></label>
                    <select id="admincompany" class="form-control" name="admincompany">
                        <option value="True">True</option>
                        <option value="False" selected="selected">False</option>
                    </select>
                    <span class="error" id="admincompany_error"></span>
                </div>
            </div>
            <div class="form-group row">
                <div class="col-sm-12">
                    <label for="namaPerusahaan" class="label-form">Nama Perusahaan : <span
                                id="namaPerusahaan"></span></label>
                </div>
            </div>
            <p class="wajib-diisi"><span>*</span> Wajib Diisi</p>
            <div class="form-group row">
                <div class="col-sm-6 d-flex justify-content-start">
                    <button id="kembali" class="btn btn-info">Kembali</button>
                </div>
                <div class="col-sm-6 d-flex justify-content-end">
                    <input type="submit" id="adminsubmit" name="adminsubmit" class="btn btn-info" value="Daftar">
                </div>
            </div>
        </form>
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
<script src="src/js/companyRegistration.js"></script>
</html>
