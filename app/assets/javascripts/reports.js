//= require 'datatable/js/jquery-3.3.1.js'
//= require  jquery_ujs
//= require 'datatable/js/jquery.dataTables.min.js'
//= require 'datatable/js/dataTables.buttons.min.js'
//= require 'datatable/js/pdfmake.min.js'
//= require 'datatable/js/vfs_fonts.js'
//= require 'datatable/js/buttons.html5.min.js'
//= require 'js/vendors/bootstrap.bundle.min.js'
//= require 'js/custom.js'


$(document).ready(function() {
    $('#data-table').DataTable( {
        dom: 'Bfrtip',
        buttons: [
            {
                extend: 'pdfHtml5',
                // orientation: 'landscape',
                // pageSize: 'LEGAL'
            }
        ]
    } );
} );
