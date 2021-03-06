module BaseSorts
  extend ActiveSupport::Concern

  included do
    scope :fresh,  -> { order('created_at DESC') }
    scope :oldest, -> { order('created_at ASC')  }
  end

end