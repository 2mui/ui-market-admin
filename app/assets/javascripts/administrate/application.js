//= require jquery
//= require jquery_ujs
//= require selectize
//= require moment
//= require datetime_picker
//= require_tree .


$(function(){
  $('.tags select').selectize({
    delimiter: ",",
    persist: false,
    placeholder: '["PSD", "XD", "AI", "Sketch"]'
  });
})
