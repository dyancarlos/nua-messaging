module Messages
  class Create
    class << self
      def call
        create_message
      end

      private

      def create_message
        Message.create!(body: body, outbox: outbox, inbox: inbox)
      end

      def body
        "The patient #{User.current.full_name} is requesting a new script."
      end

      def outbox
        User.current.outbox
      end

      def inbox
        User.default_admin.inbox
      end
    end
  end
end
