$(document).ready(function () {
    fetchData();

    function fetchData() {
        $.ajax({
            url: "response/fetch.php",
            method: "POST",
            beforeSend: function () {
                $('#data-company').html('Loading...');
            },
            success: function (data) {
                $('#data-company').html(data);
            }
        });
    }

    $(document).on('click', '#btn-verifikasi', function () {
        var akta = $(this).data('akta');
        var tipe = this.id;
        var button = $(this);
        $.ajax({
            url: "response/verifikasi.php",
            method: "POST",
            data: {akta: akta, tipe: tipe},
            dataType: "text",
            success: function (data) {
                button.removeClass('btn btn-success btn-sm').addClass('btn btn-warning btn-sm').attr('id', 'btn-unverifikasi').html('Unverifikasi');
            }
        });
    });

    $(document).on('click', '#btn-unverifikasi', function () {
        var akta = $(this).data('akta');
        var tipe = this.id;
        var button = $(this);
        $.ajax({
            url: "response/verifikasi.php",
            method: "POST",
            data: {akta: akta, tipe: tipe},
            dataType: "text",
            success: function (data) {
                button.removeClass('btn btn-warning btn-sm').addClass('btn btn-success btn-sm').attr('id', 'btn-verifikasi').html('Verifikasi');
            }
        });
    });
});