class AppendToCommitMessage
	def self.create_script_command(message, git_message_file="")
		directory_of_this_file = File.expand_path(File.dirname(__FILE__))
		"sh #{directory_of_this_file}/append_to_commit_message.sh '#{message}' #{git_message_file}"
	end
end