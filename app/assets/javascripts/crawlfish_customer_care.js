// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(function () {
$("#date_fetch").datepicker({
   changeMonth: true,
   dateFormat: 'yy-mm-dd'
   })
  });

$(function() {
$('#customer_care_date_fetch_form').on('submit',function() {

  var date_fetch = $("#date_fetch").val();

  if(date_fetch == ""){
        alert("Enter a Date to Fetch!");
        return false;
        }
});
});

$(function() {
$('#customer_care_phone_fetch_form').on('submit',function() {

  var phone_fetch = $("#phone_fetch").val();

  if(phone_fetch == ""){
        alert("Enter a phone number!");
        return false;
        }
});
});

$(function() {
$('#customer_care_range_form').on('submit',function() {

  var from_date = $("#from_date").val();
  var to_date = $("#to_date").val();

  if(from_date == ""){
        alert("Enter From Date!");
        return false;
        }
  if(to_date == ""){
        alert("Enter To Date!");
        return false;
        }

});
});

