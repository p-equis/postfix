class CherryPicker
	def initialize(workspace)
		@workspace = workspace
	end

	def cherry_pick (options)
		cherry = options[:take]
		target_branch = options[:to]
		merge_message = options[:merge_message]

		checkout_branch target_branch
		ENV["GIT_EDITOR"] = "#{script} '#{merge_message}'"
		run_in_subshell("git cherry-pick #{cherry} --edit")
	end

	def script
		directory_of_this_file = File.expand_path(File.dirname(__FILE__))
		"sh #{directory_of_this_file}/show.sh "
	end

	def checkout_branch (name)
		run_in_subshell("git checkout #{name}")
	end

	def run_in_subshell (command)
		subshell = Subshell.new @workspace
		subshell.run command
	end
end