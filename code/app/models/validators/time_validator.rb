class TimeValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /^[0-9]{2}:[0-9]{2}$/i
      record.errors[attribute] << (options[:message] || I18n.t('activerecord.errors.messages.time'))
    end
  end
end