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
    end
  end
end
