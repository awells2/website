$('input[type=radio]').on('change',function() {
   if($(this).attr('id') == 'radio1') {
        $('#oneCompound').show();           
    } else {
        $('#oneCompound').hide();   
    }
});
