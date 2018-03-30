$(document).ready(function () {
    $('#alertmasuk').hide();

    $("#kembali").click(function () {
        $("#companyRegistration").show();
        $("#adminRegistration").hide();
    });

    //Registrasi Perusahaan
    $('#companysubmit').click(function (e) {
        e.preventDefault();
        var noAkta = $('#noAkta').val();
        var namaCompany = $('#namaCompany').val();
        var nomorTelepon = $('#nomorTelepon').val();
        var namaJalan = $('#namaJalan').val();
        var kota = $('#kota').val();
        var provinsi = $('#provinsi').val();
        var kodePos = $('#kodePos').val();
        var deskripsi = $('#deskripsi').val();

        $.ajax({
            url: "response/responseCompany.php",
            type: "POST",
            dataType: "json",
            data: {
                noAkta: noAkta,
                namaCompany: namaCompany,
                nomorTelepon: nomorTelepon,
                namaJalan: namaJalan,
                kota: kota,
                provinsi: provinsi,
                kodePos: kodePos,
                deskripsi: deskripsi
            },
            success: function (data) {
                if (data.code === 404) {
                    $("#akta_error").html(data.akta_error);
                    $("#company_error").html(data.company_error);
                    $("#telepon_error").html(data.telepon_error);
                    $("#jalan_error").html(data.jalan_error);
                    $("#kota_error").html(data.kota_error);
                    $("#provinsi_error").html(data.provinsi_error);
                    $("#kodePos_error").html(data.kodePos_error);
                } else {
                    $("#namaPerusahaan").html(namaCompany);
                    $("#companyRegistration").hide();
                    $("#adminRegistration").show();
                    $('#alertmasuk').show(400);
                    $('h4').append('<span id="titleRegisAdmin"> > Registrasi Admin Perusahaan</span>');
                }
            },
            error: function () {
                console.log('error');
            }
        });
    });

    //Registrasi Admin Perusahaan
    $('#adminsubmit').click(function (e) {
        e.preventDefault();
        var username = $('#username').val();
        var password = $('#password').val();
        var namaLengkap = $('#namaLengkap').val();
        var noktp = $('#noktp').val();
        var tgllahir = $('#tgllahir').val();
        var nomorhp = $('#nomorhp').val();
        var jalanadmin = $('#jalanadmin').val();
        var kotaadmin = $('#kotaadmin').val();
        var provinsiadmin = $('#provinsiadmin').val();
        var posadmin = $('#posadmin').val();
        var admincompany = $('#admincompany').val();

        $.ajax({
            url: "response/responseAdmin.php",
            type: "POST",
            dataType: "json",
            data: {
                username: username,
                password: password,
                namaLengkap: namaLengkap,
                noktp: noktp,
                tgllahir: tgllahir,
                nomorhp: nomorhp,
                jalanadmin: jalanadmin,
                kotaadmin: kotaadmin,
                provinsiadmin: provinsiadmin,
                posadmin: posadmin,
                admincompany: admincompany
            },
            success: function (data) {
                if (data.code === 404) {
                    console.log(data.admincompany_error);
                    $("#username_error").html(data.username_error);
                    $("#password_error").html(data.password_error);
                    $("#namaLengkap_error").html(data.namaLengkap_error);
                    $("#noktp_error").html(data.noktp_error);
                    $("#tgllahir_error").html(data.tgllahir_error);
                    $("#nomorhp_error").html(data.nomorhp_error);
                    $("#jalanadmin_error").html(data.jalanadmin_error);
                    $("#kotaadmin_error").html(data.kotaadmin_error);
                    $("#provinsiadmin_error").html(data.provinsiadmin_error);
                    $("#posadmin_error").html(data.posadmin_error);
                    $("#admincompany_error").html(data.admincompany_error);
                } else {
                    alert("Registrasi Berhasil ! Silahkan Login");
                    window.location.href = "index.php";
                }
            },
            error: function () {
                console.log('error');
            }
        });
    });
});