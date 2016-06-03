include ActionView::Helpers::NumberHelper

module Formatter

  DATE_FORMAT = "%d/%m/%Y"
  DATETIME_FORMAT = "%d/%m/%Y - %H:%M"

  def Formatter.format_date(date)
    (date != NIL) ? date.strftime(DATE_FORMAT) : NIL
  end

  def Formatter.format_datetime(datetime)
    (datetime != NIL) ? datetime.strftime(DATETIME_FORMAT) : NIL
  end

  def Formatter.to_money(monto)
	number_with_precision(monto, precision: 0, separator: ',', delimiter: '.')
  end
  def Formatter.month(month)
    t(month.to_s)
  end

end