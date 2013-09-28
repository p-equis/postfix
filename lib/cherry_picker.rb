require 'subshell'
require 'append_to_commit_message'
require 'git_repository'

class CherryPicker
	def initialize(workspace)
		@git = GitRepository.new workspace
	end

	def cherry_pick (options)
		cherry = extract(options, :take)
		target_branch = extract(options, :to)
		merge_message = extract(options, :merge_message)

		original_branch = @git.current_branch_name

		@git.checkout_branch target_branch
		ENV["GIT_EDITOR"] = AppendToCommitMessage.create_script_command(merge_message)
		@git.run_in_subshell("git cherry-pick #{cherry} --edit")

		@git.checkout_branch original_branch
	end

	def extract(options, symbol)
		option = options[symbol]

		if option.nil?
			raise "Missing a required argument: '#{symbol}'"
		end

		option
	end
end