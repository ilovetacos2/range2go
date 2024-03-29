class User < ActiveRecord::Base
    belongs_to :referrer, :class_name => "User", :foreign_key => "referrer_id"
    has_many :referrals, :class_name => "User", :foreign_key => "referrer_id"
    
    attr_accessible :email

    validates :email, :uniqueness => true, :format => { :with => /\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*/i, :message => "Invalid email format." }
    validates :referral_code, :uniqueness => true

    before_create :create_referral_code
    after_create :send_welcome_email

    REFERRAL_STEPS = [
        {
            'count' => 5,
            "html" => "10% OFF",
            "class" => "two",
            "image" =>  ActionController::Base.helpers.asset_path("refer/reward1.png")
        },
        {
            'count' => 10,
            "html" => "20% OFF",
            "class" => "three",
            "image" => ActionController::Base.helpers.asset_path("refer/reward2.png")
        },
        {
            'count' => 25,
            "html" => "50% OFF",
            "class" => "four",
            "image" => ActionController::Base.helpers.asset_path("refer/reward3.png")
        },
        {
            'count' => 50,
            "html" => "Range to Go",
            "class" => "five",
            "image" => ActionController::Base.helpers.asset_path("refer/reward4.png")
        }
    ]

    private

    def create_referral_code
        referral_code = SecureRandom.hex(5)
        @collision = User.find_by_referral_code(referral_code)

        while !@collision.nil?
            referral_code = SecureRandom.hex(5)
            @collision = User.find_by_referral_code(referral_code)
        end

        self.referral_code = referral_code
    end

    def send_welcome_email
        UserMailer.delay.signup_email(self)
    end
end
