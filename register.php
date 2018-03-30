<?php session_start();

include 'navigationBar.php';
?>
<!DOCTYPE HTML>
<html>
<head>
    <title>Register
    </title>
    <meta charset="utf-8">

    <script src="https://code.jquery.com/jquery-3.2.1.js"
            integrity="sha256-DZAnKJ/6XZ9si04Hgrsxu/8s717jcIzLy3oi35EouyE=" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.3/umd/popper.min.js"
            integrity="sha384-vFJXuSJphROIrBnz7yo7oB41mKfc8JzQZiCq4NCceLEaO4IHwicKwpJf9c9IpFgh"
            crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/js/bootstrap.min.js"
            integrity="sha384-alpBpkh1PFOepccYVYDB4do5UnbKysX5WZXm3XxPqe5iKTfUKjNkCk9SaVuEZflJ"
            crossorigin="anonymous"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0-beta.2/css/bootstrap.min.css"
          integrity="sha384-PsH8R72JQ3SOdhVi3uxftmaW6Vc51MKb0q5P2rRUpPvrszuE4W1povHYgTpBfshb" crossorigin="anonymous">
    <link rel="stylesheet" href="src/css/index.css">


    <style>
        @import url('https://fonts.googleapis.com/css?family=Comfortaa');

        body {
            background: white linear-gradient(19deg, #21D4FD 0%, #B721FF 100%) no-repeat;
            font-family: 'Comfortaa', cursive;
        }
    </style>


</head>
<body>
<div class="container"
     style="background-color: white; padding: 30px; padding-bottom: 10px; margin-bottom: 40px; border-radius: 3px; width: 700px; color: dimgrey">
    <h3>FORM REGISTER</h3>
    <form method="post" action="inputRegister.php">
        <div class="form-group">
            <label>Username</label>
            <input type="text" class="form-control" name="username" placeholder="Masukkan username yang Anda inginkan"
                   required>
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" class="form-control" name="password" placeholder="Masukkan password akun Anda"
                   required>
        </div>
        <div class="form-group">
            <label>Nama lengkap</label>
            <input type="text" class="form-control" name="nama_lengkap" placeholder="Masukkan nama lengkap Anda"
                   required>
        </div>
        <div class="form-group">
            <label>No. KTP</label>
            <input type="number" class="form-control" name="no_ktp" placeholder="Masukkan no ktp Anda" required>
        </div>
        <div class="form-group">
            <label>Tanggal Lahir</label>
            <input type="date" class="form-control" name="tgl_lahir" placeholder="Masukkan tanggal lahir Anda" required>
        </div>
        <div class="form-group">
            <label>No. HP</label>
            <input type="number" class="form-control" name="no_hp" placeholder="Masukkan no hp Anda" required>
        </div>
        <div class="form-group">
            <label>Nama Jalan</label>
            <input type="text" class="form-control" name="nama_jalan"
                   placeholder="Masukkan nama jalan tempat tinggal Anda" required>
        </div>
        <div class="form-group">
            <label>Kota</label>
            <input type="text" class="form-control" name="kota" placeholder="Masukkan kota tempat tinggal Anda"
                   required>
        </div>
        <div class="form-group">
            <label>Provinsi</label>
            <input type="text" class="form-control" name="provinsi" placeholder="Masukkan provinsi tempat tinggal Anda"
                   required>
        </div>
        <div class="form-group">
            <label>Kode Pos</label>
            <input type="number" class="form-control" name="kodepos" placeholder="Masukkan kode pos tempat tinggal Anda"
                   required>
        </div>
        <div class="form-group">
            <label>CV</label>
            <input type="text" class="form-control" name="cv" placeholder="Masukkan URL dari CV anda">
        </div>


        <button type="submit" class="btn btn-success btn-block" style="border-radius: 3px;">Register</button>
    </form>
</div>


</body>
</html>