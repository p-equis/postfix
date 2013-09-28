class GitRepository
	def initialize(workspace)
		@workspace = workspace
	end

	def checkout_branch (name)
		run_in_subshell("git checkout #{name}")
	end

	def top_commit_message 
		run_in_subshell("git log -1 --pretty=format:'%s'")
	end

	def current_branch_name
		run_in_subshell("git rev-parse --abbrev-ref HEAD").strip
	end

	def run_in_subshell (command)
		subshell = Subshell.new @workspace
		subshell.run command
	end
end
