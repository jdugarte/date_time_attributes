module DateTimeAttribute

  class Railtie < Rails::Railtie

    initializer 'date_time_attributes.include' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.send :extend, DateTimeAttributes
      end
    end

  end

end

