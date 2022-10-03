class Calculation
  def self.calculate_file_ammount(issuedbook)
      if @issuedbook.return_dt.day => DateTime.now.day
          0
        else
          days =   (DateTime.now.to_i) - (@issuedbook.return_dt.to_i)
          late_days = (days/1.day).to_i
          case late_days
          when 1..30
            late_days * 7
          when 30..60
            late_days * 15
          when 60..90
            late_days * 25
          end
        end
  end
end