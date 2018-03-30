<nav class="navbar navbar-expand-lg navbar-light">
    <a class="navbar-brand" href="index.php">Loker Kerja</a>
    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
            aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">
            <li class="nav-item">
                <a class="nav-link" href="Lowongan.php">Lowongan</a>
            </li>
            <li class="nav-item">
                <a class="nav-link" href="#">Online Course</a>
            </li>

            <?php


            //jika sudah login
            if (isset($_SESSION['username']) && isset($_SESSION['password'])) {


                //jika admin SILOKER
                if (!isset($_SESSION['company_pendaftar']) && !isset($_SESSION['cv'])) {
                    $_SESSION['tipe'] = 'admin';
                    echo "<li class='nav-item' >
						<a class='nav-link' href='daftarPerusahaan.php'>Daftar Company</a>
					</li>";
                } //jika admin perusahaan
                else if (isset($_SESSION['company_pendaftar'])) {
                    $_SESSION['tipe'] = 'admincompany';
                    echo "<li class='nav-item' >
						<a class='nav-link' href='daftarPerusahaan.php'>Daftar Company</a>
					</li>";
                    echo "<li class='nav-item'>
							<a class='nav-link' href='profileCompany.php'>Profil Perusahaan</a>
						</li>";

                } //jika user umum
                else {
                    echo "<li class='nav-item'>
						<a class='nav-link' href='companyRegistration.php'>New Company Registration</a>
					</li>";
                    echo "<li class='nav-item' >
						<a class='nav-link' href='daftarPerusahaan.php'>Daftar Company</a>
					</li>";
                    echo "<li class='nav-item'>
						<a class='nav-link' href='profileUserUmum.php'>Profile Diri</a>
					</li>";

                }
            } //jika guest users
            else {
                echo "<li class='nav-item' >
						<a class='nav-link' href='daftarPerusahaan.php'>Daftar Company</a>
					</li>";
            }
            ?>

        </ul>

        <?php


        if (isset($_SESSION['username']) && isset($_SESSION['password'])) {


            //semua pengguna pasti punya button log-out

            echo "<form class='form-inline my-2 my-lg-0'>
                <a href='logout.php' class='btn btn-danger'>LOG OUT</a>
            </form>";


        } //jika hanya guest user
        else {
            echo "<form class='form-inline my-2 my-lg-0'>
                <a href='register.php' class='btn btn-warning' style='border-radius: 3px; margin-right: 10px;'>REGISTER</a>
            </form>";
            echo "<form class='form-inline my-2 my-lg-0'>
                <a href='login.php' class='btn btn-secondary' style='border-radius: 3px;'>LOGIN</a>
            </form>";

        }

        ?>

    </div>
</nav>