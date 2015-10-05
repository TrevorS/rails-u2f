module U2fHelper
  extend ActiveSupport::Concern

  included do
    def u2f
      @u2f ||= U2F::U2F.new('https://localhost:3000')
    end
  end
end
