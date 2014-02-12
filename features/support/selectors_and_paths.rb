module HtmlSelectorsHelpers
  def selector_for(locator)
    case locator
      when "Edit profile" then
        return 'form#edit-details'
      else
        raise "Can't find mapping from \"#{locator}\" to a selector.\n" +
              "Now, go and add a mapping in #{__FILE__}"
    end
  end
end

World(HtmlSelectorsHelpers)

module PathSelectorHelpers
  def path_to(page_name, id = '')
  name = page_name.downcase
  case name
    when 'home' then
      ''
    when 'signin' then
      '/sessions/new'
    when 'edit_admin' then
      id = @admin.id
      "/admins/#{id}/edit"
    when 'new quiz' then
      '/quizzes/new'
    when 'edit_quiz' then
      id = @quiz.id
      "/quizzes/#{id}/edit"
    when 'quizzes' then
      '/quizzes'
    when "show quiz"
      id = @quiz.id
      "/quizzes/#{id}"
    else
      raise('path to specified is not listed in #path_to')
    end
  end
end

World(PathSelectorHelpers)