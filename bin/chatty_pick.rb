require 'cherry_picker'

git_object_to_cherry_pick = ARGV[0]
target_branch = ARGV[1]

CherryPicker.new(Dir.pwd).cherry_pick(:take => git_object_to_cherry_pick,
	:to => target_branch,
	:merge_message => "[merged from trunk]")