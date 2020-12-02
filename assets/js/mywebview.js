
$(document).ready(function(){
    var all = document.getElementsByClassName('header');
    for (var i = 0; i < all.length; i++) {
      all[i].style.display = 'none';
    }

    var promote = document.getElementsByClassName('promote-navbar');
    for (var i = 0; i < promote.length; i++) {
      promote[i].style.display = 'none';
    }
    document.getElementById("footer").style.display = "none";

});
