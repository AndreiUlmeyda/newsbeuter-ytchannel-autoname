#! /bin/awk -f
# Automatically name youtube channel feeds in newsbeuter[1].
# Example usage after backing up your old urls file to "urls-bak":
# "./newsbeuter-ytchannel-autoname.awk ~/.newsbeuter/urls-bak > ~/.newsbeuter/urls"

# REQUIRES httpie[2] (and, well, awk and grep) being installed on your system.
# ASSUMES that the first line containing the string "<name>" in the html
# returned from the url is of the form: <name>Youtube Channel Name</name>

# ------------------------------------------------------------------------------

# Given a newsbeuter url file containing unnamed youtube channel feeds, for
# instance as obtained when exporting youtube subscriptions and importing to
# newsbeuter, fetch the respective channel names and then append the name to
# each line, for instance taking the line:
# https://www.youtube.com/feeds/videos.xml?channel_id=UCYO_jab_esuFRV4b17AJtAw
# to
# https://www.youtube.com/feeds/videos.xml?channel_id=UCYO_jab_esuFRV4b17AJtAw "~3Blue1Brown"
# as expected by newsbeuter.

# [1] github.com/akrennmair/newsbeuter
# [2] github.com/jkbrzt/httpie

{
	inputLine = $0
	emptyString = ""
	# only modify lines indicating a youtube channel feed
	if (/youtube.com\/feeds/)
		{
			# assemble a shell command to fetch the html document and search for
			# the first name tag
			url = $1
			pipe = " | "
			getHtml = "http " url
			nameTagFromHtml = "grep --max-count=1 \"<name>\""
			getNameTag = getHtml pipe nameTagFromHtml
			
			# execute said shell command
			nameTag = emptyString
			getNameTag | getline nameTag
			
			# remove leading and trailing white space
			gsub(/^[ \t]+/, emptyString, nameTag)
			gsub(/[ \t]+$/, emptyString, nameTag)
			
			# remove tag
			nameTagLength = length(nameTag)
			nameStartIndex = 7 # first char after "<name>"
			numberOfTagChars = 6 + 7 # number of chars in "<name></name>"
			nameLength = nameTagLength - numberOfTagChars
			name = substr(nameTag, nameStartIndex, nameLength)

			# format feed name
			feedName = "\"" "~" name "\""

			# append name to original line but avoid producing exact duplicates
			nameNotAlreadyPresent = match(inputLine, feedName) == 0
			if (nameNotAlreadyPresent)
				print inputLine, feedName
			else print inputLine
		}
	# leave all other lines untouched
	else print inputLine
}
