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

    def featureCheck name
        if name == "WiFi"
            "wifi"
        elsif name == "ADA Accessible"
            "wheelchair"
        elsif name == "Free Parking"
            "car"
        elsif name == "Paid Parking"
            "dollar sign"
        else
            ""
        end
    end

    def find_feature room, feature
        room.features.find_by(name: feature).present?
    end
    def user_friendly_range date
        return date.strftime("%B %d %Y")
    end

end
