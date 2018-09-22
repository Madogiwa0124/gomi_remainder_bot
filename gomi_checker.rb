class GomiChecker
  require 'date'
  require_relative 'date_patch'

  def self.target_day
    @target_day ||= Date.tomorrow
  end

  def self.burnable_garbage?
    target_day.tuesday? || target_day.friday?
  end

  def self.recyclable_garbage?
    target_day.monday?
  end

  def self.bottle_can_garbage?
    target_day.monday?
  end

  def self.not_burnable_garbage?
    now = target_day
    now.saturday? && now.mweek == 2
  end

  def self.check
    return :burnable_garbage     if burnable_garbage?
    return :recyclable_garbage   if recyclable_garbage?
    return :bottle_can_garbage   if bottle_can_garbage?
    return :not_burnable_garbage if not_burnable_garbage?
    :none
  end

  def self.notice_message
    message = case check
    when :burnable_garbage     then '燃えるゴミの日です'
    when :recyclable_garbage   then '資源ごみ(古紙)の日です'
    when :bottle_can_garbage   then '缶・ビンの日です'
    when :not_burnable_garbage then '不燃ごみの日です'
    else '特に出せるゴミはありません'
    end
    "明日(#{target_day.strftime("%m月%d日 %a")})は、#{message}"
  end
end
