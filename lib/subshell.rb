require 'bash_command'

class Subshell
	def initialize(workspace)
		@workspace = workspace
	end

	def run(command)
		bash_command("cd #{@workspace} && #{command}")
	end
end