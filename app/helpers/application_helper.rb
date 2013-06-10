# encoding: utf-8
module ApplicationHelper

  def format_time(time)
    time.strftime("le %m/%d/%Y à %H:%M")
  end

end
