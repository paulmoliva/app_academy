module ApplicationHelper
  def auth_token
    "<input type='hidden' name='authenticity_token' value='#{form_authenticity_token}'>".html_safe
  end

  def form_method(method)
    "<input type='hidden' name='_method' value='#{method}'>".html_safe
  end

  def edit_or_create(method)
    method == 'post' ?  'Create' : 'Update'
  end
end
