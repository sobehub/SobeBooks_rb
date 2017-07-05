var invoice_ids=[]; // These global arrays are use for both vendors and clients
var invoice_balances=[];
//////////////////////////////////////////////////////////////////////
//////////////////////////For Vendor Only/////////////

jQuery(function($) {
  $("#vendor_id").change(function() {
        $("#tbody_empty").empty();
       $('#total_blc').val("0.00");
  invoice_ids=[];
  invoice_balances=[];
  var select ="Select";
    var vendor_id = $('select#vendor_id :selected').val(); //For Vendors.. Ids and variables name are almost same for both
    if(vendor_id==""){
      $('#divResults').hide('2000');
      $('#show_select').hide('2000');
    } else {
    jQuery.getJSON('/bills/bills_of_a_single_client/' + vendor_id, function(result){
      var invoices_client = "";

      if(result.length>0){
        $("#nothing_alert").hide();

        $('#divResults').show('2000');
        $('#show_select').show('2000');

      $.each(result, function( index, data ) {
        if(data.totalpaid==null)
          data.totalpaid = 0;
         var last_paid = "";
        if(data.transaction_bills.length > 0 )
          last_paid = data.transaction_bills[0].updated_at.split('T')[0]
        else
          last_paid = "---";

        invoices_client += '<tr> <td class="invoice_num"><a href="/invoices/'+ data.id +'">'+ data.id +
            '</a> </td> <td class="invoice_reference"> '+ data.reference +
            ' </td> <td class="invoice_amount">'+ parseFloat(data.amount).toFixed(2) +' </td><td class="invoice_balance">' +
            '<input name="balances[]" type="number" step="any" min="0" max="'+ parseFloat(data.balance_amount).toFixed(2) +
            '" value="'+ parseFloat(data.balance_amount).toFixed(2) +'"/> </td> <td class="invoice_lastpayment">'+ last_paid  +
            ' </td><td class="invoice_totalpaid">'+ parseFloat(data.totalpaid).toFixed(2) +' </td> <td class="invoice_notes">'+
            data.notes+'</td> <td> ' +
            '<a data-invoice-id="'+data.id+'" class="btn btn-danger get_invoice_id append_row">Select</a></td></tr>';

      });

      $("#client_invoice tbody").html("");
      $("#client_invoice tbody").html(invoices_client);
      
      } else {
        $('#divResults').hide('2000');
        $('#show_select').hide('2000');
        $("#nothing_alert").show('2000');
      }
    })
    }
    return false;
  });
})
////////////////////////////////////////

// $('body').on('click', '.remove_row', function() {
//     var remove = $(this).parent().parent();
//     $(this).hide();
//     $('#client_invoice tbody').append(remove);
//     $(".append_row").show();
//     var invoice_id = actual.find(".invoice_num").text();
//     remove_id = invoice_id.split(",") 
//     invoice_ids.pop(remove_id);//Remove ids
//     $('.transaction_invoice_id').val(invoice_ids); // Send to hidden field in form
//   });





/////////The part till end comment is same for both Client and vendors/////////////////////////
$(document).ready(function(){
  $('body').on('change', '.blc', function() {
    // $("#total_blc").val( parseFloat($("#total_blc").val()) + parseFloat($(this).val()) );
    var sum = 0;
    $(".blc").each(function() {
      //add only if the value is number
      if (!isNaN(this.value) && this.value.length != 0) {
          sum += parseFloat(this.value);
      }
    });
    $("#total_blc").val( sum.toFixed(2) );
  });
});


$(document).ready(function(){

  $("#divResults table tbody").bind("DOMSubtreeModified", function() {
    if( $(this).children().length > 0 )
      $('input[type="submit"]').show();
    else
      $('input[type="submit"]').hide();
  });
  $('body').on('click', '.append_row', function() {

    var actual = $(this).parent().parent();
    $(this).remove();
    actual.find('[name="balances[]"]').addClass("blc");

    value = actual.find('.blc').val();
    if (!isNaN(value) && value.length != 0) {
      $("#total_blc").val( (parseFloat( $("#total_blc").val() ) + parseFloat(value)).toFixed(2) );
    }

    $('#divResults table tbody').append(actual);
    $('#invoices').modal('hide');
    // $('input[type="submit"]').show();

    var invoice_id = actual.find(".invoice_num").text(); //Invoice ids
    invoice_ids.push(invoice_id); //Id push in array
    $('.transaction_invoice_id').val(invoice_ids); // SEnd to hidden field in form
  });

$(function() {
    $('#divResults').hide(); 
    $('#show_select').hide(); 
    $("#nothing_alert").hide();

});

});

/////////End Comment/////////////////////////





//////////////////////////For Client Only/////////////

jQuery(function($) {
  $("#client_id").change(function() {
        $("#tbody_empty").empty();
       $('#total_blc').val("0.00");
  invoice_ids=[];
  invoice_balances=[];
  var select ="Select";
    var client_id = $('select#client_id :selected').val();
    if(client_id==""){
      $('#divResults').hide('2000');
      $('#show_select').hide('2000');
    } else {
    jQuery.getJSON('/invoices/invoices_of_a_single_client/' + client_id, function(result){
      var invoices_client = "";

      if(result.length>0){

        $("#nothing_alert").hide();
        $('#divResults').show('2000');
        $('#show_select').show('2000');

      $.each(result, function( index, data ) {
        if(data.totalpaid==null)
          data.totalpaid = 0;

        var last_paid = "";
        if(data.transaction_invoices.length > 0 )
          last_paid = data.transaction_invoices[0].updated_at.split('T')[0]
        else
          last_paid = "---";

        invoices_client += '<tr> <td class="invoice_num">' +
            '<a href="/invoices/'+ data.id +'">'+ data.id +'</a> </td> <td class="invoice_reference"> '+ data.reference +' </td>' +
            ' <td class="invoice_amount">'+ parseFloat(data.amount).toFixed(2)+' </td><td class="invoice_balance">' +
            '<input name="balances[]" type="number" step="any" min="0" max="'+ parseFloat(data.balance_amount).toFixed(2)+'" ' +
            'value="'+ parseFloat(data.balance_amount).toFixed(2)+'"/> </td> <td class="invoice_lastpayment">'+ last_paid +
            ' </td> <td class="invoice_duedate">'+data.duedate+' </td><td class="invoice_totalpaid">'+ parseFloat(data.totalpaid).toFixed(2)+
            ' </td> <td class="invoice_notes">'+data.notes+'</td> <td> <a data-invoice-id="'+data.id+'"' +
            ' class="btn btn-danger get_invoice_id append_row">Select</a></td></tr>';

      });

      $("#client_invoice tbody").html("");
      $("#client_invoice tbody").html(invoices_client);
      
      } else {
        $('#divResults').hide('2000');
        $('#show_select').hide('2000');
        $("#nothing_alert").show('2000');

      }
      
    })
    }
    return false;
  });
})