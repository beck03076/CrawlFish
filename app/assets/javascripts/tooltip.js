/**
* IMAGE PREVIEW JQUERY
* DATE - 26/04/20132
**/

this.imagePreview = function(){    
    /* CONFIG */
        
        xOffsetX = 180;
        yOffsetY = 40;
        var differenceWidth=0;
        
    /* END CONFIG */
    $(".preview").hover(function(e){
        this.t = this.title;
        this.title = "";    
        var c = (this.t != "") ? "" + this.t : "";
        differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
        if(differenceWidth<450){
            yOffsetY=-400;
        }else{
            yOffsetY=40;
            }
        
        $("body").append("<div id='preview'><table><tr><td valign='bottom'><center><span class='image-tr-cover'><img src='"+ this.src +"' alt='Image preview' width='500' /></center></td></tr><tr><td valign='top' width='200'></span><span class='text-n12'>"+ c +"</span></td></tr></table></div>");                                 
        $("#preview")
            .css("top",(e.pageY - xOffsetX) + "px")
            .css("left",(e.pageX + yOffsetY) + "px")
            .fadeIn("fast");                        
    },
    function(){
        this.title = this.t;    
        $("#preview").remove();
    });    
    $(".preview").mousemove(function(e){
        differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
        if(differenceWidth<450){
            yOffsetY=-400;
        }else{
            yOffsetY=40;
            }
        $("#preview")
            .css("top",(e.pageY - xOffsetX) + "px")
            .css("left",(e.pageX + yOffsetY) + "px");
    });        
    
    
    /* END CONFIG */
    $(".image-tr-cover").hover(function(e){
        
        this.previewImageURL = $(this).find("img").attr("src");
        var c = ($(this).find("img").attr("title") != "") ? "" + $(this).find("img").attr("title") : "";
        var imgClasses=$(this).find("img").attr("class");
        if(imgClasses.search("preview")>0){
        differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
        if(differenceWidth<450){
            yOffsetY=-400;
        }else{
            yOffsetY=40;
            }
        
        $("body").append("<div id='preview'><table><tr><td valign='bottom'><center><img src='"+ this.previewImageURL +"' alt='Image preview' width='500' /></center></td></tr><tr><td valign='top' width='200'><span class='text-n12'>"+ c +"</span></td></tr></table></div>");                                 
        $("#preview")
            .css("top",(e.pageY - xOffsetX) + "px")
            .css("left",(e.pageX + yOffsetY) + "px")
            .fadeIn("fast");    
        }
    },
    function(){
        //this.title = this.t;    
        $("#preview").remove();
    });    
    $(".preview").mousemove(function(e){
        differenceWidth=parseInt($(window).width())-parseInt(e.pageX);
        if(differenceWidth<450){
            yOffsetY=-400;
        }else{
            yOffsetY=40;
            }
        $("#preview")
            .css("top",(e.pageY - xOffsetX) + "px")
            .css("left",(e.pageX + yOffsetY) + "px");
    });    
};


/**
* TOOLTIPS JQUERY
* DATE - 26/04/20132
**/
this.tooltip = function(){    
    /* CONFIG */        
        xOffset = 10;
        yOffset = 20;        
    /* END CONFIG */        
    $(".tooltip").hover(function(e){                                              
        this.t = this.title;
        this.title = "";                                      
        $("body").append("<span id='tooltip'>"+ this.t +"</span>");
        $("#tooltip")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px")
            .fadeIn("fast");        
    },
    function(){
        this.title = this.t;        
        $("#tooltip").remove();
    });    
    $(".tooltip").mousemove(function(e){
        $("#tooltip")
            .css("top",(e.pageY - xOffset) + "px")
            .css("left",(e.pageX + yOffset) + "px");
    });            
};

$(document).ready(function(){
    imagePreview();
    tooltip();
});

