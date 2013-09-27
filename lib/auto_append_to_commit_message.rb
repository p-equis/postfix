def append_to_commit_message (merge_message, message_file)
	lines_without_comments = File.open(message_file, "r").lines.entries.reject { |line| line.start_with? "#" }

	File.open(message_file, "w") do |file|
		file.write(lines_without_comments.to_s + " " + merge_message)
	end
end

if __FILE__ == $0
	merge_message = ARGV[0]
	message_file = ARGV[1]
	append_to_commit_message(merge_message, message_file)
end