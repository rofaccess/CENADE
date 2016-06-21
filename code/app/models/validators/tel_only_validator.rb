class TelOnlyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[\d\s()+-]+\z/i
      record.errors[attribute] << (options[:message] || I18n.t('activerecord.errors.messages.tel_only'))
    end
  end
end