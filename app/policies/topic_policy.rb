class TopicPolicy < ApplicationPolicy
  def destroy?
    user.role == 'admin'   #only admins can delete topics
  end
end
