module Authentication
  extend self
  @authenticatable ||= []

  def inclusions
    @_cache_models ||= models.map(&:to_s)
  end

  def types
    @_cache_types ||= @authenticatable.map(&:to_s).map { |t| [t, t] }
  end

  def models
    @authenticatable
  end

  def register(base)
    @authenticatable << base
  end

  def included(base)
    base.class_eval do
      has_secure_password
      validates :email, presence: true,
                        uniqueness: { case_sensitive: false },
                        email: true
    end
  end
end
