class UserMailer < ActionMailer::Base
    default from: "Range To Go <welcome@range2go.com>"

    def signup_email(user)
        @user = user
        @twitter_message = "#Earn a FREE Portable Driving Range from @RangeToGo Can't wait!"

        mail(:to => user.email, :subject => "Thanks for signing up!")
    end
end
