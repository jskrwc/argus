// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$("a.disabled").on("click", function(event){
    alert("it worked");
        event.preventDefault();
});
