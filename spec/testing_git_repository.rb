require 'git_repository'

class TestingGitRepository < GitRepository
	def initialize
		@workspace = Dir::pwd + "/workspace"
		@file_id = 1
		destroy
		Dir::mkdir @workspace
		run_in_subshell("git init")
	end

	def destroy
		FileUtils.rm_rf @workspace
	end

	def create_commit (message)
		file_name = "#{@file_id}.txt"
		@file_id += 1
		run_in_subshell("touch #{file_name}")
		run_in_subshell("git add #{file_name}")
		run_in_subshell("git commit -m '#{message}'")
	end

	def create_branch (name)
		run_in_subshell("git branch #{name}")
	end

	def cherry_pick (options)
		cherry_picker = CherryPicker.new @workspace
		cherry_picker.cherry_pick options
	end
end