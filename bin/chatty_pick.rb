require 'cherry_picker'

def cherry_pick_with_annotation(git_object_to_cherry_pick, target_branch)
	puts git_object_to_cherry_pick, target_branch

	CherryPicker.new(Dir.pwd).cherry_pick(:take => git_object_to_cherry_pick,
		:to => target_branch,
		:merge_message => "[merged from trunk]")
end

if __FILE__ == $0
	git_object_to_cherry_pick = ARGV[0]
	target_branch = ARGV[1]
	cherry_pick_with_annotation(git_object_to_cherry_pick, target_branch)
end