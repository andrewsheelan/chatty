$(function(){
  if(('#chat-form').length) {
    // Enable pusher logging - don't include this in production
    Pusher.log = function(message) {
      if (window.console && window.console.log) {
        window.console.log(message);
      }
    };

    var pusher = new Pusher('b6bccaecc617484d8548');
    var channel = pusher.subscribe('test_channel');
    channel.bind('my_event', function(data) {
      $('#message-' + data.id).remove()
      $('#btn-input').val('')
      chatBody = $('.chat-body');
      chatBody.append('<div id="message-' + data.id + '" style="color: ' + data.color + '"><div class="header"><strong class="primary-font">' + data.user + '</strong><small class="pull-right text-muted"><span class="glyphicon glyphicon-time"></span> ' + data.created_at + '</small></div><p>' + data.message + '</p></div>');
      chatBody.scrollTop(chatBody.prop('scrollHeight'));
    });

    $(document).on('click', '#chat-form .panel-max-min', function(e) {
      $('#chat-form .panel-body').toggle()
      $('#chat-form .panel-footer').toggle()
    });

    $(document).on('click', '#chat-form .user-select', function(e){
      $('#chat_user_id').val($(e.target).attr('user'));
      alert($(e.target).attr('user'))
      $('.heading-user').html($(e.target).html());
      e.preventDefault();
    })
  }
});
