class Authentication
  def initialize(params, omniauth = nil)
    @params = params
    @omniauth = omniauth
  end

  def user
    @user ||= @omniauth ? user_from_omniauth : user_with_password
  end

  def authenticated?
    user.present?
  end

  private
    def user_from_omniauth
      User.where(@omniauth.slice(:info['email'])).first_or_initialize.tap do |user|
        puts "==========#{user.name} #{user.email}"
        user.name = @omniauth.info.name
        user.email = @omniauth.info.email if user.email == nil
        user.save!
        identity = Identity.find_by_provider_and_uid(
                  @omniauth['provider'],
                  @omniauth['uid'].to_s)
        if identity.nil?
          identity = Identity.create(uid: @omniauth['uid'],
                                provider: @omniauth['provider'],
                                 user_id: user.id)
        end
      end
    end

    def user_with_password
      user = User.find_by(email: params[:email])
      user && user.authenticate(params[:email], params[:password])
    end

end