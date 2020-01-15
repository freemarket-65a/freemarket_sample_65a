$(document).on('turbolinks:load', ()=> {
  // 画像用のinputを生成する関数
  const buildFileField = (num)=> {
    const html = `<div data-index="${num}" class="js-file_group">
                    <input class="js-file" type="file"
                    name="exhibit[images_attributes][${num}][src]"
                    id="exhibit_images_attributes_${num}_src"><br>
                    <div class="js-remove">削除</div>
                  </div>`;
    return html;
  }

  $(function() {

    //イメージの挿入
    var dropzone = $('.dropzone-area');
    var images = [];
    var inputs  =[];
    var input_area = $('.input_area');
    var preview = $('#preview');

    $(document).on('change', 'input[type= "file"].upload-image',function(event){
      var file = $(this).prop('files')[0];
      var reader = new FileReader();
      inputs.push($(this));
      var img = $(`<div class= "img_view"><img></div>`);
      reader.onload = function(e) {
        var btn_wrapper = $('<div class="upload-image__prev--btn"><div class="edit-btn">編集</div><div class="delete-btn">削除</div></div>');
        img.append(btn_wrapper);
        img.find('img').attr({src: e.target.result
        })
      }
      reader.readAsDataURL(file);
      images.push(img);
          $('#preview').empty();
          $.each(images, function(index, image) {
            image.attr('data-image', index);
            preview.append(image);
          })
          dropzone.css({
            'width': `calc(100% - (120px * ${images.length}))`
          })
        if(images.length == 5) {
          $(".dropzone-area").attr('id', 'nothing');
        }
      // 新しいインプットの表示

      var new_image = $(`<input id="upload-image__btn" class="upload-image" data-image= ${images.length} type="file" name="exhibit[images_attributes][${images.length}][src]">`);
      input_area.prepend(new_image);
    });

    // 削除と編集
    $(document).on('click', '.delete-btn', function() {
      var target_image = $(this).parent().parent();
      $.each(inputs, function(index, input){
        if ($(this).data('image') == target_image.data('image')){
          $(this).remove();
          target_image.remove();
          var num = $(this).data('image');
          images.splice(num, 1);
          inputs.splice(num, 1);
          if(inputs.length == 0) {
            $('input[type= "file"].upload-image').attr({
              'data-image': 0
            })
          }
        }
      })
      $('input[type= "file"].upload-image:first').attr({
        'data-image': inputs.length
      })
      $.each(inputs, function(index, input) {
        var input = $(this)
        input.attr({
          'data-image': index
        })
        $('input[type= "file"].upload-image:first').after(input)
      })
        dropzone.css({
          'display': 'block'
        })
        $.each(images, function(index, image) {
          image.attr('data-image', index);
          preview.append(image);
        })
        dropzone.css({
          'width': `calc(100% - (120px * ${images.length}))`
        })
    })

    
  //価格表示
  $('#sell-price').on('keyup', function(){
    var price = $(this).val();
    var mercari_fee = Math.floor(price * 0.1)
    var seller_gain = price - mercari_fee

    // 画像入力欄が0個にならないようにしておく
    // if ($('.js-file').length == 0) $('#image-box').append(buildFileField(fileIndex[0]));

    if (price >= 300 && price <= 9999999) {
      $('#mercari_fee').text('¥' + mercari_fee.toLocaleString())
      $('#seller_gain').text('¥' + seller_gain.toLocaleString())
    } else {
      $('#mercari_fee').text('--')
      $('#seller_gain').text('--')
    }
  })
  })
});

// $('#article_lists').append("<%= escape_javascript(render @exhibits, object: @articles) %>");
// $("#view_more").replaceWith("<%= escape_javascript(link_to_next_page(@exhibits, 'もっと見る', remote: true, id: 'view_more')) %>");


// $('.slider').slick({
//     arrows:false,
//     asNavFor:'.thumb',
// });
// $('.thumb').slick({
//     asNavFor:'.slider',
//     focusOnSelect: true,
//     slidesToShow:5,
//     slidesToScroll:1
// });    
