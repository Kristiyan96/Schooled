module Authentication
  extend self
  @authenticatable ||= []

  def inclusions
    @authenticatable
  end

  def included(base)
    @authenticatable << base
    base.class_eval do
      has_secure_password
      validates :email, presence: true,
                        uniqueness: { case_sensitive: false },
                        email: true
    end
  end
end
