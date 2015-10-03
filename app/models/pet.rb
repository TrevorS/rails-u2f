# == Schema Information
#
# Table name: pets
#
#  id         :integer          not null, primary key
#  color      :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Pet < ActiveRecord::Base
  belongs_to :user
end
