var posts = tumblr_api_read.posts;

_.templateSettings = {
  interpolate: /\{\{\=(.+?)\}\}/g,
  evaluate: /\{\{(.+?)\}\}/g
};

var blog_view = $('#posts').html();

$('#blog-posts').append(_.template(blog_view, posts));

$(document).ready(function(){
  $('li img').on('click',function(){
    var replace_src = $(this).data('image-500'),
        replace_key = $(this).data('post-key'),
        view_replace = $('.large-blog-photo-' + replace_key);
    $(view_replace).attr("src", replace_src);
  });  
});
