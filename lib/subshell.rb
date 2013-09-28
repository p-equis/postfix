class Subshell
	def initialize(workspace)
		@workspace = workspace
	end

	def run(command)
		bash_command("cd #{@workspace} && #{command}")
	end
end

def bash_command(command)
	output = `#{command}`
	raise "Bash command failed: #{command}" unless $?.success?
	output
end