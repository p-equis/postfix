class Subshell
	def initialize(workspace)
		@workspace = workspace
	end

	def run(command)
		`(cd #{@workspace} && #{command})`
	end
end