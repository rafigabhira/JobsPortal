<?php

	//Menggunakan password=1234 untuk $dbconnection karena mengerjakan di local postgresql (password local saya) ...dapat diganti dengan password di local postgresql Anda
include 'connect.php';
	extract($_POST);
	
	//mengecek apakah username sudah ada
	$cek="SELECT count(username) from siloker.pengguna_userumum where username='".$_POST['username']."' UNION SELECT count(username) from siloker.pengguna_admin where username='".$_POST['username']."'";
	$cekresult=pg_query($dbconnection,$cek);
	
	$row1 = pg_fetch_array($cekresult);
	$row2 = pg_fetch_array($cekresult);
	$total=$row1[0]+$row2[0];
	
	
	
	
		//username sudah ada
		if($total!=0){			
			echo "<script type='text/javascript'>alert('Username sudah ada !');</script>";
			header("refresh:0;url=register.php");		
		}
		//username tidak ada sehingga data baru bisa dimasukkan ke database
		else{
			if($cv==''){
				$cv="null";	
			
			}
			
			$tgl_lahir=$tgl_lahir." 00:00:00";
			
			
			
			$query="INSERT INTO siloker.pengguna_userumum(username,password,nama,no_ktp,tgl_lahir,no_hp,nama_jalan,provinsi,kota,kodepos,CV) VALUES ('$username','$password','$nama_lengkap',$no_ktp,'$tgl_lahir',$no_hp,'$nama_jalan','$provinsi','$kota',$kodepos,$cv); ";
			$result=pg_query($dbconnection,$query);
			
			session_start();
			$_SESSION['username']=$username;
			$_SESSION['password']=$password;
			$_SESSION['nama']=$nama_lengkap;
			$_SESSION['no_ktp']=$no_ktp;
			$_SESSION['tgl_lahir']=$tgl_lahir;
			$_SESSION['no_hp']=$no_hp;
			$_SESSION['nama_jalan']=$nama_jalan;
			$_SESSION['provinsi']=$provinsi;
			$_SESSION['kota']=$kota;
			$_SESSION['kodepos']=$kodepos;
			$_SESSION['cv']=$cv;
			
			
			header("refresh:0;url=profileUserUmum.php");
		
		
		}
		
	
	
	




?>