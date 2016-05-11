# use AMD64 library for heroku, Darwin library for OSX
on_heroku = !ENV.keys.select{|k| k.starts_with?("HEROKU")}.empty?
executable = on_heroku ? "wkhtmltopdf-linux-amd64" : "wkhtmltopdf-darwin"

wkhtmltopdf_path = File.expand_path "../../bin/#{executable}", __FILE__

begin
  require 'pdfkit'
  PDFKit.configure do |config|
    config.wkhtmltopdf = wkhtmltopdf_path
  end
rescue LoadError
end

begin
  require 'wicked_pdf'
  WickedPdf.config[:exe_path] = wkhtmltopdf_path
rescue LoadError
end