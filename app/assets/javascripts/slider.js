$(function() {
  $('.slick').slick({
      arrows:false,
      asNavFor:'.thumb',
      autoplay:true,
      autoplaySpeed:2000,
  });
  $('.thumb').slick({
      asNavFor:'.slick',
      focusOnSelect: true,
      slidesToShow:5,
      // slidesToScroll:1
  });  
});  
