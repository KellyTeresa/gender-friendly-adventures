module ErrorsHelper
  def announce_errors(item)
    count = item.errors.count
    flash[:alert] = %(
      #{count} #{'error'.pluralize(count)}
      prohibited this #{item.class.downcase} from being saved:
      #{item.errors.full_messages.join('. ')}
    )
  end
end
