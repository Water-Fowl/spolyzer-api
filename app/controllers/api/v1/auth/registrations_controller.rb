# frozen_string_literal: true

class Api::V1::Auth::RegistrationsController < DeviseTokenAuth::RegistrationsController
  def create
    @resource            = resource_class.new(sign_up_params.except(:confirm_success_url))
    @resource.provider   = 'email'

    # honor devise configuration for case_insensitive_keys
    @resource.email = if resource_class.case_insensitive_keys.include?(:email)
                        sign_up_params[:email].try :downcase
                      else
                        sign_up_params[:email]
                      end

    # give redirect value from params priority
    @redirect_url = sign_up_params[:confirm_success_url]

    # fall back to default value if provided
    @redirect_url ||= DeviseTokenAuth.default_confirm_success_url

    # success redirect url is required
    return render_create_error_missing_confirm_success_url unless @redirect_url

    # if whitelist is set, validate redirect_url against whitelist
    if DeviseTokenAuth.redirect_whitelist
      unless DeviseTokenAuth::Url.whitelisted?(@redirect_url)
        return render_create_error_redirect_url_not_allowed
      end
    end

    begin
      # override email confirmation, must be sent manually from ctrl
      resource_class.set_callback('create', :after, :send_on_create_confirmation_instructions)
      resource_class.skip_callback('create', :after, :send_on_create_confirmation_instructions)
      if @resource.respond_to? :skip_confirmation_notification!
        # Fix duplicate e-mails by disabling Devise confirmation e-mail
        @resource.skip_confirmation_notification!
      end
      if @resource.save
        yield @resource if block_given?

        if @resource.confirmed?
          # email auth has been bypassed, authenticate user
          @client_id, @token = @resource.create_token

          @resource.save!

          update_auth_header
        else
          # user will require email authentication
          @resource.send_confirmation_instructions(
            client_config: params[:config_name],
            redirect_url: @redirect_url
          )

        end
        render_create_success
      else
        clean_up_passwords @resource
        render_create_error
      end
    rescue ActiveRecord::RecordNotUnique
      clean_up_passwords @resource
      render_create_error_email_already_exists
    end
  end

  private

  def sign_up_params
    params.permit(:name, :email, :sport_id, :password, :password_confirmation)
  end
end
