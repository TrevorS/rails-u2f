# == Schema Information
#
# Table name: u2f_devices
#
#  id          :integer          not null, primary key
#  key_handle  :string
#  public_key  :string
#  certificate :string
#  counter     :integer
#  user_id     :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class U2fDevice < ActiveRecord::Base
  belongs_to :user
end
