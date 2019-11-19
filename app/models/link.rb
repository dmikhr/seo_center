class Link < ApplicationRecord
  belongs_to :page

  def internal?
    self.internal
  end

  def external?
    !internal?
  end
end
