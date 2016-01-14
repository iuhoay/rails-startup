module ApplicationHelper

  # for gravatar
  def avatar_url(email, size)
    gravatar_id = Digest::MD5.hexdigest(email)
    "http://gravatar.com/avatar/#{gravatar_id}.png?s=#{size}"
  end

  def avatar_image(user, size)
    # image_tag avatar_url(user.email, size), class: 'avatar'
    image_tag "data:image/png;base64,#{user.avatar_base}", class: 'avatar', style: "width: #{size}px"
  end

  def link_to_user(user)
    link_to user.name, user_path(user)
  end

  def error_message(obj)
    render partial: 'common/error_message', locals: { obj: obj }
  end

  def format_date(dateTime)
    dateTime.strftime('%Y-%m-%d %H:%M:%S')
  end
end
