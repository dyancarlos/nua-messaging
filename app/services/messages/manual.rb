module Messages
  class Manual < Base
    def body
      params[:body]
    end

    def inbox
      if User.current.inbox.messages.last.created_at > Time.now + 1.week
        return User.default_admin.inbox
      end

      User.default_doctor.inbox
    end
  end
end

