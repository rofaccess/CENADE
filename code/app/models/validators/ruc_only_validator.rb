class RucOnlyValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    unless value =~ /\A[0-9\-a-z]+\z/i
      record.errors[attribute] << (options[:message] || I18n.t('activerecord.errors.messages.ruc_only'))
    end
  end
end