<?php
	//Menggunakan password=1234 untuk $dbconnection karena mengerjakan di local postgresql (password local saya) ...dapat diganti dengan password di local postgresql Anda (password dikosongkan jika memang tidak ada password)
	include 'connect.php';
	
		
	//mengecek apakah ada username tersebut di database sekaligus menyocokkan dengan password
	$query="SELECT count(username) from siloker.pengguna_admin where password='".$_POST['password']."' AND username='".$_POST['username']."' UNION SELECT count(username) from siloker.pengguna_userumum where password='".$_POST['password']."' AND username='".$_POST['username']."'";
	$result=pg_query($dbconnection,$query);
	
		
	$row1 = pg_fetch_array($result);
	$row2 = pg_fetch_array($result);
	$total=$row1[0]+$row2[0];
	
	
			
		
		//Berhasil login karena username memang sudah ada di database (dan password sesuai)		
		if($total>0){			
			
			
			
			$inputquery="SELECT * from siloker.pengguna_userumum where password='".$_POST['password']."' AND username='".$_POST['username']."' ";
			$inputresult=pg_query($dbconnection,$inputquery);			
			$row = pg_fetch_array($inputresult);
	
			session_start();
			
			//jika $row=false maka artinya user adalah admin(perusahaan/siloker) maka query diulang
			if($row==false){
				$inputquery="SELECT * from siloker.pengguna_admin where password='".$_POST['password']."' AND username='".$_POST['username']."' ";
				$inputresult=pg_query($dbconnection,$inputquery);
				$row = pg_fetch_array($inputresult);
				
				$_SESSION['company_pendaftar']=$row[11];
				
				
			}
						
			//session untuk pengguna umum
			else{			
				
				$_SESSION['cv']=$row[10];		
			
			}
			
			//attribute yang sama untuk semua user
			$_SESSION['username']=$row[0];
			$_SESSION['password']=$row[1];
			$_SESSION['nama']=$row[2];
			$_SESSION['no_ktp']=$row[3];
			$_SESSION['tgl_lahir']=$row[4];
			$_SESSION['no_hp']=$row[5];
			$_SESSION['nama_jalan']=$row[6];
			$_SESSION['provinsi']=$row[7];
			$_SESSION['kota']=$row[8];
			$_SESSION['kodepos']=$row[9];
			
			
			
			//mengecek apakah admin SILOKER
			$query="SELECT count(username) from siloker.pengguna_admin where username='$_SESSION[username]' and company_pendaftar IS NULL"; 
			$result=pg_query($dbconnection,$query);
			$isAdmin=pg_fetch_array($result);
			
			//mengecek apakah admin perusahaan
			$query="SELECT count(username) from siloker.pengguna_admin where username='$_SESSION[username]' and company_pendaftar IS NOT NULL";
			$result=pg_query($dbconnection,$query);
			$isCompany=pg_fetch_array($result);	
			
			
			
				/*
				//jika admin SILOKER maka dinavigasikan ke halaman yang sesuai
				if($isAdmin[0]>0){					
					header("refresh:0;url=daftarPerusahaan.php");
					
					
					
				}
		
				//jika admin perusahaan maka dinavigasikan ke halaman yang sesuai
				else if($isCompany[0]>0){
					header("refresh:0;url=profileCompany.php");
					
					
				
				}

				//jika user umum maka dinavigasikan ke halaman yang sesuai
				else{
					header("refresh:0;url=profileUserUmum.php");
					
				}	*/	
					
			
			header("refresh:0;url=index.php");
			 
		}
		//gagal login karena salah username atau password
		else {			
			echo "Username / password salah";
			header("refresh:3;url=login.php");
		}  
	  
	
	
	
	
	
	
	
	
	
		
	
	
	
	
?>