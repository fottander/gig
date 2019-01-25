class Shift < ApplicationRecord
  validates_presence_of :start_date, :end_date, :start_time, :end_time
  belongs_to :invoice, optional: true
  before_save :generate_time_difference

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
    23
  end

  def ob_2
    21
  end

  def generate_ob_hours
    start = self.start_time
    ending = self.end_time
    if start.strftime("%H:%M") >= '20:00' && start.strftime("%H:%M") < '23:59'
      if ending.strftime("%H:%M") >= '00:00' && ending.strftime("%H:%M") <= '01:00'
        self.generate_time_difference * self.ob_1
      elsif ending.strftime("%H:%M") <= '23:59'
        self.generate_ob_hours * self.ob_1
      elsif ending.strftime("%H:%M") > '01:00' && ending.strftime("%H:%M") <= '06:00'
        (self.gen_t_diff(start, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending) * self.ob_2)
      elsif ending.strftime("%H:%M") > '06:00'
        (self.gen_t_diff(start, '01:00'.to_time) * self.ob_1) + (5 * self.ob_2)
      end
    elsif start.strftime("%H:%M") >= '00:00' && start.strftime("%H:%M") <= '01:00'
      if ending.strftime("%H:%M") > '00:00' && ending.strftime("%H:%M") <= '01:00'
        self.generate_time_difference * self.ob_1
      elsif ending.strftime("%H:%M") > '01:00' && ending.strftime("%H:%M") <= '06:00'
        (self.gen_t_diff(start, '01:00'.to_time) * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending) * self.ob_2)
      elsif ending.strftime("%H:%M") > '06:00'
        (self.gen_t_diff(start, '01:00'.to_time) * self.ob_1) + (5 * self.ob_2)
      end
    elsif start.strftime("%H:%M") >= '01:00' && start.strftime("%H:%M") <= '06:00'
      if ending.strftime("%H:%M") <= '06:00'
        self.generate_time_difference * self.ob_2
      elsif ending.strftime("%H:%M") > '06:00'
        self.generate_time_difference * self.ob_2
      end
    elsif start.strftime("%H:%M") >= '06:00' && start.strftime("%H:%M") <= '20:00'
      if ending.strftime("%H:%M") > '20:00' && ending.strftime("%H:%M") <= '23:59'
        self.gen_t_diff('20:00'.to_time, ending) * self.ob_1
      elsif ending.strftime("%H:%M") >= '00:00' && ending.strftime("%H:%M") <= '23:59'
        self.gen_t_diff('20:00'.to_time, ending) * self.ob_1
      elsif ending.strftime("%H:%M") > '01:00' && ending.strftime("%H:%M") <= '01:00'
        (5 * self.ob_1) + (self.gen_t_diff('01:00'.to_time, ending) * self.ob_2)
      elsif ending.strftime("%H:%M") > '06:00'
        (5 * self.ob_1) + (5 * self.ob_2)
      end
    end
  end
end
