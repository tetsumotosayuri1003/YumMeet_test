module ApplicationHelper
  def flash_background_color(type)
    case type.to_sym
    when :notice then "bg-green-500"
    when :alert  then "bg-red-500"
    when :error  then "bg-yellow-500"
    when :success then "bg-blue-500" # この行を追加
    else "bg-gray-500"
    end
  end
end
