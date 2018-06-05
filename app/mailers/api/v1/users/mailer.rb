class Api::V1::Users::Mailer < Devise::Mailer
  helper :application # gives access to all helpers defined within `application_helper`.
  include Devise::Controllers::UrlHelpers # Optional. eg. `confirmation_url`

    def confirmation_instructions(record, token, opts={})
      mail = super
      # your custom logic
      mail.subject = "Spolyzer登録確認メール"
      mail
    end

    def reset_password_instructions(record, token, opts={})
      @token = token
      devise_mail(record, :reset_password_instructions, opts)
    end

    def unlock_instructions(record, token, opts={})
      @token = token
      devise_mail(record, :unlock_instructions, opts)
    end

    def email_changed(record, opts={})
      devise_mail(record, :email_changed, opts)
    end

    def password_change(record, opts={})
      devise_mail(record, :password_change, opts)
    end

end
