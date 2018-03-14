$ ->
  $('.edit-answer-link').click (e) ->
    e.preventDefault()
    $(this).hide()
    answer_id = $(this).data('answerId')
    $('form#edit-answer-' + answer_id).show()

  #$('form#new_answer').bind 'ajax:success', (e, data, status, xhr) ->
    #detail = event.detail
    #data = detail[0]
    #status = detail[1]
    #xhr = detail[2]
    #console.log(detail)
    #console.log('data: ' + data)
    #console.log('status: ' + status)
    #console.log('xhr: ' + xhr)
    #$('.answers').append('<p>' + data.body + '</p>')
  #.bind 'ajax:error', (e, xhr, status, error) ->
    #detail = event.detail
    #data = detail[0]
    #status = detail[1]
    #xhr = detail[2]
    #console.log('data: ' + data)
    #console.log('status: ' + status)
    #console.log('xhr: ' + xhr)
    #$('.answer-errors').html(data)

  questionId = $('.answers').data('questionId')
  PrivatePub.subscribe '/questions/' + questionId + '/answers', (data, channel) ->
    console.log(data)
    answer = $.parseJSON(data['answer'])
    $('.answers').append('<p>' + answer.body + '</p>')
    $('.answers').append('<p><a href="#">Edit</a></p>')
    $('.new_answer #answer_body').val('')
