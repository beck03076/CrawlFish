    // This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery_ujs
//= require_tree .
//= require gritter

//= require noty/jquery.noty
//= require noty/layouts/top
//= require noty/themes/default


$(function(){
 /*** FOR HOME PAGE ARROW **/
    $("#arrow-price").hover(function(){
        $(".home-arrow").show();
        },function(){
        $(".home-arrow").hide();
     });
});


function set_date(minutes){
// setting the expiry time for the cookie as 30 minutes
    var date = new Date();
    date.setTime(date.getTime() + (minutes * 60 * 1000));
    return date;
}

// show_shops page the transparent glass will scroll up
$(function(){
$('.vendor-box').hover(
    function() {
      $(this).find(".overlay").animate({bottom:'0px'}, 500);
      $(this).find("#vendor-desc").fadeOut(500);
    }, 
    function() {
      $(this).find(".overlay").animate({bottom:"-84px"}, 300);
      $(this).find("#vendor-desc").fadeIn(500).css("display","");
    }
);
});

// specific get latest price click this function will say "loading"
$(function () {

    $("#get-price a").click(function() {     
   
        $("#slide-msg").html("Loading ...");

     });
     
});

// pop in home page auto move, populate and stop auto onclick
$(function () {

var timeouts = [];
var cat = '';

$(".left-submenu a").each(function(i) {    
  th = $(this);     
  move(th,3000 *i);
});

function move(th,delay){
         timeouts.push(setTimeout(function(){
           popMove(th)
         },delay));
}

$(".left-submenu a").click(function() {     
     $.each(timeouts, function (_, id) {
       clearTimeout(id);
     });
    timeouts = [];
    popMove($(this));
    return false;
});

function popMove(th){
         var cat = th.attr("href");
         th.parent().parent().children().removeClass('active-left-submenu');
         th.parent().addClass('active-left-submenu');
         
         $.get('/pop/' + cat ,function(data){
           $("#pop").hide().html(data).fadeIn(1000);
         });
         return false;
}

});

$(function () {

    if ($('#tag-product').length > 0) {
    
      setTimeout(updateTags, 2000); 
      
     } 
});

   function updateTags() {
     var type = $('#type').val();
     $.getScript('/tag.js'+"/" +type);
     setTimeout(updateTags, 2000);
   }
//When the sort drop down is changed this function will be triggered, calling it on the load of the DOM
$(function() {

   $("#sort-grid a.sort").on("click",function() {     
   
     var type = $(this).attr('type');
     var val = $(this).attr('val');
    
       update_grid("sort","#actual-" + type + "-grid","#slide-msg",val,type);
     
     return false;
     
     });
    
});

//This will create the slider on the DOM is loaded on the km-slider div id.
$(function() {

  $("#km-slider").slider({
            animate: "slow",
            min: 0,
            max: 6,
            values: [ 0 ],
            step: 2,
            change: function(event, ui) {
            
            update_grid("slide","#actual-local-grid","#slide-msg",ui.value,"local");
                          
            }
 });
 
 }); 

//This is update the local grid based on the kind, mainly, slide or sort.
function update_grid(kind,resultsDiv,outMsg,values,type){

            var arr = [];
            arr[0] = values;
            i = 1;
            
            dataDiv = "#data-" + kind + " > div";
            
            $(dataDiv).each(function(){
            
              var div = $(this);
              
              arr[i++] = div.data(this.id);
           
            });
            
            if (kind == "slide") {
            
            msg = "Displaying results from within " + arr[0] + " kilometers";
            }
            
            else if (kind == "sort") {
            
            msg = "Sort by filter: "+ values.toUpperCase();
            
            }
            
            param = arr.join("/")
            
            $("#grid-loading").css('display','');
            
            $(resultsDiv).css('display','none');
            
             $.get('/update_'+ type +'_grid/' + param + "/" + kind ,function(data){
            
                    $(resultsDiv).hide().html(data).fadeIn(2000);
            
                    $(outMsg).hide().html(msg).fadeIn(2000);
                    
                });    

}


//multiple area selection home page when DOM is loaded
$(function() {
 
  tokens();
  
});

//Creates the multiple areas text box
function tokens(){
   $("#multiple_area_ids").tokenInput("/areas.json", {
    propertyToSearch: "branch_name",
    crossDomain: false,
    theme: "facebook",
    onAdd: updateNumbers,
    onDelete: updateNumbers,
    prePopulate: $("#multiple_area_ids").data("pre"),
    tokenDelimiter: "-",
    noResultsText: "CrawlFish found no results!",
    searchingText: "CrawlFish is searching...",
    preventDuplicates: true,
    resultsLimit:10,
    tokenLimit:3,
    hintText: "Type an area name..."
  });
 }

//Updates the number of shops and number of areas whenever areas are chosen
function updateNumbers() {
     var area_ids = $("#multiple_area_ids").val();
     var current_city = $('#city_name').data('city_name')
                    $.get('/update_numbers/' + current_city +'/' + area_ids ,function(data){
                    $("#numbers").hide().html(data).fadeIn(1000);
                });
   }
   
/**
* USED FOR MAJOR MENUS
**/
$(function(){
    /**
    * USED IN LEFT MENU IN HOME PAGE
    **/
    $("#left-menus div").click(function(){
         $(this).parent().children().removeClass('active-left-submenu');
         $(this).addClass('active-left-submenu')
    });
   /**
   * USED IN HEADER  SEARCH BOX BY AREA AND PRODUCT NAME
   **/    
   $("#main-tab1 li,#main-tab2 li").click(function(){
     $(this).parent().children().removeClass('active-tab');
     $(this).addClass('active-tab');
     tab($(this));
   });


});
// If you call this tab function, it will change the header based on the tab clicked(online/retail)
function tab(i)
{ 
  var type = i.data("type");
  var li = i.attr("id");
  // Assinging bigger variable to x for readability
  var x = "#token-input-multiple_area_ids";  
//If you click on the retail tab, this function is called
  if (type == "local"){
    //Enabling the areas text box from disabled
    $(x).removeAttr("disabled", "disabled");
    //Updating msgs on the header based on retail tab
    fadeMsgs("#near-com","Multiple areas(adyar, alwarpet, velachery)");
    updateNumbers();
  }
//If you click on the online tab, this function is called  
  else if (type == "online"){  
    //Disabling the areas text box 
    $(x).attr("disabled", "disabled"); 
    //Updating msgs on the header based on online tab
    fadeMsgs("#near-com","For online shops, you cannot choose areas");
    fadeMsgs("#numbers","<b>Near by</b> areas will be disabled!");

  }
   //This is great, a class either "products/price" is assigned to hidden field tag "type" in price and products serach forms, that class name is used to set the value of the hidden_field based on the click on li.
  $("input."+li).val(type);
    
   
}

// This function will take id,class as elem and animate that elem with the passed msg
function fadeMsgs(elem,msg){
  $(elem).hide().html(msg).fadeIn(1000);
}

//conversations.
$(function () {
      if ($('#flash_notice').length > 0) {
        setTimeout(updateComments, 8000);
      }
    });

function updateComments() {
     $.getScript('/converse.js');
     setTimeout(updateComments, 8000);
}

//auto-complete
$(function () {
  $('#prod-search').autocomplete({
    minLength: 0,
    source : "/autocomplete/show",
    messages: {
        noResults: '',
        results: function() {}
    },
  });
});

//auto-complete
$(function () {
  $('#contact-search').autocomplete({
    minLength: 0,
    source : "/autocomplete/show",
    autoFocus: true,
    messages: {
        noResults: '',
        results: function() {}
    },
  });
});

$(function() {
  $("#current_category a").on("click", function() {
    $.getScript(this.href);

    });
});


//=============== jQuery Validations - ANY - Faizal ========================
/**
* TYPE
* N - Number alone
* E - Valid email address
* A - Only alphabet
* AS - Alphabet with space
* AN - AlphaNumeric
* ANS - AlphaNumeric with space
* 
* MAXLENGTH AND MINLENTH IS REQURIED
* 
*/

var errorImg="<img src='/Images/error.png' width='16' height='16'>";
var successImg="<img src='/Images/success.png' width='16' height='16'>";
var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/; 
var numberReg=/^[0-9]*$/;
var onlyLetterReg=/^[a-zA-Z]*$/;
var letterWithSpaceReg=/^[a-zA-Z\s]*$/;
var alphaNumericReg=/^[a-zA-Z0-9]*$/;
var alphaNumericWithSpaceReg=/^[a-zA-Z0-9\s]*$/;
var isValidLength=true;
var isValidForm=true;

function validate(objectId,required,type,minLength,maxLength,errorId){
    var value=$("#"+objectId).val();
    var isNotEmpty=isRequried(objectId,value,required,errorId);
    if(isNotEmpty){
        isValidLength=isValidMinMaxLength(objectId,minLength,maxLength,errorId);
    }else{
        isValidForm=false;
    }
    if(isNotEmpty){
        switch(type){
            case 'A':{
                isValidForm=checkRegExp(onlyLetterReg,objectId,value,errorId);
                break;
            }
            case 'AS':{
                isValidForm=checkRegExp(letterWithSpaceReg,objectId,value,errorId);
                break;
            }
            case 'AN':{
                isValidForm=checkRegExp(alphaNumericReg,objectId,value,errorId);
                break;
            }
            case 'ANS':{
                isValidForm=checkRegExp(alphaNumericWithSpaceReg,objectId,value,errorId);
                break;
            }
            case 'N':{
                isValidForm=checkRegExp(numberReg,objectId,value,errorId);
                break;
            }
            case 'E':{
                isValidForm=checkRegExp(emailReg,objectId,value,errorId);
                break;
            }
        }
    }
    if(!isValidLength){
        isValidForm=false;
        activeError(errorId,objectId);
    }
    return isValidForm;
}

function checkRegExp(regExp,objectId,value,errorId){
var isValid=true;
    if(!regExp.test(value)) {  
        activeError(errorId,objectId);
        isValid=false;
   }else{
        inActiveError(errorId,objectId);
    } 
    return isValid;
}



function isRequried(objectId,value,required,errorId){
var isNotEmpty=true;
    if(required=='Y' && $.trim(value)==''){
        isNotEmpty=false;
        activeError(errorId,objectId);
    }else if(required=='Y'){
        inActiveError(errorId,objectId);
    }
    
    return isNotEmpty;
}

function isValidMinMaxLength(objectId,minLength,maxLength,errorId){
    var isValid = true;
    if(minLength=='' && maxLength!=''){
        isValid=($("#"+objectId).val().length>maxLength) ? false : true;
    }else if(minLength!='' && maxLength==''){
        isValid=($("#"+objectId).val().length<minLength) ? false : true;
    }else{
        isValid=($("#"+objectId).val().length<minLength || $("#"+objectId).val().length>maxLength) ? false : true;
    }
    
    return isValid;
}

function activeError(errorId,objectId){
    $("#"+errorId).html(errorImg);
    $("#"+objectId).addClass("error-box");
}

function inActiveError(errorId,objectId){
    $("#"+errorId).html(successImg);
    $("#"+objectId).removeClass("error-box");
}

//=============== jQuery Validations - ANY - Faizal ========================

