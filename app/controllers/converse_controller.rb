class ConverseController < ApplicationController
skip_before_filter :set_start_time,:set_city,:help_update_numbers

  def fetch

    @conversation = Conversation.where(:validity => 1).first(:order => "RAND()")
    if @conversation.priority == 0
      @conversation.validity = 0
      @conversation.save
    end

  end

end

