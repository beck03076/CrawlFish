

// functions defined after this section are direct
//#=============== Direct Functions - START ================

$("span.local-visit-shop a").click(function() {

   alert("hi");

});

//#=============== Direct Functions - END ================



function impressions_logger(current_div_id) {

  var unique_ids_array = $(current_div_id).data('unique_ids_array');

    if (unique_ids_array != null){

        $.post('/impressions/' + "impressions" + "/" + unique_ids_array);

    }

}


function clicks_logger(unique_id) {

   var final_unique_id = unique_id

    if (final_unique_id.length != 0 && final_unique_id !=0 ){

        $.post('/clicks/' + "clicks" + "/" + final_unique_id);
    }

}

//#=============== Auxillary Functions - END ================

