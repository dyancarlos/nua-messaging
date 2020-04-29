module Payments
  module PaymentProviderFactory
    class Create
      class << self
        def call
          begin
            ::PaymentProviderFactory.provider.debit_card(User.current)
          rescue Exception
            raise ActiveRecord::Rollback
          end
        end
      end
    end
  end
end
