class CherryPicker
	def initialize(workspace)
		@workspace = workspace
	end

	def cherry_pick (options)
		cherry = options[:take]
		target_branch = options[:to]
		merge_message = options[:merge_message]

		checkout_branch target_branch
		ENV["GIT_EDITOR"] = "sh #{Dir::pwd}/show.sh"
		run_in_subshell("git cherry-pick #{cherry} --edit")
	end


	def checkout_branch (name)
		run_in_subshell("git checkout #{name}")
	end

	def run_in_subshell (command)
		subshell = Subshell.new @workspace
		subshell.run command
	end
end