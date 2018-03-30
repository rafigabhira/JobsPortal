<?php

session_start();

include '../connect.php';
if (!$dbconnection) {
    echo "Not Connected !";
}

$idposisi_error = $namaposisi_error = $gaji_error = $emailhrd_error = $maxjml_error = "";

$idlowongan = $_POST['idlowongan'];

$idposisi = $_POST['idposisi'];
$namaposisi = $_POST['namaposisi'];
$gaji = $_POST['gaji'];
$emailhrd = $_POST['emailhrd'];
$maxjml = $_POST['maxjml'];

$flag = true;


if (empty($idposisi)) {
    $idposisi_error = "ID Posisi harus diisi";
    $flag = false;
} else {

    if (strlen($idposisi) > 2 || strlen($idposisi) < 2 || preg_match('/\s/', $idposisi)) {
        $idposisi_error = "ID harus terdiri dari 2 Huruf/Angka";
    }

    $cekID = "SELECT * FROM siloker.posisi WHERE posisi_id = '$idposisi'";
    $query = pg_query($dbconnection, $cekID);
    if (pg_fetch_row($query) > 0) {
        $idposisi_error = "ID Posisi sudah ada, ganti yang lain";
        $flag = false;
    }
}

if (empty($namaposisi)) {
    $namaposisi_error = "Nama Posisi harus diisi";
    $flag = false;
}

if (empty($gaji)) {
    $gaji_error = "Gaji harus diisi";
    $flag = false;
} else {
    if (!filter_var($gaji, FILTER_VALIDATE_INT)) {
        $flag = false;
        $gaji_error = "Gaji hanya boleh angka";
    }
}

if (empty($emailhrd)) {
    $emailhrd_error = "Email HRD harus diisi";
    $flag = false;
} else {
    if (!filter_var($emailhrd, FILTER_VALIDATE_EMAIL)) {
        $flag = false;
        $emailhrd_error = "Format Email slah";
    }
}

if (empty($maxjml)) {
    $maxjml_error = "Jumlah Penerimaan Maksimal harus diisi";
    $flag = false;
} else {
    if (!filter_var($maxjml, FILTER_VALIDATE_INT)) {
        $flag = false;
        $maxjml_error = "Jumlah Penerimaan Maksimal hanya boleh angka";
    }
}


if ($flag) {
    $output = "";
    $sql = "INSERT INTO siloker.posisi (lowongan_id, posisi_id, namaposisi, gaji, email_hrd, max_jml_penerima, jml_penerima_saatini) VALUES ('$idlowongan','$idposisi','$namaposisi'
    ,$gaji,'$emailhrd', $maxjml,0)";
    pg_query($dbconnection, $sql);

    $query = "SELECT * FROM siloker.posisi WHERE lowongan_id = '$idlowongan' ";
    $result = pg_query($dbconnection, $query);


    if (pg_num_rows($result) < 1) {
        $output .= "<h5 style='color: ghostwhite;'>Belum ada Posisi</h5>";
    } else {
        while ($row = pg_fetch_array($result)) {
            $output .= "<div class='card' style='width:100%; margin-bottom: 1px;'>
                <div class='card-body'  style='padding-bottom: inherit;'>";
            $output .= "<p style='font-weight: bold; color: dimgrey'>" . $row['namaposisi'] . "</p>";
            $output .= "<p class='detilposisi'><span>Gaji</span> : Rp " . $row['gaji'] . " / bulan</p>";
            $output .= "<p class='detilposisi'><span>HRD</span> : " . $row['email_hrd'] . "</p>";
            $output .= "<p class='detilposisi'><span>Diterima saat ini</span> : <span class='jmlpenerima'>" . $row['jml_penerima_saatini'] . "/" . $row['max_jml_penerima'] . "</span></p>";
            $output .= fetchPendaftar($row['posisi_id'], $row['lowongan_id']);
            $output .= "</div>";
            $output .= "</div>";
        }
    }


    echo json_encode(['code' => 200, 'output' => $output]);

} else {
    echo json_encode(['code' => 404, 'idposisi_error' => $idposisi_error, 'namaposisi_error' => $namaposisi_error, 'gaji_error' =>
        $gaji_error, 'emailhrd_error' => $emailhrd_error, 'maxjml_error' => $maxjml_error]);
}

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

