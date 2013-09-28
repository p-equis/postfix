def bash_command(command)
	output = `#{command}`
	raise "Bash command failed: #{command}" unless $?.success?
	output
end