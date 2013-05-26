module ApplicationHelper
  
  #custom message helper
  #use every where need to show error message box
  def error_message(err_msg, classes)
    unless err_msg.blank?
      content_tag(:div, :class=> classes) do
        list_items = err_msg.map { |msg| content_tag(:li, msg) }
        content_tag(:ul, content_tag(:a,'&times'.html_safe, :class=>"close", 'data-dismiss'=>"alert") + list_items.join.html_safe, :class=>"set_err_msg" )
      end
    end
  end  
  
  #date helper that will show mm/dd/yyyy h:m format  
  def date_formate(date)
    return nil if date.blank?
    date.strftime('%m/%d/%Y %I:%M %p')
  end

  #date helper that will only show date
  def day_format(date)
    return nil if date.blank?
    date.strftime('%d')
  end

  #date helper that will show month name like jan, feb, may etc....
  def month_format(date)
    return nil if date.blank?
    date.strftime('%b')
  end

  #it will return like or unlike status with count of likes
  #like 1 like or 0 unlike
  def like_status(post_id)
    post = Post.where(:id => post_id).first
    count = "<span class='badge badge-success'> #{post.get_likes_count} &nbsp</span>".html_safe
    post.is_like?(current_user.id) ? count+" UnLike" : count+" Like" if current_user.present?
  end 

  #
  def truncate_string(str , length)
    return str.truncate(length, :separator => '...') rescue ''
  end
end
