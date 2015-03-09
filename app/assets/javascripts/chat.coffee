class Chat
  constructor: (attr) ->
    @chat = $('#chat-form')

    # Enable pusher logging - don't include this in production
    Pusher.log = (message) ->
      window.console.log message if window.console && window.console.log

    pusher  = new Pusher 'b6bccaecc617484d8548'
    channel = pusher.subscribe 'test_channel'

    channel.bind 'my_event', (data) ->
      $("#message-#{data.id}").remove()
      $('#btn-input').val ''

      chat_body = $('.chat-body')
      chat_body.append "<div id='message-#{data.id}' style='color: #{data.color}'><div class=header><strong class='primary-font'>#{data.user}</strong><small class='pull-right text-muted'><span class='glyphicon glyphicon-time'></span>#{data.created_at}</small></div><p id='p-#{data.id}'>#{data.message}</p></div>"
      $("#p-#{data.id}").emoticonize { delay: 800, animate: true }

      chat_body.scrollTop chat_body.prop('scrollHeight') #Scroll chat to the bottom of the feed

    @chat.on 'click', '.panel-max-min', (e) ->
      $('#chat-form .panel-body').toggle()
      $('#chat-form .panel-footer').toggle()

    @chat.on 'click', '.user-select', (e) ->
      $('#chat_user_id').val $(e.target).attr('user')
      $('.heading-user').html $(e.target).html()
      e.preventDefault()

$(document).on "ready page:load", ->
  new Chat() if ('#chat-form').length
