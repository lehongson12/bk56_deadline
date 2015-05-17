<% if @answer.errors.any? %>
$('.answer-error').html('<%= escape_javascript(render 'shared/error_messages', obj: @answer) %>');
<% else %>
var answers_list = $('#answers-list');
answers_list.prepend('<%= escape_javascript(render partial: @answer) %>');
answers_list.find('div:last-child').addClass('last-answer');
$('#answers-count').html('This question has <%= escape_javascript(pluralize(@question.answers.count, 'answer')) %>');
$('#answer-form').html('<%= escape_javascript(render('answers/answer_form')) %>');
<% end %>