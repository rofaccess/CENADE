class NumberOnlyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[0-9]+\z/i
      record.errors[attribute] << (options[:message] || I18n.t('activerecord.errors.messages.number_only'))
    end
  end
end