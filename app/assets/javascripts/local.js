

$(function() {
  $("form.view-map-button").on('submit', function() {

  var local_shop_area_id = $("#local_shop_area_id").val();

  if (local_shop_area_id < 1) {

          alert("Please select an area!")

  }
  else{
          var branch_name = $("#local_shop_area_id option[value='"+local_shop_area_id+"']").text()
          var vendor_name = $("input#input-vendor-name").attr("vendor_name")
          $('#gmap-error').css('display','none')
          $.get('/local/show_gmap/' + vendor_name + '/' + branch_name, function(data){
                $("#gmap").html(data);
            });

            var TabbedPanelsLocal1= new Spry.Widget.TabbedPanels("TabbedPanelsLocal1", { defaultTab: 1});

    }

    return false;
  });
})

$(function() {
// when the #region_id field changes
  $("#local_shop_area_id").on('change', function() {

    var vendor_id = $('#local_shop_area_id').val();
    if(vendor_id == "") vendor_id="0";
    $.get('/local/change_vendor_details/'  + vendor_id, function(data){
        $("#local-shop-details").html(data);
    })

    var branch_name = $("#local_shop_area_id option[value='"+vendor_id+"']").text()
    var vendor_name = $("input#input-vendor-name").attr("vendor_name")
    $('#gmap-error').css('display','none')
    $.get('/local/show_gmap/' + vendor_name + '/' + branch_name, function(data){
      $("#gmap").html(data);
	var TabbedPanelsLocal1= new Spry.Widget.TabbedPanels("TabbedPanelsLocal1", { defaultTab: 0});
    })


    return false;

  });
})

$(function() {
$("#generate-coupon-code a").on("click", function() {

  $("#generate-coupon-code-container").css('display','')

  $("#mobile-number").val('')

  $("#mobile-number").focus()

  $("#generate-coupon-code").css('display','none')

    return false;
});
})

$(function() {

  $("#generate-coupon-code-form").on("submit", function() {

  var phone_number = $("#mobile-number").val();

  var unique_id = $("#scc_unique_id").val();

  var product_id = $("#scc_product_id").val();

  var sub_category_id = $("#scc_category_id").val();

  var vendor_id = $("#scc_vendor_id").val();

  if(vendor_id == "") vendor_id="0";

  if(unique_id == "") product_id="0";

  if(sub_category_id == "") sub_category_id="0";

  if(product_id == "") product_id="0";

  $("#generate-coupon-code-container").css('display','none');

  $("#generate-coupon-code-loading").css('display','');

  $.post('/local/generate_coupon_code/'+ phone_number + '/' + vendor_id + '/'+ unique_id +'/' + sub_category_id + '/' + product_id, function(data){

  $("#generate-coupon-code-container").css('display','none')

  $("#generate-coupon-code-loading").css('display','none')

  $("#generate-coupon-code").css('display','')

    })

    return false;
  });
})

$(function() {
// when the #region_id field changes
  $("#generate-coupon-code-container a").on('click', function() {

  $("#generate-coupon-code-container").css('display','none')

  $("#generate-coupon-code").css('display','')

    return false;

  });
})
