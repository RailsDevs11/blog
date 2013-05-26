class Post < ActiveRecord::Base
  attr_accessible :content, :title, :user_id
  
  #define validation
  validates :title, :presence => true
  scope :created_at_order, order('created_at DESC')

  #define association
  belongs_to :user
  has_many :likes
  has_many :comments
  
  #check and create like crossponding of user and post
  def like(user_id)
    unless is_like?(user_id)  
      Like.create(:user_id => user_id, :post_id => self.id  )
    end
  end
  
  #destroy the like if user click on unlike
  def unlike(user_id)
    if is_like?(user_id)
      Like.where(:user_id => user_id, :post_id => self.id).first.destroy
    end
  end

  #return true and false for like 
  def is_like?(user_id)
    !!Like.where(:user_id => user_id, :post_id => self.id).first
  end
  
  #return total count of like
  def get_likes_count
    self.likes.count
  end
  
  #return full name of post's owner
  def post_user_name
    self.user.full_name
  end
  
end
