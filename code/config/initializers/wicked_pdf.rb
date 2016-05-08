WickedPdf.config = {
  #:wkhtmltopdf => '/usr/local/bin/wkhtmltopdf',
  #:layout => "pdf.html",
  #:exe_path => '/home/neo/Downloads/wkhtmltox/bin/wkhtmltopdf'
  :exe_path => "#{Rails.root}/bin/wkhtmltopdf"
  #:exe_path =>'C:\Program Files/wkhtmltopdf/bin/wkhtmltopdf.exe'
}
