<?php
session_start();
include 'navigationBar.php';
?>
<!DOCTYPE HTML>
<html>
<head>
    <title>Login
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
    <link rel="stylesheet" href="src/css/login.css">
</head>
<body>
<div class="container"
     style=" padding: 100px; padding-left: 150px; padding-right: 150px; color: white; width: 700px;">
    <h3 style="margin-bottom: 20px; text-align: center;">Login</h3>
    <form method="post" action="checkLogin.php">
        <div class="form-group">
            <label>Username</label>
            <input type="text" class="form-control" name="username" placeholder="Masukkan username">
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" class="form-control" name="password" placeholder="Masukkan password">
        </div>
        <hr>
        <div class="d-flex justify-content-end">
            <button type="submit" class="btn btn-success" style="border-radius: 3px; width: 150px;">Login</button>
        </div>
    </form>
</div>
</body>
</html>