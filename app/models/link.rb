class Link < ApplicationRecord
  belongs_to :page

  def internal?
    internal
  end

  def external?
    !internal?
  end
end
