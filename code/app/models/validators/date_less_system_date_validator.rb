class DateLessSystemDateValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value <= Date.today
      record.errors[attribute] << (options[:message] || I18n.t('activerecord.errors.messages.date_less_system_date'))
    end
  end
end