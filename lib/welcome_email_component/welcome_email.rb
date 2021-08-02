module WelcomeEmailComponent
  class WelcomeEmail
    include Schema::DataStructure

    attribute :id, String
    attribute :user_id, String
    attribute :email_address, String

    attribute :initiated_time, Time
    attribute :started_time, Time
    attribute :completed_time, Time
    attribute :sent_time, Time

    def initiated?
      !initiated_time.nil?
    end

    def started?
      !started_time.nil?
    end

    def completed?
      !completed_time.nil?
    end

    def started_two_phase_commit?
      started? || completed?
    end

    def sent?
      !sent_time.nil?
    end
  end
end
