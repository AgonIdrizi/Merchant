
  
    function fill(){
      var d = document.getElementsByTagName('select');
      var options = document.getElementById('confirm_form_shipping_address_id').children;
      var options_array = Array.from(options);

      options_array.find(element => {
        if (element.value == d[0].value){
        
          let line1 = document.getElementById("confirm_form_line1");
          let line2 = document.getElementById("confirm_form_line2");
          let city = document.getElementById("confirm_form_city");
          let state = document.getElementById("confirm_form_state");
          let zip = document.getElementById("confirm_form_zip");

          let option = d[0][options_array.indexOf(element)].innerHTML.split(",");
          line1.value = option[0];
          line2.value = option[1];
          city.value = option[2];
          state.value = option[3];
          zip.value = option[4];
        }
      });
    };
  //window.onload = fill;
  document.addEventListener('DOMContentLoaded', fill(), false);

    

  //document.querySelector('select[name="confirm_form[shipping_address_id]"]').onchange = fill;
