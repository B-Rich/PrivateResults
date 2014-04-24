module EnsureUuid
  extend ActiveSupport::Concern

  included do
    validates :uuid, presence: true, uniqueness: true
    before_validation :ensure_uuid

    def self.ensures_uuid?
      true
    end
  end

  def ensure_uuid
    self.uuid ||= UUID.generate
  end
end
