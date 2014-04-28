# Mechanisms for ensuring UUID properties exist on ActiveRecord-compatible models
# @api public
module EnsureUuid
  extend ActiveSupport::Concern

  included do
    validates :uuid, presence: true, uniqueness: true
    before_validation :ensure_uuid

    def self.ensures_uuid?
      true
    end
  end

  # @api private
  # @return [String] a UUID
  def ensure_uuid
    self.uuid ||= UUID.generate
  end
end
