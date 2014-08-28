class UserMailer < ActionMailer::Base
    default from: "Range To Go <welcome@range2go.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "#Furniture is evolving. Excited for @Range To Go to launch."

        mail(:to => user.email, :subject => "Thanks for signing up!")
    end
end
