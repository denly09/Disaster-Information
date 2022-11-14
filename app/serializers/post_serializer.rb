class PostSerializer < ActiveModel::Serializer
  attributes :title, :created_at, :content, :author, :comments_count

  def created_at
    object.created_at.strftime("%F %H:%M:%S")
  end

  def author
    object.user.email
  end

end
