(function($) {

$(document).ready(function() {
 
 $('#primary')
 .find('#copy_addr').click(function() {
  if ($(this).is(':checked')) {
      $('#employee_perm_addr').val($('#employee_local_addr').val());
      $('#employee_perm_addr').readOnly=true;
      return;
    }
      $('#employee_perm_addr').readOnly=false;
      $('#employee_perm_addr').val("");
 }).end();

$('#primary')
 .find('#new_employee').validationEngine();

$('#primary')
 .find('#new_emp_article').validationEngine();


$('#primary')
 .find('#copy_date').click(function() {
  if ($(this).is(':checked')) {
      $('#leave_end_date_1i').val($('#leave_start_date_1i').val());
      $('#leave_end_date_2i').val($('#leave_start_date_2i').val());
      $('#leave_end_date_3i').val($('#leave_start_date_3i').val());
      $('#leave_end_date_1i').readOnly=true;
      $('#leave_end_date_2i').readOnly=true;
      $('#leave_end_date_3i').readOnly=true;
      $('#leave_end_date_1i').hide();
      $('#leave_end_date_2i').hide();
      $('#leave_end_date_3i').hide();
      $('#leave_end_label').hide();
	}
      return;
      $('#leave_end_date_1i').readOnly=false;
      $('#leave_end_date_2i').readOnly=false;
      $('#leave_end_date_3i').readOnly=false;
      $('#leave_end_date_1i').val("")
      $('#leave_end_date_2i').val("")
      $('#leave_end_date_3i').val("")
}).end();

$('#primary')
 .find('#copy_date').click(function() {

if ($(this).is(':not(:checked)')){
    $('#leave_end_date_1i').show();
    $('#leave_end_date_2i').show();
    $('#leave_end_date_3i').show();
    $('#leave_end_label').show();
}
}).end();




$('#primary')
.find('#employee_mob_no').keyup(function() {
    $('span.error-keyup-3').remove();
    var inputVal = $(this).val();
    var characterReg = /^([0-9]{10,10})$/;
    if(!characterReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-3">Min 10 and only number.</span>');
    }
}).end();
$('#primary')
.find('#employee_phone_no').keyup(function() {
    $('span.error-keyup-3').remove();
    var inputVal = $(this).val();
    var characterReg = /^([0-9]{10,10})$/;
    if(!characterReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-3">Min 10 and only number.</span>');
    }
}).end();



$('#primary')
.find('#employee_pan_no').keyup(function() {
    $('span.error-keyup-3').remove();
    var inputVal = $(this).val();
    var characterReg = /^([a-zA-Z0-9]{10,10})$/;
    if(!characterReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-3">Maximum 10 characters.</span>');
    }
}).end();



$('#primary')
 .find("#emp_gender_male").change(function(){
 if($('input[name="employee[gender]"]:checked').length == 0) {
        alert("gender is not checked");
    }
}).end();




$('#primary')
 .find("#emp_gender_male").blur(function(){
   if ($(this).val() == "") {
            alert("gender not checked");
      }
});


$('#primary')
 .find("#employee_dob_3i").blur(function(){
    if($(this).val() == ''){
        alert('Employee dob date empty?'); 
    }
}).end();


$('#primary')
 .find("#employee_dob_2i").blur(function(){
    if($(this).val() == ''){
        alert('Employee dob month empty?'); 
    }
}).end();

$('#primary')
 .find("#employee_dob_1i").blur(function(){
    if($(this).val() == ''){
        alert('Employee dob year empty?'); 
    }
}).end();


$('#primary')
 .find("#employee_doj_3i").keyup(function(){
    if($(this).val() == ''){
        alert('Employee doj date empty?'); 
    }
}).end();


$('#primary')
 .find("#employee_doj_2i").blur(function(){
    if($(this).val() == ''){
        alert('Employee doj month empty?'); 
    }
}).end();

$('#primary')
 .find("#employee_doj_1i").blur(function(){
    if($(this).val() == ''){
        alert('Employee doj year empty?'); 
    }
}).end();

$('#primary')
 .find("#emp_gender_male").keyup(function(){
    if($(this).val() == ''){
        alert('Employee gender empty?'); 
    }
}).end();


/*
$('#primary')
.find('#employee_last_name').keyup(function() {
    $('span.error-keyup-2').remove();
    var inputVal = $(this).val();
    var characterReg = /^\s*[a-zA-Z,\s]+\s*$/;
    if(!characterReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-2">No special characters</span>');
    }
}).end();


$('#primary')
.find('#employee_first_name').keyup(function() {
    $('span.error-keyup-2').remove();
    var inputVal = $(this).val();
    var characterReg = /^\s*[a-zA-Z,\s]+\s*$/;
    if(!characterReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-2">No special characters allowed.</span>');
    }
}).end();


$('#primary')
.find('#employee_pers_email_id').keyup(function() {
    $('span.error-keyup-7').remove();
    var inputVal = $(this).val();
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    if(!emailReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-7">Invalid Email Format.</span>');
    }
}).end();



$('#primary')
.find('#employee_off_email_id').keyup(function() {
    $('span.error-keyup-7').remove();
    var inputVal = $(this).val();
    var emailReg = /^([\w-\.]+@([\w-]+\.)+[\w-]{2,4})?$/;
    if(!emailReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-7">Invalid Email Format.</span>');
    }
}).end();


$('#primary')
.find('#employee_designation').keyup(function() {
    $('span.error-keyup-2').remove();
    var inputVal = $(this).val();
    var characterReg = /^\s*[a-zA-Z,\s]+\s*$/;
    if(!characterReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-2">No special characters allowed.</span>');
    }
}).end();



$('#primary')
.find('#employee_emp_id').keyup(function() {
    $('span.error-keyup-2').remove();
    var inputVal = $(this).val();
    var characterReg = /^\s*[a-zA-Z,\s]+\s*$/;
    if(!characterReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-2">No special characters</span>');
    }
}).end();

$('#primary')
.find('#employee_local_addr').keyup(function() {
    $('span.error-keyup-6').remove();
    var inputVal = $(this).val();
    var fakeReg = /(.)\1{2,}/;
    if(fakeReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-6">Invalid address.</span>');
    }
}).end();

$('#primary')
.find('#employee_perm_addr').keyup(function() {
    $('span.error-keyup-6').remove();
    var inputVal = $(this).val();
    var fakeReg = /(.)\1{2,}/;
    if(fakeReg.test(inputVal)) {
        $(this).after('<span class="error error-keyup-6">Invalid address.</span>');
    }
}).end();

*/




/*
$('#primary')
 .find("#employee_last_name").blur(function(){
    if($(this).val() == ''){
        alert('Employee last name empty?'); 
    }
}).end();



$('#primary')
 .find("#employee_first_name").blur(function(){
    if($(this).val() == ''){
        alert('Employee first name empty?'); 
    }
}).end();


$('#primary')
 .find("#employee_local_addr").blur(function(){
    if($(this).val() == ''){
        alert('Employee local address empty?'); 
    }
}).end();


$('#primary')
 .find("#employee_perm_addr").blur(function(){
    if($(this).val() == ''){
        alert('Employee permanent address empty?'); 
    }
}).end();

$('#primary')
 .find("#employee_mob_no").blur(function(){
    if($(this).val() == ''){
        alert('Employee Mobile no empty?'); 
    }
}).end();

$('#primary')
 .find("#employee_phone_no").blur(function(){
    if($(this).val() == ''){
        alert('Employee Phone no empty?'); 
    }
}).end();


$('#primary')
 .find("#employee_pan_no").blur(function(){
    if($(this).val() == ''){
        alert('Employee Pan no empty?'); 
    }
}).end();


$('#primary')
 .find("#employee_pers_email_id").blur(function(){
    if($(this).val() == ''){
        alert('Employee Personal e no empty?'); 
    }
}).end();
*/

 $('#primary')
  .find('.leave_apprvl_form').submit(function() {
      $('#leave_action_date').datepicker();
      $('#leave_action_date').datepicker('setDate', 'today');
  }).end();




  
 $('#primary')
 .find('#employee_manager_emp_id').change(function(){
       var emp_id=$(this).val();
   $.ajax({url:'/employees/get_emp_manager_name/' + emp_id,
          type: 'GET',
          dataType: 'json',
          error: function(data){
                alert("Error finding employee with emp id " + emp_id);
                   },
          success: function(data){
             $('#employee_manager_name').val(data.first_name + " " + data.last_name);
                   },
          complete: function(data){
                   }
 
     });
   }).end();

 $('#primary')
 .find('.blog_comment_box').bind('blur', function() {
     //alert($('#welcome').text());
     var commentator=$('#ols_user').text();
     var cfn=commentator.split(" ")[0];
     var cln=commentator.split(" ")[1];
     var comment_txt=$('.blog_comment_box').val();
     var art_id=window.location.href.toString().match(/\/\d+\//).toString().split("/").join("");
     //alert(cln);
     $('<div id="comment_body">' + $(this).val() + '</div><br/>').prependTo($('#blog_com'));
     $('<span id="blog_commenter">' +  commentator + ' says: </span><br/>').prependTo($('#blog_com'));
     $.ajax({url:'/articles/' + art_id +  '/save_comment/',
             type:'POST',
             dataType: 'json',
             data:{ comment: { article_id:art_id, commentator_first_name: cfn, commentator_last_name:cln, body: comment_txt}},
             success: function(){
                 //alert("It works!");
             }
  });
     //$(this).val("");
 }).end();

 $('#my_leaves').children('li').hide();
 $('#my_hols').children('li').hide();
 $('#emp_dtl_links').children('li').hide();
 $('#leave_credits').children('li').hide();
 $('#emp_blogs_links').children('li').hide();


  $('#my_leaves').click(function(){
     $(this).children('li').slideToggle("slow"); 
  });

 
 
 $('#my_hols').click(function(){
    $(this).children('li').slideToggle("slow"); 
  });
  

 $('#emp_dtl_links').click(function(){
   $(this).children('li').slideToggle("slow"); 
  });

 $('#leave_credits').click(function(){
   $(this).children('li').slideToggle("slow"); 
  });

  $('#emp_blogs_links').click(function(){
   $(this).children('li').slideToggle("slow"); 
  });
 
  

 $('#primary')
 .find('#new_employee').submit(function() {
      //alert("Hello");
      var emp=$('#primary').find('#employee_emp_id').val();
      $('#employee_leaves_attributes_0_requester_emp_id').val(emp);
      $('#employee_leaves_attributes_1_requester_emp_id').val(emp);
      $('#employee_leaves_attributes_2_requester_emp_id').val(emp);
      $('#employee_leaves_attributes_3_requester_emp_id').val(emp);
 }).end();



 

 $('#primary')
 .find('.emp_form').multipage();

 $('#flash_notice, #flash_error').setup_notices();

});


$.fn.extend({
  setup_notices: function() {
    return this.each(function() {
      var $this = $(this), timeout;
      
      var hang_time = 5000;
      if($this.has('ul.error_messages')) {
         hang_time = 10000;
      }
      
      if ( !$this.has('ul li') ) return;
      $this
        .dialog({
          dialogClass: $this.is('.notice') ? 'notice_dialog' : 'error_dialog',
          draggable: false, bgiframe: true, width: 'auto', height: 'auto', minHeight: 0
        })
        .bind('mouseenter mouseleave', function(event) {
          if ( event.type == 'mouseenter' ) clearTimeout(timeout);
          else timeout = setTimeout(function() { $this.dialog('destroy').css('display', '').find('ul').empty(); }, 800);
        });
      timeout = setTimeout(function() { $this.dialog('destroy').css('display', '').find('ul').empty(); }, hang_time);
    });
  },

copy_addr:function() {
  var $this = $(this), timeouot;
  if ($this.attr("checked")) {
      $('#employee_perm_addr').val($('#employee_local_addr').val());
       $('#employee_perm_addr').readOnly=true;
       return;
    }
      $('#employee_perm_addr').readOnly=false;
      $('#employee_perm_addr').val("");
 }
});

 })( jQuery );
