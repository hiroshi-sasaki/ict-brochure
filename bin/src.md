# https://www.reddit.com/r/osx/comments/4gg3t3/batch_converting_powerpoint_2016_to_pdf_in/

on run {input, parameters}

tell application "Finder"
	
	set theItems to input
	
	repeat with itemRef in theItems
		set theItemParentPath to (container of itemRef) as text
		set theItemName to (name of itemRef) as string
		set theItemExtension to (name extension of itemRef)
		set theItemExtensionLength to (count theItemExtension) + 1
		set theOutputPath to theItemParentPath & (text 1 thru (-1 - theItemExtensionLength) of theItemName)
		
		tell application "Microsoft PowerPoint"
			open itemRef
			tell active presentation
				save in theOutputPath as save as PDF
				close
			end tell
		end tell
	end repeat
end tell

end run

# https://www.reddit.com/r/osx/comments/4gg3t3/batch_converting_powerpoint_2016_to_pdf_in/d8z3mjm/?utm_source=reddit&utm_medium=web2x&context=3

on run {input, parameters}

tell application "Finder"
	
	set theItems to input
	
	repeat with itemRef in theItems
		set theItemParentPath to (container of itemRef) as text
		set theItemName to (name of itemRef) as string
		set theItemName to theItemName
		set theItemExtension to (name extension of itemRef)
		set theItemExtensionLength to (count theItemExtension) + 1
		set theItemName to theItemParentPath & (text 1 thru (-1 - theItemExtensionLength) of theItemName)
		set theItemName to (theItemName & ".pdf")
		
		tell application "Microsoft Word"
			set default file path file path type documents path path theItemParentPath
			open itemRef
			delay 1
			set theActiveDocument to active document
			save as theActiveDocument file format format PDF file name theItemName
			close theActiveDocument
		end tell
	end repeat
end tell

end run
