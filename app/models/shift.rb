class Shift < ApplicationRecord
  validates_presence_of :start_date, :end_date, :start_time, :end_time
  belongs_to :invoice, optional: true
  before_save :generate_quantity, :generate_ob_hours

  def generate_time_difference
    def time_difference(time_a, time_b)
      difference = time_b - time_a
      if difference > 0
        difference
      else
        24 * 3600 + difference
      end
    end
    a = self.start_time
    b = self.end_time
    time_difference(a, b) / 3600
  end

  def gen_t_diff(a, b)
    def time_difference(time_a, time_b)
      difference = time_b - time_a
      if difference > 0
        difference
      else
        24 * 3600 + difference
      end
    end
    time_difference(a, b) / 3600
  end

  def ob_1
    22.84
  end

  def ob_2
    20.13
  end

  private

  def generate_quantity
    self.quantity = self.generate_time_difference
  end

  def generate_ob_hours
    start = self.start_time.strftime("%H:%M")
    ending = self.end_time.strftime("%H:%M")
    if ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday'].include? self.start_date.strftime("%A")
      if start >= '20:00' && start < '23:59'
        if ending > '20:00' && ending <= '23:59'
          self.ob_amount = (self.generate_time_difference * self.ob_1).round
        elsif ending >= '00:00' && ending <= '01:00'
          self.ob_amount = (self.generate_time_difference * self.ob_1).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        elsif ending > '06:00' && ending <= '20:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (5 * self.ob_1) + ( 5 * self.ob_2)).round
        end
      elsif start >= '00:00' && start < '01:00'
        if ending > '00:00' && ending <= '01:00'
          self.ob_amount = (self.generate_time_difference * self.ob_1).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        elsif ending > '06:00' && ending <= '20:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2)).round
        elsif ending > '20:00' && ending <= '23:59'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2) + (self.gen_t_diff('20:00'.to_time, ending.to_time) * self.ob_1)).round
        end
      elsif start >= '01:00' && start <= '06:00'
        if ending >= '00:00' && ending <= '01:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (self.gen_t_diff('20:00'.to_time, ending.to_time) * self.ob_1)).round
        elsif ending > '01:00' && ending <= '06:00'
          if self.start_date == self.end_date
            self.ob_amount = ((self.generate_time_difference * self.ob_1) + (self.generate_time_difference * self.ob_2)).round
          elsif self.start_date < self.end_date
            self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (5 * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
          end
        elsif ending > '06:00' && ending <= '20:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2)).round
        elsif ending > '20:00' && ending <= '23:59'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (self.gen_t_diff('20:00'.to_time, ending.to_time) * self.ob_1)).round
        end
      elsif start >= '06:00' && start < '20:00'
        if ending > '20:00' && ending <= '23:59'
          self.ob_amount = (self.gen_t_diff('20:00'.to_time, ending.to_time) * self.ob_1).round
        elsif ending >= '00:00' && ending <= '01:00'
          self.ob_amount = (self.gen_t_diff('20:00'.to_time, ending.to_time) * self.ob_1).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((5 * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        elsif ending > '06:00' && ending <= '20:00'
          if self.start_date == self.end_date
            self.ob_amount = 0
          elsif self.start_date < self.end_date
            self.ob_amount = ((5 * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2)).round
          end
        end
      end

    elsif ['Saturday'].include? self.start_date.strftime("%A")
      if start >= '16:00' && start < '23:59'
        if ending > '16:00' && ending <= '23:59'
          if self.start_date == self.end_date
            self.ob_amount = (self.generate_time_difference * self.ob_1).round
          elsif self.start_date < self.end_date
            self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2) + (self.gen_t_diff('06:00'.to_time, ending.to_time) * self.ob_1)).round
          end
        elsif ending >= '00:00' && ending <= '01:00'
          self.ob_amount = (self.generate_time_difference * self.ob_1).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        elsif ending > '06:00' && ending <= '16:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2) + (self.gen_t_diff('06:00'.to_time, ending.to_time) * self.ob_1)).round
        end
      elsif start >= '00:00' && start < '01:00'
        if ending > '00:00' && ending <= '01:00'
          self.ob_amount = (self.generate_time_difference * self.ob_1).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        elsif ending > '06:00' && ending <= '16:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2)).round
        elsif ending > '16:00' && ending <= '23:59'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2) + (self.gen_t_diff('16:00'.to_time, ending.to_time) * self.ob_1)).round
        end
      elsif start >= '01:00' && start < '06:00'
        if ending >= '00:00' && ending <= '01:00'
            self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (self.gen_t_diff('16:00'.to_time, ending.to_time) * self.ob_1)).round
        elsif ending > '01:00' && ending <= '06:00'
          if self.start_date == self.end_date
            self.ob_amount = ((self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
          elsif self.start_date < self.end_date
            self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (9 * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
          end
        elsif ending > '06:00' && ending <= '16:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2)).round
        elsif ending > '16:00' && ending <= '23:59'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (self.gen_t_diff('16:00'.to_time, ending.to_time) * self.ob_1)).round
        end
      elsif start >= '06:00' && start < '16:00'
        if ending > '06:00' && ending <= '16:00'
          if self.start_date == self.end_date
            self.ob_amount = 0
          elsif self.start_date < self.end_date
            self.ob_amount = ((9 * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2) + (self.gen_t_diff('06:00'.to_time, ending.to_time) * self.ob_1)).round
          end
        elsif ending > '16:00' && ending <= '23:59'
          if self.start_date == self.end_date
            self.ob_amount = ((self.gen_t_diff('16:00'.to_time, ending.to_time) * self.ob_1)).round
          elsif self.start_date < self.end_date
            self.ob_amount = ((9 * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2) + (self.gen_t_diff('06:00'.to_time, ending.to_time) * self.ob_1)).round
          end
        elsif ending >= '00:00' && ending <= '01:00'
          self.ob_amount = ((self.gen_t_diff('16:00'.to_time, ending.to_time) * self.ob_1)).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((9 * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        end
      end

    elsif ['Sunday'].include? self.start_date.strftime("%A")
      if start >= '00:00' && start < '01:00'
        if ending > '00:00' && ending <= '01:00'
          self.ob_amount = (self.generate_time_difference * self.ob_1).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        elsif ending > '06:00' && ending <= '23:59'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (5 * self.ob_2)).round
        end
      elsif start >= '01:00' && start < '06:00'
        if ending > '01:00' && ending <= '06:00'
          if self.start_date == self.end_date
            self.ob_amount = ((self.generate_time_difference * self.ob_1) + (self.generate_time_difference * self.ob_2)).round
          elsif self.start_date < self.end_date
            self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (19 * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
          end
        elsif ending > '06:00' && ending <= '23:59'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (self.gen_t_diff('06:00'.to_time, ending.to_time) * self.ob_1)).round
        elsif ending > '00:00' && ending <= '01:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (18 * self.ob_1) + (self.gen_t_diff('00:00'.to_time, ending.to_time) * self.ob_1)).round
        elsif ending == '00:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_1) + (self.gen_t_diff(start.to_time, '06:00'.to_time) * self.ob_2) + (18 * self.ob_1)).round
        end
      elsif start >= '06:00' && start <= '23:59'
        if ending > '06:00' && ending <= '23:59'
          if self.start_date == self.end_date
            self.ob_amount = (self.generate_time_difference * self.ob_1).round
          elsif self.start_date < self.end_date
            self.ob_amount = ((self.gen_t_diff(start.to_time, '00:00'.to_time) * self.ob_1) + (1 * self.ob_1) + (5 * self.ob_1) + (5 * self.ob_2)).round
          end
        elsif ending > '00:00' && ending <= '01:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '00:00'.to_time) * self.ob_1) + (self.gen_t_diff('00:00'.to_time, ending.to_time) * self.ob_1)).round
        elsif ending == '00:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '00:00'.to_time) * self.ob_1)).round
        elsif ending > '01:00' && ending <= '06:00'
          self.ob_amount = ((self.gen_t_diff(start.to_time, '00:00'.to_time) * self.ob_1) + (1 * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending.to_time) * self.ob_2)).round
        end
      end
    end
  end
end
