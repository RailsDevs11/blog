class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  
  #define association
  belongs_to :user
  has_many :likes
  has_many :comments
  
  def like(user_id)
    unless Like.where(:user_id => user_id, :post_id => self.id).exists?  
      Like.create(:user_id => user_id, :post_id => self.id  )
    end
  end
  
  def unlike(user_id)
    if Like.where(:user_id => user_id, :post_id => self.id).exists?
      Like.where(:user_id => user_id, :post_id => self.id).first.destroy
    end
  end

  def is_like?(user_id)
    !!Like.where(:user_id => user_id, :post_id => self.id).first
  end
  
  def get_likes_count
    self.likes.count
  end


end
