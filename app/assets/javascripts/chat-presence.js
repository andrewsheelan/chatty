if( typeof _presence_chatJSLoaded === 'undefined' || variable === null ) {

  _presence_chatJSLoaded = true;

  $(function(){

    if(('#chat-form').length) {
      // Enable pusher logging - don't include this in production
      Pusher.log = function(message) {
        if (window.console && window.console.log) {
          window.console.log(message);
        }
      };

      var pusher = new Pusher('b6bccaecc617484d8548', { authEndpoint: '/home/presence_auth' });

      var channel = pusher.subscribe('presence-test_channel');
      channel.bind('my_event', function(data) {
        $('#message-' + data.id).remove()
        $('#btn-input').val('')
        chatBody = $('.chat-body');
        chatBody.append('<div id="message-' + data.id + '" style="color: ' + data.color + '"><div class="header"><strong class="primary-font">' + data.user + '</strong><small class="pull-right text-muted"><span class="glyphicon glyphicon-time"></span> ' + data.created_at + '</small></div><p id="p-' + data.id + '">' + data.message + '</p></div>');
        $("#p-" + data.id).emoticonize({
  			  delay: 800,
          animate: true
        });
        chatBody.scrollTop(chatBody.prop('scrollHeight'));
      });

      channel.bind('pusher:subscription_succeeded', function(members) {
        updateMemberCount(members.count);
        clearMemberList();
        updateMemberList(members);
      })

      $(document).on('click', '#chat-form .panel-max-min', function(e) {
        $('#chat-form .panel-body').toggle()
        $('#chat-form .panel-footer').toggle()
      });

      $(document).on('click', '#chat-form .user-select', function(e){
        $('#chat_user_id').val($(e.target).attr('user'));
        $('.heading-user').html($(e.target).html());
        e.preventDefault();
      })
    }
  });

  function updateMemberCount(count) {
    $('.member-count').html(count)
  }
   
  function clearMemberList() {
    $('.member-list').html('')
  }

  function updateMemberList(members) {
    members.each(function(member) {
      var ul = document.getElementById("member-list");
      var li = document.createElement("li");
      li.setAttribute("id", member.id)
      li.appendChild(document.createTextNode(member.info.name + ' (' + member.info.email + ' @ ' + member.info.hostname + ' )' ));
      ul.appendChild(li);
    });
  }

}


