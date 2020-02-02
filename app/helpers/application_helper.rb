module ApplicationHelper
    def remove_unwanted_words string
        bad_words = ["less than", "about"]
        bad_words.each do |bad|
          string.gsub!(bad + " ", '')
        end
        return string
    end

    def use_day_only date
        return date.day
    end

    def user_friendly_range date
        return date.strftime("%B %d %Y")
    end

end
