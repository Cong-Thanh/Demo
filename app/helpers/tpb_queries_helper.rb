module TpbQueriesHelper
  def format_string(s)
    s.gsub /(\.|-|_)/, " "
  end
end